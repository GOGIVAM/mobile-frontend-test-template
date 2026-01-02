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
   git clone [https://github.com/GOGIVAM/mobile-frontend-test-template]
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
- `lib/models/`: Data entity definitions (e.g., `Delivery`).
- `lib/controllers/`: Application state management using the `GetX` package.
- `lib/pages/`: Main application screens.
- `lib/widgets/`: Atomic and reusable UI components.
- `lib/utils/`: Utility functions and constants.

### Architecture Choice: GetX
For this project, we chose **GetX** as the state management solution for the following reasons:
- **Productivity**: Minimal boilerplate code for reactive state management.
- **Performance**: High-performance execution with intelligent memory management (automatically removes controllers when not in use).
- **Simplicity**: Easy to learn and implement dependency injection and navigation.

## 🛠️ Technical Choices & Code Quality
- **Clean Code**: Explicit variable naming, adherence to Dart conventions (camelCase, linting).
- **Stateless Widgets**: Preferred to maximize performance and reusability.
- **Responsive UI**: Use of flexible widgets (Flexible, Expanded, ListView) to adapt to different screen sizes.
- **Material 3**: Implementation of the latest Android design standards.

## 📄 Evaluation Criteria Met
1. **Quality & Architecture**: Clear organization into layers (Models, Controllers, Pages, Widgets).
2. **Documentation**: This README details installation, technical choices, and structure in English.
3. **GitHub Process**: Structured and clear commits following the `feat`, `fix`, `docs` convention.

---
*Developed as part of the Mobile Frontend competency test.*
