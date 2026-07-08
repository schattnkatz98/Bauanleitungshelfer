using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Diagnostics;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using Microsoft.Data.Sqlite;


namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    /// 

    public partial class MainWindow : Window
    {
        private List<RecipeCard> recipeCards = new List<RecipeCard>();
        //private List<ItemCard> itemCards = new List<ItemCard>();
        private ObservableCollection<InventoryItem> inventoryItems = new ObservableCollection<InventoryItem>();
        //private List<string> items = new List<string>();
        private int i = 0;

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
            using SqliteCommand cmd = connection.CreateCommand();
            cmd.CommandText = "SELECT \r\n    ri.name AS result_Item,\r\n    GROUP_CONCAT('- ' || rc.component_amount || 'x | ' || ci.name, CHAR(10)) AS component_items\r\nFROM recipe_components AS rc\r\nINNER JOIN recipe AS r ON rc.recipe = r.id\r\nINNER JOIN item AS ri ON r.result = ri.id\r\nINNER JOIN item AS ci ON rc.component = ci.id\r\nGROUP BY r.id, ri.name;";
            using SqliteDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                string ItemName = reader["result_Item"].ToString();
                string ItemMaterials = reader["component_items"].ToString();

                recipeCards.Add(new RecipeCard
                {
                    Name = $"{ItemName}",
                    Materials = $"{ItemMaterials}"
                });

                i++;
            }
        }

        private void IncreaseAmount_Click(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            InventoryItem item = (InventoryItem)button.DataContext;
            item.Amount++;
        }

        private void DecreaseAmount_Click(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            InventoryItem item = (InventoryItem)button.DataContext;

            if (item.Amount > 0)
            {
                item.Amount--;
            }
        }

        private void CreateCards(SqliteConnection connection)
        {
            LoadBuildSetCards(connection);
            LoadItemCards(connection);
            RecipeCardsControl.ItemsSource = recipeCards;
        }

        private void SearchBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                Debug.WriteLine("Search: " + SearchBox.Text);
            }

            if (e.Key == Key.Escape)
            {
                SearchBox.Text = string.Empty;
                Debug.WriteLine("Search cleared");
            }
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

        public class RecipeCard
        {
            public string Name { get; set; } = "";
            public string Materials { get; set; } = "";
        }

        //public class ItemCard
        //{
        //    public string Name { get; set; } = "";
        //    public string Info { get; set; } = "";
        //}

        public class InventoryItem : INotifyPropertyChanged
        {
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