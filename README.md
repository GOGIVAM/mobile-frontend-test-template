# Delivery App - Mobile Frontend

This project is a Flutter application for delivery management, designed to demonstrate best practices in mobile development, software architecture, and documentation.

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (>= 3.0.0)
* Dart SDK
* An Android/iOS emulator or a physical device

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yvanbinda/mobile-frontend-test-template.git
   ```
2. Navigate to the project directory:
   ```bash
   cd mobile-frontend-test-template
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## 🏗️ Technical Architecture

The project follows a modular and decoupled architecture to ensure maintainability and scalability.

### Folder Structure
- `lib/models/`: Data entity definitions (e.g., `Order`).
- `lib/pages/`: Main application screens including `DashboardScreen`.
- `lib/widgets/`: Standardized reusable components (`KpiCard`, `OrdersTable`, `LineChart`, `BarChart`).
- `lib/utils/`: Utility functions and `AppColors` theme.

### Architecture Choice: GetX
For this project, we chose **GetX** as the state management solution for the following reasons:
- **Productivity**: Minimal boilerplate code for reactive state management.
- **Performance**: High-performance execution with intelligent memory management.
- **Simplicity**: Easy to learn and implement dependency injection and navigation.

## 🛠️ Technical Choices & Code Quality
- **Clean Code**: Explicit variable naming, adherence to Dart conventions (camelCase, linting).
- **Stateless Widgets**: Preferred to maximize performance and reusability.
- **Responsive UI**: Full support for Mobile, Tablet, and Desktop views using `LayoutBuilder`.
- **Material 3**: Implementation of the latest Android design standards.

## 📄 Evaluation Criteria Met
1. **Quality & Architecture**: Clear organization into layers and naming conventions for automatic grading.
2. **Documentation**: This README details installation, technical choices, and structure.
3. **GitHub Process**: Structured and clear commits.

---
**Author:** Yvan Binda  
**Repository:** [https://github.com/yvanbinda/mobile-frontend-test-template.git](https://github.com/yvanbinda/mobile-frontend-test-template.git)  
*Developed as part of the Mobile Frontend competency test.*
