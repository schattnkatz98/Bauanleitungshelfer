-- Bauanleitungshelfer Datenbank Schema
-- Erstellt: 2026-01-22

-- Datenbank erstellen (optional, abhängig vom DBMS)
-- CREATE DATABASE IF NOT EXISTS bauanleitungshelfer;
-- USE bauanleitungshelfer;

-- Tabellen löschen falls sie existieren (für sauberes Neuerstellen)
DROP TABLE IF EXISTS recipe_components;
DROP TABLE IF EXISTS recipe;
DROP TABLE IF EXISTS item;

-- Tabelle: item
-- Speichert alle Items (Rohmaterialien und herstellbare Items)
CREATE TABLE item (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tabelle: recipe
-- Speichert Bauanleitungen mit Ergebnis und Ausgabemenge
CREATE TABLE recipe (
    id INTEGER PRIMARY KEY,
    result INTEGER NOT NULL,
    yield INTEGER NOT NULL,
    FOREIGN KEY (result) REFERENCES item(id)
);

-- Tabelle: recipe_components
-- Speichert die Komponenten/Zutaten für jede Bauanleitung
CREATE TABLE recipe_components (
    id INTEGER PRIMARY KEY,
    recipe INTEGER NOT NULL,
    component INTEGER NOT NULL,
    component_amount INTEGER NOT NULL,
    FOREIGN KEY (recipe) REFERENCES recipe(id),
    FOREIGN KEY (component) REFERENCES item(id)
);

-- Beispieldaten einfügen - LEGO Bausteine und Sets
-- Items - LEGO Bausteine (Rohmaterialien) - 50 Stück
-- Grundsteine verschiedene Größen und Farben
INSERT INTO item (id, name) VALUES (1, '2x4 Stein Rot');
INSERT INTO item (id, name) VALUES (2, '2x4 Stein Blau');
INSERT INTO item (id, name) VALUES (3, '2x4 Stein Gelb');
INSERT INTO item (id, name) VALUES (4, '2x4 Stein Grün');
INSERT INTO item (id, name) VALUES (5, '2x4 Stein Weiß');
INSERT INTO item (id, name) VALUES (6, '2x4 Stein Schwarz');
INSERT INTO item (id, name) VALUES (7, '2x2 Stein Rot');
INSERT INTO item (id, name) VALUES (8, '2x2 Stein Blau');
INSERT INTO item (id, name) VALUES (9, '2x2 Stein Gelb');
INSERT INTO item (id, name) VALUES (10, '2x2 Stein Grün');
INSERT INTO item (id, name) VALUES (11, '2x2 Stein Weiß');
INSERT INTO item (id, name) VALUES (12, '2x2 Stein Schwarz');
INSERT INTO item (id, name) VALUES (13, '1x2 Stein Rot');
INSERT INTO item (id, name) VALUES (14, '1x2 Stein Blau');
INSERT INTO item (id, name) VALUES (15, '1x2 Stein Gelb');
INSERT INTO item (id, name) VALUES (16, '1x2 Stein Weiß');
INSERT INTO item (id, name) VALUES (17, '1x4 Stein Grau');
INSERT INTO item (id, name) VALUES (18, '1x4 Stein Braun');
INSERT INTO item (id, name) VALUES (19, '1x1 Stein Rot');
INSERT INTO item (id, name) VALUES (20, '1x1 Stein Transparent');
-- Platten
INSERT INTO item (id, name) VALUES (21, '2x2 Platte Grün');
INSERT INTO item (id, name) VALUES (22, '2x4 Platte Grau');
INSERT INTO item (id, name) VALUES (23, '4x4 Platte Tan');
INSERT INTO item (id, name) VALUES (24, '6x6 Platte Grün');
INSERT INTO item (id, name) VALUES (25, '8x8 Platte Grau');
-- Dachsteine und Schrägsteine
INSERT INTO item (id, name) VALUES (26, 'Dachstein 2x2 Rot');
INSERT INTO item (id, name) VALUES (27, 'Dachstein 2x2 Grau');
INSERT INTO item (id, name) VALUES (28, 'Schrägstein 1x2 Weiß');
INSERT INTO item (id, name) VALUES (29, 'Schrägstein 2x2 Gelb');
-- Fenster und Türen
INSERT INTO item (id, name) VALUES (30, 'Fenster 1x2x2 Klar');
INSERT INTO item (id, name) VALUES (31, 'Fenster 1x4x3 Klar');
INSERT INTO item (id, name) VALUES (32, 'Tür 1x4x6 Braun');
INSERT INTO item (id, name) VALUES (33, 'Tür 1x4x6 Weiß');
-- Räder und Achsen
INSERT INTO item (id, name) VALUES (34, 'Rad Klein Schwarz');
INSERT INTO item (id, name) VALUES (35, 'Rad Groß Schwarz');
INSERT INTO item (id, name) VALUES (36, 'Achse 2 Noppen');
INSERT INTO item (id, name) VALUES (37, 'Achse 4 Noppen');
-- Spezialteile
INSERT INTO item (id, name) VALUES (38, 'Rundstein 1x1 Transparent');
INSERT INTO item (id, name) VALUES (39, 'Rundstein 2x2 Weiß');
INSERT INTO item (id, name) VALUES (40, 'Fliese 1x2 Rot');
INSERT INTO item (id, name) VALUES (41, 'Fliese 2x2 Gelb');
INSERT INTO item (id, name) VALUES (42, 'Zaun 1x4x2 Weiß');
INSERT INTO item (id, name) VALUES (43, 'Blume 1x1 Rot');
INSERT INTO item (id, name) VALUES (44, 'Baum Krone 4x4 Grün');
INSERT INTO item (id, name) VALUES (45, 'Lenkrad Schwarz');
INSERT INTO item (id, name) VALUES (46, 'Sitz 2x2 Rot');
INSERT INTO item (id, name) VALUES (47, 'Dach 4x4 Transparent');
INSERT INTO item (id, name) VALUES (48, 'Scheinwerfer 1x1 Gelb');
INSERT INTO item (id, name) VALUES (49, 'Minifigur Torso');
INSERT INTO item (id, name) VALUES (50, 'Minifigur Beine');

-- LEGO Sets (25 Sets)
INSERT INTO item (id, name) VALUES (100, 'Kleines Haus');
INSERT INTO item (id, name) VALUES (101, 'Baum');
INSERT INTO item (id, name) VALUES (102, 'Zaun');
INSERT INTO item (id, name) VALUES (103, 'Auto');
INSERT INTO item (id, name) VALUES (104, 'Turm');
INSERT INTO item (id, name) VALUES (105, 'Brücke');
INSERT INTO item (id, name) VALUES (106, 'Garage');
INSERT INTO item (id, name) VALUES (107, 'Blumenbeet');
INSERT INTO item (id, name) VALUES (108, 'Laterne');
INSERT INTO item (id, name) VALUES (109, 'Bus');
INSERT INTO item (id, name) VALUES (110, 'Laden');
INSERT INTO item (id, name) VALUES (111, 'Bank');
INSERT INTO item (id, name) VALUES (112, 'Brunnen');
INSERT INTO item (id, name) VALUES (113, 'Straßenschild');
INSERT INTO item (id, name) VALUES (114, 'Fahrrad');
INSERT INTO item (id, name) VALUES (115, 'Parkbank');
INSERT INTO item (id, name) VALUES (116, 'Feuerwehrauto');
INSERT INTO item (id, name) VALUES (117, 'Polizeiauto');
INSERT INTO item (id, name) VALUES (118, 'Schule');
INSERT INTO item (id, name) VALUES (119, 'Rathaus');
INSERT INTO item (id, name) VALUES (120, 'Apartment');
INSERT INTO item (id, name) VALUES (121, 'Café');
INSERT INTO item (id, name) VALUES (122, 'Park Tor');
INSERT INTO item (id, name) VALUES (123, 'Bushaltestelle');
INSERT INTO item (id, name) VALUES (124, 'Minifigur');


-- LEGO Szenen (5 Szenen aus Sets)
INSERT INTO item (id, name) VALUES (200, 'Stadtszene');
INSERT INTO item (id, name) VALUES (201, 'Park Szene');
INSERT INTO item (id, name) VALUES (202, 'Notdienst Szene');
INSERT INTO item (id, name) VALUES (203, 'Wohnviertel Szene');
INSERT INTO item (id, name) VALUES (204, 'Stadtzentrum Szene');

-- Rezepte (Bauanleitungen) - 25 LEGO Sets
INSERT INTO recipe (id, result, yield) VALUES (1, 100, 1);   -- Kleines Haus
INSERT INTO recipe (id, result, yield) VALUES (2, 101, 1);   -- Baum
INSERT INTO recipe (id, result, yield) VALUES (3, 102, 1);   -- Zaun
INSERT INTO recipe (id, result, yield) VALUES (4, 103, 1);   -- Auto
INSERT INTO recipe (id, result, yield) VALUES (5, 104, 1);   -- Turm
INSERT INTO recipe (id, result, yield) VALUES (6, 105, 1);   -- Brücke
INSERT INTO recipe (id, result, yield) VALUES (7, 106, 1);   -- Garage
INSERT INTO recipe (id, result, yield) VALUES (8, 107, 1);   -- Blumenbeet
INSERT INTO recipe (id, result, yield) VALUES (9, 108, 1);   -- Laterne
INSERT INTO recipe (id, result, yield) VALUES (10, 109, 1);  -- Bus
INSERT INTO recipe (id, result, yield) VALUES (11, 110, 1);  -- Laden
INSERT INTO recipe (id, result, yield) VALUES (12, 111, 1);  -- Bank
INSERT INTO recipe (id, result, yield) VALUES (13, 112, 1);  -- Brunnen
INSERT INTO recipe (id, result, yield) VALUES (14, 113, 1);  -- Straßenschild
INSERT INTO recipe (id, result, yield) VALUES (15, 114, 1);  -- Fahrrad
INSERT INTO recipe (id, result, yield) VALUES (16, 115, 1);  -- Parkbank
INSERT INTO recipe (id, result, yield) VALUES (17, 116, 1);  -- Feuerwehrauto
INSERT INTO recipe (id, result, yield) VALUES (18, 117, 1);  -- Polizeiauto
INSERT INTO recipe (id, result, yield) VALUES (19, 118, 1);  -- Schule
INSERT INTO recipe (id, result, yield) VALUES (20, 119, 1);  -- Rathaus
INSERT INTO recipe (id, result, yield) VALUES (21, 120, 1);  -- Apartment
INSERT INTO recipe (id, result, yield) VALUES (22, 121, 1);  -- Café
INSERT INTO recipe (id, result, yield) VALUES (23, 122, 1);  -- Park Tor
INSERT INTO recipe (id, result, yield) VALUES (24, 123, 1);  -- Bushaltestelle
INSERT INTO recipe (id, result, yield) VALUES (25, 124, 1);  -- Minifigur

-- Rezepte für Szenen (5 Szenen)
INSERT INTO recipe (id, result, yield) VALUES (26, 200, 1);  -- Stadtszene
INSERT INTO recipe (id, result, yield) VALUES (27, 201, 1);  -- Park Szene
INSERT INTO recipe (id, result, yield) VALUES (28, 202, 1);  -- Notdienst Szene
INSERT INTO recipe (id, result, yield) VALUES (29, 203, 1);  -- Wohnviertel Szene
INSERT INTO recipe (id, result, yield) VALUES (30, 204, 1);  -- Stadtzentrum Szene

-- Rezept-Komponenten - Bausteine für LEGO Sets
-- Rezept 1: Kleines Haus
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (1, 1, 1, 12);   -- 12x 2x4 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (2, 1, 7, 8);    -- 8x 2x2 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (3, 1, 16, 6);   -- 6x 1x2 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (4, 1, 30, 2);   -- 2x Fenster
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (5, 1, 32, 1);   -- 1x Tür
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (6, 1, 26, 8);   -- 8x Dachstein Rot

-- Rezept 2: Baum
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (7, 2, 18, 4);   -- 4x 1x4 Braun (Stamm)
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (8, 2, 44, 1);   -- 1x Baumkrone

-- Rezept 3: Zaun
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (9, 3, 42, 5);   -- 5x Zaun 1x4x2

-- Rezept 4: Auto
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (10, 4, 2, 6);   -- 6x 2x4 Blau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (11, 4, 8, 4);   -- 4x 2x2 Blau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (12, 4, 34, 4);  -- 4x Rad Klein
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (13, 4, 36, 2);  -- 2x Achse
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (14, 4, 48, 2);  -- 2x Scheinwerfer
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (15, 4, 45, 1);  -- 1x Lenkrad

-- Rezept 5: Turm
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (16, 5, 1, 20);  -- 20x 2x4 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (17, 5, 7, 15);  -- 15x 2x2 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (18, 5, 12, 10); -- 10x 2x2 Schwarz
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (19, 5, 30, 3);  -- 3x Fenster

-- Rezept 6: Brücke
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (20, 6, 17, 20); -- 20x 1x4 Grau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (21, 6, 22, 8);  -- 8x 2x4 Platte Grau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (22, 6, 12, 6);  -- 6x 2x2 Schwarz

-- Rezept 7: Garage
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (23, 7, 1, 15);  -- 15x 2x4 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (24, 7, 17, 10); -- 10x 1x4 Grau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (25, 7, 33, 1);  -- 1x Tür Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (26, 7, 27, 6);  -- 6x Dachstein Grau

-- Rezept 8: Blumenbeet
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (27, 8, 21, 12); -- 12x 2x2 Platte Grün
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (28, 8, 43, 8);  -- 8x Blume Rot

-- Rezept 9: Laterne
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (29, 9, 12, 4);  -- 4x 2x2 Schwarz
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (30, 9, 38, 3);  -- 3x Rundstein Transparent
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (31, 9, 3, 1);   -- 1x 2x4 Gelb

-- Rezept 10: Bus
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (32, 10, 3, 10);  -- 10x 2x4 Gelb
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (33, 10, 9, 6);   -- 6x 2x2 Gelb
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (34, 10, 35, 6);  -- 6x Rad Groß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (35, 10, 37, 3);  -- 3x Achse 4 Noppen
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (36, 10, 31, 4);  -- 4x Fenster groß

-- Rezept 11: Laden
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (37, 11, 5, 20);  -- 20x 2x4 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (38, 11, 11, 10); -- 10x 2x2 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (39, 11, 30, 3);  -- 3x Fenster
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (40, 11, 32, 1);  -- 1x Tür
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (41, 11, 26, 10); -- 10x Dachstein

-- Rezept 12: Bank
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (42, 12, 16, 15); -- 15x 1x2 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (43, 12, 18, 8);  -- 8x 1x4 Braun

-- Rezept 13: Brunnen
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (44, 13, 11, 12); -- 12x 2x2 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (45, 13, 39, 4);  -- 4x Rundstein Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (46, 13, 20, 6);  -- 6x 1x1 Transparent

-- Rezept 14: Straßenschild
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (47, 14, 12, 3);  -- 3x 2x2 Schwarz
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (48, 14, 40, 2);  -- 2x Fliese Rot

-- Rezept 15: Fahrrad
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (49, 15, 34, 2);  -- 2x Rad Klein
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (50, 15, 36, 1);  -- 1x Achse
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (51, 15, 13, 4);  -- 4x 1x2 Rot

-- Rezept 16: Parkbank
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (52, 16, 18, 4);  -- 4x 1x4 Braun
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (53, 16, 16, 2);  -- 2x 1x2 Weiß

-- Rezept 17: Feuerwehrauto
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (54, 17, 1, 15);  -- 15x 2x4 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (55, 17, 7, 8);   -- 8x 2x2 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (56, 17, 35, 6);  -- 6x Rad Groß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (57, 17, 37, 3);  -- 3x Achse 4 Noppen
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (58, 17, 48, 2);  -- 2x Scheinwerfer

-- Rezept 18: Polizeiauto
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (59, 18, 2, 12);  -- 12x 2x4 Blau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (60, 18, 8, 6);   -- 6x 2x2 Blau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (61, 18, 35, 4);  -- 4x Rad Groß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (62, 18, 37, 2);  -- 2x Achse 4 Noppen
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (63, 18, 38, 2);  -- 2x Rundstein Transparent (Blaulicht)

-- Rezept 19: Schule
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (64, 19, 1, 30);  -- 30x 2x4 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (65, 19, 7, 20);  -- 20x 2x2 Rot
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (66, 19, 30, 6);  -- 6x Fenster
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (67, 19, 32, 2);  -- 2x Tür
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (68, 19, 26, 15); -- 15x Dachstein

-- Rezept 20: Rathaus
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (69, 20, 5, 40);  -- 40x 2x4 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (70, 20, 11, 25); -- 25x 2x2 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (71, 20, 31, 8);  -- 8x Fenster groß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (72, 20, 33, 2);  -- 2x Tür Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (73, 20, 27, 20); -- 20x Dachstein Grau

-- Rezept 21: Apartment
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (74, 21, 3, 25);  -- 25x 2x4 Gelb
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (75, 21, 9, 15);  -- 15x 2x2 Gelb
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (76, 21, 30, 8);  -- 8x Fenster
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (77, 21, 32, 1);  -- 1x Tür

-- Rezept 22: Café
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (78, 22, 18, 20); -- 20x 1x4 Braun
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (79, 22, 5, 15);  -- 15x 2x4 Weiß
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (80, 22, 30, 4);  -- 4x Fenster
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (81, 22, 32, 1);  -- 1x Tür
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (82, 22, 47, 1);  -- 1x Dach Transparent

-- Rezept 23: Park Tor
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (83, 23, 4, 8);   -- 8x 2x4 Grün
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (84, 23, 18, 6);  -- 6x 1x4 Braun

-- Rezept 24: Bushaltestelle
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (85, 24, 17, 10); -- 10x 1x4 Grau
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (86, 24, 47, 1);  -- 1x Dach Transparent
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (87, 24, 11, 4);  -- 4x 2x2 Weiß

-- Rezept 25: Minifigur
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (88, 25, 49, 1);  -- 1x Torso
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (89, 25, 50, 1);  -- 1x Beine
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (90, 25, 19, 1);  -- 1x 1x1 Rot (Kopf)

-- Szenen-Rezepte (aus Sets zusammengesetzt)
-- Rezept 26: Stadtszene
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (91, 26, 100, 2);  -- 2x Kleines Haus
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (92, 26, 110, 1);  -- 1x Laden
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (93, 26, 103, 2);  -- 2x Auto
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (94, 26, 108, 3);  -- 3x Laterne
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (95, 26, 102, 2);  -- 2x Zaun
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (96, 26, 124, 4);  -- 4x Minifigur

-- Rezept 27: Park Szene
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (97, 27, 101, 5);  -- 5x Baum
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (98, 27, 107, 3);  -- 3x Blumenbeet
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (99, 27, 115, 4);  -- 4x Parkbank
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (100, 27, 112, 1); -- 1x Brunnen
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (101, 27, 122, 1); -- 1x Park Tor
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (102, 27, 114, 2); -- 2x Fahrrad
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (103, 27, 124, 3); -- 3x Minifigur

-- Rezept 28: Notdienst Szene
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (104, 28, 116, 2); -- 2x Feuerwehrauto
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (105, 28, 117, 2); -- 2x Polizeiauto
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (106, 28, 106, 1); -- 1x Garage
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (107, 28, 124, 6); -- 6x Minifigur

-- Rezept 29: Wohnviertel Szene
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (108, 29, 100, 3); -- 3x Kleines Haus
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (109, 29, 120, 2); -- 2x Apartment
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (110, 29, 101, 4); -- 4x Baum
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (111, 29, 102, 3); -- 3x Zaun
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (112, 29, 103, 2); -- 2x Auto
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (113, 29, 108, 4); -- 4x Laterne
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (114, 29, 124, 5); -- 5x Minifigur

-- Rezept 30: Stadtzentrum Szene
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (115, 30, 119, 1); -- 1x Rathaus
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (116, 30, 118, 1); -- 1x Schule
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (117, 30, 110, 2); -- 2x Laden
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (118, 30, 121, 1); -- 1x Café
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (119, 30, 109, 2); -- 2x Bus
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (120, 30, 123, 2); -- 2x Bushaltestelle
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (121, 30, 105, 1); -- 1x Brücke
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (122, 30, 108, 6); -- 6x Laterne
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (123, 30, 113, 4); -- 4x Straßenschild
INSERT INTO recipe_components (id, recipe, component, component_amount) VALUES (124, 30, 124, 10);-- 10x Minifigur

-- Abfragen zum Testen
-- Alle Items anzeigen
-- SELECT * FROM item;

-- Alle Rezepte mit ihren Ergebnissen anzeigen
-- SELECT r.id, i.name as result_item, r.yield
-- FROM recipe r
-- JOIN item i ON r.result = i.id;

-- Alle Rezept-Komponenten mit Namen anzeigen
-- SELECT r.id as recipe_id, i1.name as result, rc.component_amount, i2.name as component
-- FROM recipe r
-- JOIN item i1 ON r.result = i1.id
-- JOIN recipe_components rc ON r.id = rc.recipe
-- JOIN item i2 ON rc.component = i2.id
-- ORDER BY r.id;
