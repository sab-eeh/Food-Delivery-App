<<<<<<< HEAD
# Foodie — Flutter Food Delivery App

A full-stack mobile food delivery application built with **Flutter** and **Firebase**, designed to provide a complete food ordering experience from authentication and menu discovery to cart management, checkout, and order history.

Foodie uses **Cloud Firestore** as its real-time backend and **Firebase Authentication** for user management, while **Provider** handles client-side cart state and application logic.

---

## Overview

Foodie is a production-style food ordering application that demonstrates how to build a modern Flutter application backed by a cloud-based Firebase architecture.

Users can:

- Create an account and sign in
- Browse food items and categories
- Search the menu in real time
- View detailed food information
- Select quantities and add items to a persistent cart
- Review automatically calculated cart totals
- Place orders through a checkout flow
- View their previous orders and order status
- View their profile information
- Maintain a persistent authenticated session

The application combines Flutter's Material Design components with animations and a Provider-based state layer to create a smooth native mobile experience.

---

## Features

### Authentication

- Firebase Authentication
- User registration and login
- Persistent authentication sessions
- Automatic splash-screen routing
- Logout functionality

### Home & Menu

- Dynamic menu loaded from Cloud Firestore
- Food categories
- Real-time search
- Category-based filtering
- Promotional/content sections
- Cloud-hosted food data

### Food Details

- Dedicated food detail screen
- Food information and pricing
- Quantity selection
- Hero animations
- Add-to-cart functionality

### Cart

- Provider-based state management
- Persistent cart state during the session
- Increase/decrease item quantities
- Automatic item removal when quantity reaches zero
- Automatic total-price calculation
- Itemized cart summary

### Checkout & Orders

- Checkout flow
- Orders stored in Cloud Firestore
- Itemized order information
- Total order price
- Order status
- User-specific order history
- Newly placed orders reflected in the user's order history

### Profile

- User information retrieved from Firestore
- Access to order history
- Logout

### UI & UX

- Material Design
- Hero animations
- AnimatedContainer transitions
- Responsive Flutter layouts
- Smooth screen transitions
- Native-feeling mobile interactions

---

## Tech Stack

| Technology | Purpose |
|---|---|
| **Flutter** | Cross-platform mobile application framework |
| **Dart** | Application programming language |
| **Firebase Authentication** | User authentication and session management |
| **Cloud Firestore** | Real-time NoSQL database |
| **Provider** | State management |
| **Material Design** | UI component system |
| **Hero Animations** | Shared-element screen transitions |
| **AnimatedContainer** | UI animations and transitions |

---

## Architecture

Foodie follows a client-centric Flutter architecture with Firebase providing the backend services.

```text
┌─────────────────────────────────────────────┐
│                 Flutter App                 │
│                                             │
│  ┌─────────────┐   ┌─────────────────────┐  │
│  │    UI /     │   │      Provider       │  │
│  │   Screens   │◄─►│   Cart State Layer  │  │
│  └──────┬──────┘   └──────────┬──────────┘  │
│         │                     │             │
└─────────┼─────────────────────┼─────────────┘
          │                     │
          ▼                     ▼
┌─────────────────────────────────────────────┐
│                  Firebase                   │
│                                             │
│  ┌─────────────────┐  ┌──────────────────┐  │
│  │    Firebase     │  │ Cloud Firestore  │  │
│  │ Authentication  │  │                  │  │
│  └─────────────────┘  └──────────────────┘  │
│                                             │
│  Users • Foods • Categories • Orders        │
└─────────────────────────────────────────────┘
```

### Data Flow

```text
User
 │
 ▼
Flutter UI
 │
 ├── Authentication ──────► Firebase Auth
 │
 ├── Menu / Food Data ────► Cloud Firestore
 │
 ├── Cart Updates ────────► Provider
 │
 └── Checkout ────────────► Cloud Firestore
                                │
                                ▼
                         User Order History
```

---

## Project Structure

A simplified project structure is shown below:

```text
foodie/
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
├── lib/
│   ├── ...
│   └── main.dart
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── firebase.json
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

> The exact contents of the `lib/` directory may vary depending on the current implementation.

---

## Firebase Data Model

The application uses Cloud Firestore to manage application data.

A conceptual structure is:

```text
Firestore
│
├── users/
│   └── {userId}
│       ├── name
│       ├── email
│       └── ...
│
├── foods/
│   └── {foodId}
│       ├── name
│       ├── category
│       ├── price
│       ├── image
│       └── ...
│
└── orders/
    └── {orderId}
        ├── userId
        ├── items
        ├── totalPrice
        ├── status
        └── ...
