# Shopping App with Firebase Authentication

## Overview

This project is a Flutter-based shopping application that incorporates Firebase Authentication for user sign-in and sign-up functionality. The app allows users to securely register and log in using their email and password. It features a user-friendly interface with a login page, a sign-up page, and a home page displaying products and offers.

## What the Code Does

1. **Login Page**: 
   - Users can enter their email and password to log in.
   - The email must contain `@gmail.com`, and the password should be at least 6 characters long.
   - If the credentials are valid, the user is redirected to the home page.

2. **Sign-Up Page**: 
   - New users can create an account by providing their full name, email, and password.
   - The app checks that the first letter of the name is capitalized and that the password meets the length requirement.
   - Upon successful registration, users receive a confirmation message and are redirected to the login page.

3. **Home Page**: 
   - Displays a list of products in a grid format and offers a horizontal list of promotional items.
   - Users can view images of products and interact with them, such as adding items to a shopping cart.

## How This Code Works

- **Firebase Authentication**: 
  - The app uses the `firebase_auth` package to handle user authentication.
  - On the sign-up page, the `createUserWithEmailAndPassword` method is called to register a new user with Firebase.
  - On the login page, the `signInWithEmailAndPassword` method is used to authenticate the user.

- **Form Validation**: 
  - Each form (login and sign-up) is wrapped in a `Form` widget with validation rules defined using `TextFormField`.
  - The validators ensure that users provide valid input before proceeding.

- **Navigation**: 
  - The app uses Flutter's navigation system (`Navigator`) to transition between pages (login, sign-up, and home).

- **User Experience**: 
  - The app includes visual feedback through `SnackBar` messages for errors or confirmations.
  - Animations enhance the user experience when transitioning from sign-up to the home page.

## Packages Used

- [`firebase_auth`](https://pub.dev/packages/firebase_auth): For handling user authentication.
- [`flutter`](https://pub.dev/packages/flutter): The core Flutter framework used to build the application.
- [`material`](https://pub.dev/packages/material): For implementing Material Design components and themes.

This code provides a solid foundation for a shopping app with Firebase authentication, enabling secure user management while offering a visually appealing interface.
