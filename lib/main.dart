import 'package:flutter/material.dart';
import 'package:miniproject/view/cart_screen.dart';
import 'package:miniproject/view/payment_screen.dart';
import 'package:miniproject/view/product_detail_screen.dart';
import 'package:miniproject/view/register_screen.dart';
import 'package:miniproject/view/slip_screen.dart';
import 'package:miniproject/view/splash_screen.dart';
import 'package:miniproject/view/login_screen.dart';
import 'package:miniproject/view/home_screen.dart';
import 'package:miniproject/view/user_screen.dart';
import 'package:miniproject/viewmodel/provider/cart_provider.dart';
import 'package:miniproject/viewmodel/provider/order_provider.dart';
import 'package:miniproject/viewmodel/provider/products_provider.dart';
import 'package:miniproject/viewmodel/provider/register_provider.dart';
import 'package:miniproject/viewmodel/provider/user_provider.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:miniproject/viewmodel/provider/login_provider.dart'; // Import LoginProvider

void main() => runApp(
      // Wrap the MaterialApp with MultiProvider
      MultiProvider(
        providers: [
          // Provide the LoginProvider to be used in the LoginScreen and its descendants
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
          // Add other providers here if needed
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galonin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashscreenWidget(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/cart': (context) =>  CartView(),
        '/profile': (context) => const UserDetailView(),
        '/pesanan' : (context) => const OrderSuccessView(),
        '/Struck' : (context) => const PaymentSlip(),
      },
    );
  }
}