```

The exact field names and Firestore structure should match the implementation in the project.

---
=======
Foodie — Flutter Food Delivery App

A full-stack mobile food delivery application built with Flutter and Firebase, designed to provide a complete food ordering experience from authentication and menu discovery to cart management, checkout, and order history.
>>>>>>> 59b95586a65a456d186719348810981c394d501c

Foodie uses Cloud Firestore as its real-time backend and Firebase Authentication for user management, while Provider handles client-side cart state and application logic.

<<<<<<< HEAD
### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK (included with Flutter)
- Android Studio or VS Code
- Android emulator, iOS simulator, or a physical device
- A Firebase project

Verify your Flutter installation:

```bash
flutter doctor
```

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/foodie.git
cd foodie
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

Create a Firebase project in the Firebase Console and configure:

- Firebase Authentication
- Cloud Firestore

Then connect Firebase to the Flutter application using the appropriate platform configuration.

For a new FlutterFire setup, the recommended approach is:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This generates the Firebase configuration required by the supported platforms.

> Do not commit private credentials, service-account keys, or other sensitive Firebase configuration files that should remain outside version control.

### 4. Run the application

```bash
flutter run
```

To see available devices:

```bash
flutter devices
```

---

## Firebase Setup

### Authentication

Enable the authentication providers required by the application in:

**Firebase Console → Authentication → Sign-in method**

For the current application flow, email/password authentication can be enabled for:

- User registration
- User login
- Session persistence

### Cloud Firestore

Create a Firestore database and populate it with the application's food and user data.

The application expects Firestore to provide data for areas such as:

```text
Users
Foods
Orders
```

Configure appropriate Firestore Security Rules before using the application in a production environment.

---

## Application Flow

```text
App Launch
    │
    ▼
Splash Screen
    │
    ├── Authenticated ─────► Home
    │
    └── Not Authenticated ─► Login / Signup
                                │
                                ▼
                              Home
                                │
              ┌─────────────────┼─────────────────┐
              ▼                 ▼                 ▼
           Search           Categories       Food Details
                                                  │
                                                  ▼
                                               Add Cart
                                                  │
                                                  ▼
                                                Cart
                                                  │
                                                  ▼
                                               Checkout
                                                  │
                                                  ▼
                                             Create Order
                                                  │
                                                  ▼
                                           Order History
