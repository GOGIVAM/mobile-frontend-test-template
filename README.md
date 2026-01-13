# Frontend

Structure du frontend Flutter pour le projet Deliveries.

# Module 5: Code Quality and Processes

## Project Description
A clean, responsive Flutter admin dashboard for showing data, built with Riverpod for state management.  
Supports mobile and desktop/tablet layouts.

## Features

### Core Functionality
- **Responsive Design**: Seamless experience across mobile, tablet, and desktop devices
- **Semi-Interactive Dashboard**: KPI cards showing sales, customers, products, and revenue
- **Dynamic Charts**: Line charts and bar charts with interactive tooltips and legends
- **Date Filtering**: Filter data by Today, Yesterday, 7 days, 15 days, and 30 days
- **Order Management**:
    - Swipe-to-action on mobile (approve/delete)
    - Desktop table view with sorting capabilities
- **Pull-to-Refresh**: Reset dashboard to initial state with pull-down gesture on mobile
- **KPI Auto-calculation**: Automatic recalculation based on order changes

### Technical Features
- Clean Architecture with separation of concerns
- Riverpod for reactive state management
- Modular provider system (Dashboard, Order, KPI)
- Type-safe models and data structures
- Responsive breakpoints for adaptive UI

## Folder Structure

- root
  - assets [create a folder for any asset category]
    - images [all images go here] 
  - lib 
    - models [domain layer]
    - pages [presentation layer]
    - providers [state management]
    - utils
    - widgets 
  - tests


## Getting Started

### Prerequisites

- Flutter SDK >= 3.35.0
- Dart >= 3.7.3
- IDE: Android Studio, VS Code, or IntelliJ IDEA
- Git


### Installation

Install dependencies

```bash
flutter pub get
```
Run the app

```bash
# Desktop / Web
flutter run -d windows    # or macos, linux, chrome

# Mobile (emulator or device)
flutter run
```

## Running Tests

```bash
# All tests
flutter test

# Specific groups
flutter test test/widget/orders_row_test.dart
flutter test test/unit/percent_test.dart
flutter test test/unit/kpi_utils_test.dart
```

### Key Architectural Decisions

#### Why Riverpod?
- **Type Safety**: Compile-time error detection
- **Testability**: Easy to mock and test providers
- **Performance**: Automatic disposal and efficient rebuilds
- **Scalability**: Clean dependency injection

#### State Management Structure
Each provider is responsible for a specific domain:

- **`dashboard_provider.dart`**: Manages dashboard state, date filtering, and chart data
- **`order_provider.dart`**: Handles order CRUD operations and swipe actions
- **`kpi_provider.dart`**: Calculates and manages KPI metrics

#### Responsive Design Strategy
```dart
// Breakpoint system
static bool isMobile(double width) => width < 600;
static bool isTablet(double width) => width >= 600 && width < 1024;
static bool isDesktop(double width) => width >= 1024;
```
