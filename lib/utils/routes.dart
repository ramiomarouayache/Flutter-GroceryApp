import 'package:get/get.dart';
import 'package:holmon/views/cart.dart';
import 'package:holmon/views/dashboard.dart';
import 'package:holmon/views/home.dart';
import 'package:holmon/views/profile.dart';
import 'package:holmon/views/registration.dart';
import 'package:holmon/views/splash.dart';
import 'package:holmon/views/vegetable_detail.dart';
import 'package:holmon/views/vegetables.dart';
import 'package:holmon/views/welcome.dart';
import 'package:holmon/views/categories.dart';

class MyRoutes {
  static final List<GetPage> pages = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/', page: () => WelcomeScreen()),
    GetPage(name: '/registration', page: () => RegistrationScreen()),
    GetPage(name: '/dashboard', page: () => HomeScreen()),
    GetPage(name: '/home', page: () => DashboardScreen()),
    GetPage(name: '/categories', page: () => Categories()),
    GetPage(name: '/cart', page: () => CartScreen()),
    GetPage(name: '/profile', page: () => Profile()),
    GetPage(name: '/vegetables', page: () => VegetablesScreen()),
    //GetPage(name: '/search', page: () => VegetablesSearchScreen()),
    GetPage(name: '/details', page: () => VegetableDetailScreen()),
    //GetPage(name: '/ArExperience', page: () => ArExperience()),
  ];
}
