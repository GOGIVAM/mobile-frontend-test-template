# Gogivam Dashboard - Flutter Web Application

Application dashboard mobile/web Flutter reproduisant fidèlement une maquette de tableau de bord d'administration.


### Interface Dashboard
- **4 cartes statistiques** : Sales (250k), Customers (24m), Products (15k), Revenue (180m)
- **Graphique de ventes** : Visualisation des données de ventes et revenus mensuels avec fl_chart
- **Tableau de commandes** : Affichage des commandes avec statuts de paiement et de livraison
- **Cartes d'information** : Overall Sales, Earnings, Revenue, New Customers

### Navigation
- **Drawer latéral** : Navigation complète avec 14 éléments de menu
- **Pages fonctionnelles** :
  - Dashboard (page principale)
  - Analytics
  - Reports
  - Products

### UX/UI
- Design fidèle à la maquette (Proposition d'un drawer)
- Couleurs et espacements respectés
- Animations et interactions fluides
- Responsive design

## Structure du Projet

```
lib/
├── main.dart                 # Point d'entrée de l'application
├── app.dart                  # Configuration MaterialApp
├── models/                   # Modèles de données
│   ├── order.dart           # Modèle de commande
│   └── stat_card.dart       # Modèle de carte statistique
├── pages/                    # Pages/Écrans
│   ├── dashboard_screen.dart # Page principale du dashboard
│   ├── analytics_screen.dart # Page Analytics
│   ├── calendar_screen.dart  # Page Calendar
│   ├── products_screen.dart  # Page Products
│   └── reports_screen.dart   # Page Reports
├── widgets/                  # Composants réutilisables
│   ├── app_drawer.dart      # Menu latéral
│   ├── orders_table.dart    # Tableau des commandes
│   ├── sales_chart.dart     # Graphique de ventes
│   └── stat_card.dart       # Carte statistique
└── utils/                    # Utilitaires
    └── mock_data.dart       # Données mockées statiques
```

## 🚀 Installation

### Prérequis
- Flutter SDK 3.0.0 ou supérieur
- Dart SDK 3.0.0 ou supérieur

### Étapes d'installation

1. **Cloner le projet**
```bash
cd mobile-frontend-test-template
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Lancer l'application**

Pour le web :
```bash
flutter run -d chrome
```

Pour un émulateur mobile :
```bash
flutter run
```

## 📦 Dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  fl_chart: ^0.66.0        # Pour les graphiques

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```



## Données Mockées

Les données sont entièrement statiques et mockées dans `lib/utils/mock_data.dart` :
- 5 commandes exemple
- 12 points de données pour le graphique (un par mois)

## Personnalisation

### Ajouter une nouvelle page

1. Créer un fichier dans `lib/pages/`
2. Ajouter la route dans `lib/widgets/app_drawer.dart`
3. Implémenter l'interface

### Modifier les données mockées

Éditer le fichier `lib/utils/mock_data.dart` pour changer les données affichées.

## Compatibilité

- Web (Chrome, Firefox, Edge)
- Mobile (iOS, Android) - si configuré
- Desktop (Windows, macOS, Linux) - si configuré

## Développement

### Commandes utiles

```bash
# Analyser le code
flutter analyze

# Formater le code
flutter format .

# Lancer les tests
flutter test

# Build pour le web
flutter build web
```

## Notes

- Application créée pour un test technique
- Interface fidèle à la maquette fournie
- Code organisé et maintenable
- Utilisation de widgets standards Flutter
- Pas de state management complexe (données statiques)

##  Concepts Flutter Utilisés

- StatelessWidget
- MaterialApp & Theme
- Drawer Navigation
- GridView
- DataTable
- Custom Widgets
- fl_chart pour les graphiques
- Layouts (Row, Column, Stack)
- Material Design


