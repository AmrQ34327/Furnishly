import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/views/account_page.dart';
import 'package:myapp/views/cart_page.dart';
import 'package:myapp/views/cateogries_page.dart';
import 'package:myapp/views/shared.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Color(0xFFDAA520)),
            backgroundColor: const Color(0xFF001F54),
            foregroundColor: Colors.white,
            titleTextStyle: GoogleFonts.cinzel(
              color: const Color(0xFFDAA520),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 30, 255, 0)),
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF001F54),
          selectedItemColor: Color(0xFFDAA520),
          unselectedItemColor: Color(0xFFDAA520),
        ),
        scaffoldBackgroundColor: const Color(0xFFE8EDF6),
        primaryTextTheme: const TextTheme(
          // for headings
          bodyMedium: TextStyle(color: Color(0xFFB58D4B)),
          // for normal text
          bodySmall: TextStyle(color: Color(0xFF2C3E50)),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF556B2F)),
                textStyle:
                    WidgetStatePropertyAll(TextStyle(color: Colors.white)))),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyHomePage(),
        '/account': (context) => const AccountPage(),
        '/cart': (context) => const CartPage(),
        '/categories': (context) => const CategoriesPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: const MyAppBar(),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Homepage Under Construction',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: const MyDrawer(),
        bottomNavigationBar: const MyBottomNavigationBar());
  }
}
