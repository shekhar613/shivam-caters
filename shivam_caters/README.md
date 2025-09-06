# Shivam Caters - Management System

A comprehensive business management Flutter Windows application for catering operations.

## Features

- **Dashboard**: Overview of business metrics, quick stats, and management tools
- **Order Management**: Track and manage customer orders with status updates
- **Billing & Invoices**: Generate invoices, track payments, and manage billing
- **Menu Management**: Add, edit, and organize menu items with availability control
- **Inventory Management**: Track stock levels, manage supplies, and monitor low stock items

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Windows 10/11
- Visual Studio with C++ development tools

### Installation

1. Clone or download this project
2. Navigate to the project directory:
   ```bash
   cd shivam_caters
   ```

3. Get the dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application:
   ```bash
   flutter run -d windows
   ```

## App Structure

- `lib/main.dart` - Main application file with all screens and navigation
- `windows/` - Windows-specific configuration and build files
- `pubspec.yaml` - Project dependencies and metadata

## Management Screens

1. **Dashboard**: Business overview with key metrics and quick access to all management tools
2. **Order Management**: Track orders, update status, view order details, and manage customer orders
3. **Billing & Invoices**: Create invoices, track payments, manage billing, and generate reports
4. **Menu Management**: Add/edit menu items, manage categories, control availability, and set pricing
5. **Inventory Management**: Track stock levels, manage suppliers, monitor low stock, and update inventory

## Business Management Features

- **Order Tracking**: Complete order lifecycle management from placement to completion
- **Financial Management**: Invoice generation, payment tracking, and revenue analytics
- **Menu Control**: Dynamic menu management with real-time availability updates
- **Inventory Control**: Stock level monitoring with automated low-stock alerts
- **Business Analytics**: Key performance indicators and business insights
- **Multi-User Support**: Role-based access for different staff members

## Customization

You can easily customize:
- Business name and branding
- Menu categories and items
- Order status workflows
- Inventory categories and suppliers
- Color scheme (currently using purple theme)
- Business metrics and reporting

## Building for Release

To build a Windows executable:

```bash
flutter build windows
```

The built application will be available in `build/windows/runner/Release/`.
