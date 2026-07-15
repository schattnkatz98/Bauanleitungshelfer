using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Interop;
using Microsoft.Data.Sqlite;


namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    /// 

    public partial class MainWindow : Window
    {
        private readonly List<RecipeCard> recipeCards = new();
        //private List<ItemCard> itemCards = new List<ItemCard>();
        private readonly ObservableCollection<InventoryItem> inventoryItems = new();
        //private List<string> items = new List<string>();
        public MainWindow()
        {
            InitializeComponent();

            string sql = File.ReadAllText("schema.sql");
            using SqliteConnection connection = new SqliteConnection("Data Source=bauplan.db");
            connection.Open();

            using SqliteCommand command = new SqliteCommand(sql, connection);
            command.CommandText = sql;
            command.ExecuteNonQuery();

            Debug.WriteLine("Datenbank initialisiert!");

            CreateCards(connection);
            //Debug.WriteLine(string.Join(", ", items));
            Debug.WriteLine("cards createt");
        }

        private void LoadItemCards(SqliteConnection connection)
        {
            inventoryItems.Clear();

            using SqliteCommand cmd = connection.CreateCommand();
            cmd.CommandText = "SELECT id, name from item";

            using SqliteDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                inventoryItems.Add(new InventoryItem
                {
                    Id = Convert.ToInt32(reader["id"]),
                    Name = reader["name"].ToString() ?? "",
                    Amount = 0
                });

            }

            foreach (InventoryItem item in inventoryItems)
            {
                Debug.WriteLine($"{item.Name}, Amount: {item.Amount}");
            }


            InventoryItemsControl.ItemsSource = inventoryItems;
        }

        private void LoadBuildSetCards(SqliteConnection connection)
        {
            Dictionary<int, RecipeCard> recipeMap = new();

            using SqliteCommand cmd = connection.CreateCommand();
            cmd.CommandText = @"
            SELECT 
                r.id AS recipe_id,
                ri.name AS recipe_name,
                ci.id AS component_id,
                ci.name AS component_name,
                rc.component_amount AS required_amount
            FROM recipe_components AS rc
            INNER JOIN recipe AS r ON rc.recipe = r.id
            INNER JOIN item AS ri ON r.result = ri.id
            INNER JOIN item AS ci ON rc.component = ci.id
            ORDER BY r.id;";

            using SqliteDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                int recipeId = Convert.ToInt32(reader["recipe_id"].ToString());
                string ItemName = reader["recipe_name"].ToString();


                if (!recipeMap.ContainsKey(recipeId))
                {
                    RecipeCard card = new RecipeCard
                    {
                        Name = ItemName
                    };

                    recipeMap.Add(recipeId, card);
                    recipeCards.Add(card);
                }

                recipeMap[recipeId].Materials.Add(new RecipeMaterial
                {
                    ItemId = Convert.ToInt32(reader["component_id"]),
                    Name = reader["component_name"].ToString() ?? "",
                    RequiredAmount = Convert.ToInt32(reader["required_amount"])
                });

            }
        }

        private void RefreshRecipeMaterialStatus()
        {
            foreach (RecipeCard recipe in recipeCards)
            {
                foreach (RecipeMaterial material in recipe.Materials)
                {
                    InventoryItem? ownedItem = inventoryItems
                        .FirstOrDefault(item => item.Id == material.ItemId);

                    material.OwnedAmount = ownedItem?.Amount ?? 0;
                }

                recipe.RefreshCoverage();
            }

            RefreshRecipeSummary();
        }

        private void IncreaseAmount_Click(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            InventoryItem item = (InventoryItem)button.DataContext;
            item.Amount++;
            RefreshRecipeMaterialStatus();
            RefreshProfileStats();
        }

        private void DecreaseAmount_Click(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            InventoryItem item = (InventoryItem)button.DataContext;

            if (item.Amount > 0)
            {
                item.Amount--;
            }
            RefreshRecipeMaterialStatus();
            RefreshProfileStats();
        }

        private void RefreshProfileStats()
        {
            var ownedItems = inventoryItems
                .Where(item => item.Amount > 0)
                .ToList();

            ProfileInventoryControl.ItemsSource = ownedItems;

            int totalAmount = ownedItems.Sum(item => item.Amount);

            InventoryItem? mostCommonItem = ownedItems
                .OrderByDescending(item => item.Amount)
                .FirstOrDefault();

            InventoryItem? rarestItem = ownedItems
                .OrderBy(item => item.Amount)
                .FirstOrDefault();

            TotalOwnedText.Text = totalAmount.ToString();

            if (mostCommonItem != null)
            {
                MostCommonItemText.Text = mostCommonItem.Name;
                MostCommonAmountText.Text = mostCommonItem.Amount + "x";
            }
            else
            {
                MostCommonItemText.Text = "-";
                MostCommonAmountText.Text = "0x";
            }

            if (rarestItem != null)
            {
                RarestItemText.Text = rarestItem.Name;
                RarestAmountText.Text = rarestItem.Amount + "x";
            }
            else
            {
                RarestItemText.Text = "-";
                RarestAmountText.Text = "0x";
            }
        }




        private void CreateCards(SqliteConnection connection)
        {
            LoadBuildSetCards(connection);
            LoadItemCards(connection);
            RefreshRecipeMaterialStatus();
            RecipeCardsControl.ItemsSource = recipeCards;
            RefreshRecipeSummary();
        }

        private void ResetOwnedItems()
        {
            foreach (InventoryItem item in inventoryItems)
            {
                item.Amount++;
            }
            RefreshRecipeMaterialStatus();
            RefreshProfileStats();
        }

        private void Window_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (Keyboard.Modifiers == ModifierKeys.Control && e.Key == Key.F)
            {
                SearchBox.Focus();
                SearchBox.SelectAll();
                e.Handled = true;
            }

            if (e.Key == Key.F)
            {
                ResetOwnedItems();
                e.Handled = true;
            }
        }

        private void SearchBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            ApplyRecipeFilter();
        }

        private void SearchBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                ApplyRecipeFilter();
            }

            if (e.Key == Key.Escape)
            {
                SearchBox.Text = string.Empty;
                ApplyRecipeFilter();
            }
        }

        private void ApplyRecipeFilter()
        {
            string searchText = SearchBox.Text.Trim();

            List<RecipeCard> filteredRecipes = recipeCards
                .Where(recipe => string.IsNullOrWhiteSpace(searchText)
                    || recipe.Name.Contains(searchText, StringComparison.CurrentCultureIgnoreCase))
                .ToList();

            RecipeCardsControl.ItemsSource = filteredRecipes;
            ResultCountText.Text = $"{filteredRecipes.Count} Ergebnisse";
        }

        private void RefreshRecipeSummary()
        {
            RecipeCountText.Text = recipeCards.Count.ToString();
            BuildableCountText.Text = recipeCards.Count(recipe => recipe.IsBuildable).ToString();
            MaterialCountText.Text = recipeCards
                .SelectMany(recipe => recipe.Materials)
                .Select(material => material.ItemId)
                .Distinct()
                .Count()
                .ToString();

            ResultCountText.Text = $"{recipeCards.Count} Ergebnisse";
        }

        private void TitleBar_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ClickCount == 2)
            {
                ToggleWindowState();
                return;
            }

            DragMove();
        }

        private void MinimizeButton_Click(object sender, RoutedEventArgs e)
        {
            WindowState = WindowState.Minimized;
        }

        private void MaximizeButton_Click(object sender, RoutedEventArgs e)
        {
            ToggleWindowState();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void ToggleWindowState()
        {
            WindowState = WindowState == WindowState.Maximized
                ? WindowState.Normal
                : WindowState.Maximized;
        }

        private void SidebarButton_Click(object sender, RoutedEventArgs e)
        {
            Button clickedButton = (Button)sender;
            //Debug.WriteLine(clickedButton.Content + " clicked!");
            string page = clickedButton.Tag?.ToString() ?? "";
            ShowView(page);
        }

        private void ShowView(string page)
        {
            BauteileView.Visibility = Visibility.Collapsed;
            ProfilView.Visibility = Visibility.Collapsed;
            AnleitungenView.Visibility = Visibility.Collapsed;
            EinstellungenView.Visibility = Visibility.Collapsed;

            switch (page)
            {
                case "Bauteile":
                    BauteileView.Visibility = Visibility.Visible;
                    Debug.WriteLine("Home view shown");
                    break;
                case "Profil":
                    RefreshProfileStats();
                    ProfilView.Visibility = Visibility.Visible;
                    Debug.WriteLine("profil view shown");
                    break;
                case "Anleitungen":
                    AnleitungenView.Visibility = Visibility.Visible;
                    Debug.WriteLine("anleitungen view shown");
                    break;
                case "Einstellungen":
                    EinstellungenView.Visibility = Visibility.Visible;
                    Debug.WriteLine("einstellungen view shown");
                    break;

            }
        }

        [DllImport("dwmapi.dll")]
        private static extern int DwmSetWindowAttribute(
        IntPtr hwnd,
        int attribute,
        ref int value,
        int size);

        private void Window_SourceInitialized(object? sender, EventArgs e)
        {
            IntPtr hwnd = new WindowInteropHelper(this).Handle;

            int roundCorners = 2;

            DwmSetWindowAttribute(
                hwnd,
                33,
                ref roundCorners,
                sizeof(int));
        }

        public class RecipeCard : INotifyPropertyChanged
        {
            public string Name { get; set; } = "";
            public List<RecipeMaterial> Materials { get; set; } = new();

            public int CoveredMaterialCount => Materials.Count(material => material.IsCovered);
            public int MaterialCount => Materials.Count;
            public bool IsBuildable => MaterialCount > 0 && CoveredMaterialCount == MaterialCount;
            public double CoveragePercent
            {
                get
                {
                    int requiredTotal = Materials.Sum(material => material.RequiredAmount);

                    if (requiredTotal == 0)
                        return 0;

                    int coveredTotal = Materials.Sum(material =>
                        Math.Min(material.OwnedAmount, material.RequiredAmount));

                    return (double)coveredTotal / requiredTotal * 100;
                }
            }
            public string CoveragePercentText => $"{Math.Round(CoveragePercent)}%";
            public string CoverageText => $"{CoveredMaterialCount}/{MaterialCount} vorhanden";
            public string StatusText => IsBuildable ? "Baubar" : CoverageText;
            public string MaterialCountText => $"{MaterialCount} Materialien";

            public void RefreshCoverage()
            {
                OnPropertyChanged(nameof(CoveredMaterialCount));
                OnPropertyChanged(nameof(MaterialCount));
                OnPropertyChanged(nameof(IsBuildable));
                OnPropertyChanged(nameof(CoveragePercent));
                OnPropertyChanged(nameof(CoveragePercentText));
                OnPropertyChanged(nameof(CoverageText));
                OnPropertyChanged(nameof(StatusText));
                OnPropertyChanged(nameof(MaterialCountText));
            }

            private void OnPropertyChanged(string propertyName)
            {
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
            }

            public event PropertyChangedEventHandler? PropertyChanged;
        }

        public class RecipeMaterial : INotifyPropertyChanged
        {
            public int ItemId { get; set; }
            public string Name { get; set; } = "";
            public int RequiredAmount { get; set; }

            private bool isCovered;
            private int ownedAmount;

            public int OwnedAmount
            {
                get => ownedAmount;
                set
                {
                    if (ownedAmount == value)
                    {
                        return;
                    }

                    ownedAmount = value;
                    IsCovered = ownedAmount >= RequiredAmount;
                    OnPropertyChanged(nameof(OwnedAmount));
                    OnPropertyChanged(nameof(AmountText));
                }
            }

            public bool IsCovered
            {
                get => isCovered;
                set
                {
                    if (isCovered == value)
                    {
                        return;
                    }

                    isCovered = value;
                    OnPropertyChanged(nameof(IsCovered));
                }
            }

            public string DisplayText => $"- {RequiredAmount}x | {Name}";
            public string AmountText => $"{OwnedAmount} / {RequiredAmount}";

            private void OnPropertyChanged(string propertyName)
            {
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
            }

            public event PropertyChangedEventHandler? PropertyChanged;
        }

        //public class ItemCard
        //{
        //    public string Name { get; set; } = "";
        //    public string Info { get; set; } = "";
        //}




        public class InventoryItem : INotifyPropertyChanged
        {
            public int Id { get; set; }
            public string Name { get; set; } = "";

            private int amount;

            public int Amount
            {
                get => amount;
                set
                {
                    amount = value;
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Amount)));
                }
            }
            public event PropertyChangedEventHandler? PropertyChanged;

        }
    }
}
