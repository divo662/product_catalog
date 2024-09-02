# Product Catalog App

## Overview

The Product Catalog App is a Flutter-based application designed to manage and showcase product catalogs. It features a clean and intuitive user interface that allows users to browse products, view categories, and manage their shopping cart. The app uses SQLite for local data storage and the Provider package for state management.

## Features

- **Product Browsing**: View and filter products by category and price.
- **Category Management**: Browse products by category.
- **Shopping Cart**: Add products to a cart and manage quantities.
- **Search Functionality**: Search products by name.
- **Data Persistence**: Local storage of product and category data using SQLite.

**APK FILE 
 [APK FILE](https://drive.google.com/file/d/181tAa-ZUBr44xfo2EREa5DoIQP4iB9sU/view)

## Setup and Running Locally

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (ensure you have Flutter installed)
- [SQLite](https://www.sqlite.org/download.html) (for local database operations)

### Clone the Repository

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/divo662/product-catalog.git
   cd product-catalog


### Setup Flutter Environment

1. Navigate to the project directory:

   ```bash
   cd product-catalog
   ```

2. Install Flutter dependencies:

   ```bash
   flutter pub get
   ```

### Running the App

1. Ensure that an emulator or physical device is connected.

2. Run the Flutter app:

   ```bash
   flutter run
   ```

## Design Decisions

- **Flutter for Frontend**: Selected for its cross-platform capabilities and efficient UI rendering.
- **SQLite for Local Storage**: Chosen for its lightweight and embedded database capabilities, suitable for offline access and local data management.
- **Provider for State Management**: Used for its simplicity and efficiency in managing state and reactivity across the application.

## Optimizations and Trade-offs

- **Local Database Operations**: Implemented using SQLite to ensure data persistence without needing a backend server.
- **State Management**: `Provider` is used to manage app state and ensure that the UI updates automatically in response to changes in data.
- **Error Handling**: Included robust error handling in database operations to ensure app stability and provide user feedback.

## State Management

The app utilizes the `Provider` package for state management. `Provider` is chosen for its straightforward approach to managing and propagating state changes throughout the application. Key aspects include:

- **Reactive State Updates**: Automatically updates the UI in response to state changes.
- **Decoupled State Logic**: Separates state management from UI components, making the codebase more modular and easier to maintain.

## Code Overview

- **`main.dart`**: Initializes the app, requests permissions, seeds the database if necessary, and sets up the `ProductProvider` for state management.
- **`DatabaseHelper.dart`**: Handles all local database operations, including creating tables, inserting, querying, updating, and deleting records.
- **`ProductProvider.dart`**: Manages the app's state, including product and category lists, shopping cart, and search functionality.

## Contributing

Contributions to the Product Catalog App are welcome! Please submit issues, feature requests, or pull requests via the repository. For detailed contribution guidelines, refer to the `CONTRIBUTING.md` file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

For further information or support, please contact [divzeh001@gmail.com](mailto:divzeh001@gmail.com).
