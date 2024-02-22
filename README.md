# GroceryApp Starter

Streamlined grocery app template for a straightforward shopping experience. 🛒✨

Feel free to star ⭐ the repository if you find it valuable.

## Screenshots

**Please click the image below to enlarge.**
![screenshot_1](https://github.com/ramiomarouayache/Flutter-GroceryApp/blob/main/screenshots/Cover.jpg)


## ✨Requirements

1. **Development Environment:**
   - Any IDE with Flutter SDK installed (e.g., VSCode, Android Studio, IntelliJ)

2. **Knowledge Base:**
   - Basic to intermediate knowledge of Dart and Flutter
   - Understanding of MVVM architecture
   - Familiarity with API handling
   - Basics of state management using GetX
  
## Test
* You can download the pre-released version for android devices from here [releases](https://github.com/ramiomarouayache/Flutter-GroceryApp/releases/tag/v0.3.1).
* ![lv_0_20240221103339-ezgif com-optimize](https://github.com/ramiomarouayache/Flutter-GroceryApp/assets/98425058/65e4271b-cd54-4e0b-8dfa-2bf97d2f262d)

  
## Setup
* First you need to config your product endpoint, credential, parameters...etc from lib\constants\AppConstants
* **Or** you can test the free endpoint (free as of the date of sharing this) mentioned in the code below and it will work successfully.
```
class AppConstants {
  //Free API was used in the released version =>
  //static const String BASE_URL = "https://world.openfoodfacts.org/api/v2";

  static const String BASE_URL = "YOUR_API_PREFIX";
  static const String API_KEY = "YOUR_API_KEY"; //IF_EXIST
  static const String projectOwnerName = "Rami Omar";
}
```

## Notice
* If you want to use your own API endpoints, you will need to change all associated logical layers according to the MVVM architecture based on your endpoint documentation.
* Some of the images used in the pre-released version are not copyright-free so I deleted them.

## Contributing

Please fork this repository and contribute back using
[pull requests](https://github.com/ramiomarouayache/Flutter-GroceryApp/pulls).

Any contributions, large or small, major features, bug fixes, are welcomed and appreciated
but will be thoroughly reviewed .


## Getting Started
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)


## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/GroceryApp/count.svg" alt ="Loading">
