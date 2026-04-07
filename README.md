# inventory_management_app

A new Flutter project.

## Getting Started

A Flutter application that allows users to manage inventory items using Firebase Firestore.

## Features

- Add new inventory items
- View items in real-time
- Update item information
- Delete items from inventory

## Enhanced Features

### 1. Icon-Based Delete Action
The app uses a delete (trash can) icon instead of a text button, providing a easier, cleaner and more familiar user experience.

### 2. Real-Time Inventory Updates
The app uses StreamBuilder to listen to Firestore changes. Any updates are reflected instantly without refreshing.

## Technologies Used

- Flutter
- Firebase Core
- Cloud Firestore

## How to Run

1. Open the project in Android Studio
2. Run on an emulator
3. Click the plus (+) button at the bottom right conner to add an item
4. Type in the item name, price, count, item type
5. Click Return arrow on the top left button to return home
6. Click on the item snack bar at the homescreen to edit
7. Click the bin button to delete