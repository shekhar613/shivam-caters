# Components Directory

This directory contains all the screen components for the Shivam Caters Flutter application, organized for better code management and maintainability.

## Component Files

### 1. `landing_screen.dart`
- **Purpose**: Main landing page with hero section, features, and call-to-action
- **Features**: 
  - Modern gradient design with custom color scheme
  - Interactive action buttons for navigation
  - Feature cards showcasing company benefits
  - Call-to-action section

### 2. `menu_screen.dart`
- **Purpose**: Displays the complete food menu with pricing
- **Features**:
  - Categorized menu items (Appetizers, Main Course, Breads, Desserts)
  - Clean card-based layout
  - Indian cuisine focus with ₹ pricing

### 3. `services_screen.dart`
- **Purpose**: Shows available catering services
- **Features**:
  - Service cards with descriptions
  - Icons for visual appeal
  - Covers weddings, corporate events, parties, etc.

### 4. `contact_screen.dart`
- **Purpose**: Contact information and communication options
- **Features**:
  - Contact details display
  - Call and email action buttons
  - Professional contact card design

### 5. `navigation_helper.dart`
- **Purpose**: Centralized navigation management
- **Features**:
  - Static methods for screen navigation
  - Consistent navigation patterns
  - Easy to maintain and extend

## Color Scheme

All components use the consistent color scheme:
- **Primary**: `#8A8AFF` (Light Purple)
- **Secondary**: `#B8B8FF` (Lighter Purple)  
- **Accent**: `#000047` (Dark Blue)
- **Background**: `#FFFFFF` (White)

## Usage

Each component is self-contained and can be imported individually:

```dart
import 'components/landing_screen.dart';
import 'components/menu_screen.dart';
import 'components/services_screen.dart';
import 'components/contact_screen.dart';
import 'components/navigation_helper.dart';
```

## Navigation

Use the NavigationHelper for consistent navigation:

```dart
NavigationHelper.navigateToMenu(context);
NavigationHelper.navigateToServices(context);
NavigationHelper.navigateToContact(context);
```

## Benefits of Component-Based Structure

1. **Maintainability**: Each screen is in its own file
2. **Reusability**: Components can be easily reused
3. **Testability**: Individual components can be tested separately
4. **Scalability**: Easy to add new screens or modify existing ones
5. **Code Organization**: Clear separation of concerns
6. **Team Collaboration**: Multiple developers can work on different components
