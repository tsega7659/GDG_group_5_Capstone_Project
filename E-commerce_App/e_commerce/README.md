
## first clone the github repo
https://github.com/tsega7659/GDG_group_5_Capstone_Project

## we will work on development branch

## E-Commerce Clothing Store App

## Project Folder Structure


1. lib/ - Main Application Folder


2.  core/ - Application Core (Reusable Logic)
Contains app-wide utilities, configurations, and shared resources.


api/ → Manages API services and HTTP requests.


models/ → Defines data models such as Product, User, Order.


utils/ → Contains helper functions (e.g., formatters, validators).


theme/ → Stores global styling, colors, and typography.


routing/ → Manages app navigation settings.


constants/ → Defines global constant values (e.g., API endpoints, default values).



3. features/ - Feature-Based Structure
Each feature is self-contained and consists of data, domain, presentation, and BLoC.


authentication/ - User Authentication
data/ → Manages API calls and repositories.


domain/ → Contains business logic (e.g., user login, signup).
presentation/ → UI components (screens, widgets).

bloc/ → BLoC files for managing authentication states.


home/ - Home Screen
presentation/ → UI components for the home page.

bloc/ → BLoC for fetching and displaying products.


cart/ - Shopping Cart
presentation/ → UI for displaying and managing the shopping cart.

bloc/ → BLoC for adding/removing items in the cart.


product/ - Product Listings & Details
presentation/ → Product list and details UI.

bloc/ → BLoC for handling product interactions.


wishlist/ - Favorite Products
presentation/ → Wishlist UI.

bloc/ → BLoC for managing favorite items.


profile/ - User Profile
presentation/ → UI for profile settings.

bloc/ → BLoC for updating user details.


4. assets/ - App Resources
Stores static assets such as images, fonts, and animations.

images/ → App icons and product images.

fonts/ → Custom fonts for the app.

animations/ →  animations for UI enhancements.