```

---

## State Management

The application uses **Provider** for cart state management.

The cart layer is responsible for:

- Maintaining selected products
- Tracking quantities
- Adding and removing items
- Updating quantities
- Calculating totals
- Exposing cart state to the UI

This keeps cart-related business logic separate from individual UI screens and makes state changes reactive across the application.

---

## Animations

Foodie uses Flutter's built-in animation capabilities to improve the user experience.

### Hero Animation

Hero transitions are used when navigating between food listings and their detailed views, creating a smooth shared-element transition.

### AnimatedContainer

`AnimatedContainer` is used for lightweight UI transitions where properties such as size, spacing, decoration, or other visual states change.

---

## Supported Platforms

The repository contains Flutter platform targets for:

- Android
- iOS
- Web
- Windows
- macOS
- Linux

The primary application experience is designed around mobile food ordering, while Flutter's platform structure allows the project to be configured for additional targets.

---

## Security Considerations

For production deployment:

- Use restrictive Firestore Security Rules.
- Ensure users can only access their own private data.
- Validate order data on trusted backend infrastructure where appropriate.
- Never expose Firebase service-account credentials in the client application.
- Keep API keys and secrets out of source control when they are sensitive.
- Validate prices and order totals on the server side rather than trusting client-provided values.

---

## Future Improvements

Potential extensions for the project include:

- Restaurant/vendor management
- Admin dashboard
- Order status management
- Push notifications
- Payment gateway integration
- Delivery tracking
- Favorites and saved foods
- Ratings and reviews
- Promotional coupons
- Advanced restaurant/category filtering
- Offline caching
- Improved Firestore security and validation
- Automated testing and CI/CD

---

## What This Project Demonstrates

This project demonstrates practical experience with:

- Flutter application development
- Dart
- Firebase Authentication
- Cloud Firestore
- Provider state management
- Real-time cloud data
- CRUD-based application flows
- Authentication and session handling
- Cart and checkout architecture
- User-specific data
- Mobile UI/UX
- Flutter animations
- Cross-platform application structure

---

## License

This project is available for educational and portfolio purposes.

Add an appropriate license here if you intend to distribute the source code publicly.

---

## Author

**Sabeeh Uddin**

Full-Stack Developer

- GitHub: https://github.com/sab-eeh
- Portfolio: https://sabeeh-portfolio.vercel.app/

=======
Overview

Foodie is a production-style food ordering application that demonstrates how to build a modern Flutter application backed by a cloud-based Firebase architecture.

Users can:

Create an account and sign in

Browse food items and categories

Search the menu in real time

View detailed food information

Select quantities and add items to a persistent cart

Review automatically calculated cart totals

Place orders through a checkout flow

View their previous orders and order status

View their profile information

Maintain a persistent authenticated session

The application combines Flutter's Material Design components with animations and a Provider-based state layer to create a smooth native mobile experience.

Features

Authentication

Firebase Authentication

User registration and login

Persistent authentication sessions

Automatic splash-screen routing

Logout functionality

Home & Menu

Dynamic menu loaded from Cloud Firestore

Food categories

Real-time search

Category-based filtering

Promotional/content sections

Cloud-hosted food data

Food Details

Dedicated food detail screen

Food information and pricing

Quantity selection

Hero animations

Add-to-cart functionality

Cart

Provider-based state management

Persistent cart state during the session

Increase/decrease item quantities

Automatic item removal when quantity reaches zero

Automatic total-price calculation

Itemized cart summary

Checkout & Orders

Checkout flow

Orders stored in Cloud Firestore

Itemized order information

Total order price

Order status

User-specific order history

Newly placed orders reflected in the user's order history

Profile

User information retrieved from Firestore

Access to order history

Logout

UI & UX

Material Design

Hero animations

AnimatedContainer transitions

Responsive Flutter layouts

Smooth screen transitions

Native-feeling mobile interactions

Tech Stack

Technology

Purpose

Flutter

Cross-platform mobile application framework

Dart

Application programming language

Firebase Authentication

User authentication and session management

Cloud Firestore

Real-time NoSQL database

Provider

State management

Material Design

UI component system

Hero Animations

Shared-element screen transitions

AnimatedContainer

UI animations and transitions

Architecture

Foodie follows a client-centric Flutter architecture with Firebase providing the backend services.

┌─────────────────────────────────────────────┐
│                 Flutter App                 │
│                                             │
│  ┌─────────────┐   ┌─────────────────────┐  │
│  │    UI /     │   │      Provider       │  │
│  │   Screens   │◄─►│   Cart State Layer  │  │
│  └──────┬──────┘   └──────────┬──────────┘  │
│         │                     │             │
└─────────┼─────────────────────┼─────────────┘
          │                     │
          ▼                     ▼
┌─────────────────────────────────────────────┐
│                  Firebase                   │
│                                             │
│  ┌─────────────────┐  ┌──────────────────┐  │
│  │    Firebase     │  │ Cloud Firestore  │  │
│  │ Authentication  │  │                  │  │
│  └─────────────────┘  └──────────────────┘  │
│                                             │
│  Users • Foods • Categories • Orders        │
└─────────────────────────────────────────────┘

Data Flow

User
 │
 ▼
Flutter UI
 │
 ├── Authentication ──────► Firebase Auth
 │
 ├── Menu / Food Data ────► Cloud Firestore
 │
 ├── Cart Updates ────────► Provider
 │
 └── Checkout ────────────► Cloud Firestore
                                │
                                ▼
                         User Order History

Project Structure

A simplified project structure is shown below:

foodie/
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
├── lib/
│   ├── ...
│   └── main.dart
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── firebase.json
├── pubspec.yaml
├── pubspec.lock
└── README.md

The exact contents of the lib/ directory may vary depending on the current implementation.

Firebase Data Model

The application uses Cloud Firestore to manage application data.

A conceptual structure is:

Firestore
│
├── users/
│   └── {userId}
│       ├── name
│       ├── email
│       └── ...
│
├── foods/
│   └── {foodId}
│       ├── name
│       ├── category
│       ├── price
│       ├── image
│       └── ...
│
└── orders/
    └── {orderId}
        ├── userId
        ├── items
        ├── totalPrice
        ├── status
        └── ...

The exact field names and Firestore structure should match the implementation in the project.

Getting Started

Prerequisites

Make sure you have the following installed:

Flutter SDK

Dart SDK (included with Flutter)

Android Studio or VS Code

Android emulator, iOS simulator, or a physical device

A Firebase project

Verify your Flutter installation:

flutter doctor

Installation

1. Clone the repository

git clone https://github.com/YOUR_USERNAME/foodie.git
cd foodie

2. Install dependencies

flutter pub get

3. Configure Firebase

Create a Firebase project in the Firebase Console and configure:

Firebase Authentication

Cloud Firestore

Then connect Firebase to the Flutter application using the appropriate platform configuration.

For a new FlutterFire setup, the recommended approach is:

dart pub global activate flutterfire_cli
flutterfire configure

This generates the Firebase configuration required by the supported platforms.

Do not commit private credentials, service-account keys, or other sensitive Firebase configuration files that should remain outside version control.

4. Run the application

flutter run

To see available devices:

flutter devices

Firebase Setup

Authentication

Enable the authentication providers required by the application in:

Firebase Console → Authentication → Sign-in method

For the current application flow, email/password authentication can be enabled for:

User registration

User login

Session persistence

Cloud Firestore

Create a Firestore database and populate it with the application's food and user data.

The application expects Firestore to provide data for areas such as:

Users
Foods
Orders

Configure appropriate Firestore Security Rules before using the application in a production environment.

Application Flow

App Launch
    │
    ▼
Splash Screen
    │
    ├── Authenticated ─────► Home
    │
    └── Not Authenticated ─► Login / Signup
                                │
                                ▼
                              Home
                                │
              ┌─────────────────┼─────────────────┐
              ▼                 ▼                 ▼
           Search           Categories       Food Details
                                                  │
                                                  ▼
                                               Add Cart
                                                  │
                                                  ▼
                                                Cart
                                                  │
                                                  ▼
                                               Checkout
                                                  │
                                                  ▼
                                             Create Order
                                                  │
                                                  ▼
                                           Order History

State Management

The application uses Provider for cart state management.

The cart layer is responsible for:

Maintaining selected products

Tracking quantities

Adding and removing items

Updating quantities

Calculating totals

Exposing cart state to the UI

This keeps cart-related business logic separate from individual UI screens and makes state changes reactive across the application.

Animations

Foodie uses Flutter's built-in animation capabilities to improve the user experience.

Hero Animation

Hero transitions are used when navigating between food listings and their detailed views, creating a smooth shared-element transition.

AnimatedContainer

AnimatedContainer is used for lightweight UI transitions where properties such as size, spacing, decoration, or other visual states change.

Supported Platforms

The repository contains Flutter platform targets for:

Android

iOS

Web

Windows

macOS

Linux

The primary application experience is designed around mobile food ordering, while Flutter's platform structure allows the project to be configured for additional targets.

Security Considerations

For production deployment:

Use restrictive Firestore Security Rules.

Ensure users can only access their own private data.

Validate order data on trusted backend infrastructure where appropriate.

Never expose Firebase service-account credentials in the client application.

Keep API keys and secrets out of source control when they are sensitive.

Validate prices and order totals on the server side rather than trusting client-provided values.

Future Improvements

Potential extensions for the project include:

Restaurant/vendor management

Admin dashboard

Order status management

Push notifications

Payment gateway integration

Delivery tracking

Favorites and saved foods

Ratings and reviews

Promotional coupons

Advanced restaurant/category filtering

Offline caching

Improved Firestore security and validation

Automated testing and CI/CD

What This Project Demonstrates

This project demonstrates practical experience with:

Flutter application development

Dart

Firebase Authentication

Cloud Firestore

Provider state management

Real-time cloud data

CRUD-based application flows

Authentication and session handling

Cart and checkout architecture

User-specific data

Mobile UI/UX

Flutter animations

Cross-platform application structure

License

This project is available for educational and portfolio purposes.

Add an appropriate license here if you intend to distribute the source code publicly.

Author

Sabeeh Uddin

Full-Stack Developer

GitHub: https://github.com/sab-eeh

Portfolio: https://sabeeh-portfolio.vercel.app/
>>>>>>> 59b95586a65a456d186719348810981c394d501c
