import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/model/model.dart' as model;
import 'package:furnishly/views/edit_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnishly/views/account_page.dart';
import 'package:furnishly/views/cart_page.dart';
import 'package:furnishly/views/cateogries_page.dart';
import 'package:furnishly/views/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'views/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (_) => model.UserProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
        primaryTextTheme: TextTheme(
          bodyLarge: TextStyle(
              color: const Color(0xFFB58D4B),
              fontSize: width * 0.09,
              fontWeight: FontWeight.bold),
          // for headings
          bodyMedium: TextStyle(
              color: const Color(0xFFB58D4B),
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold),
          // for normal text
          bodySmall: TextStyle(
            color: const Color(0xFF2C3E50),
            fontSize: width * 0.03,
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          foregroundColor:
              WidgetStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
          backgroundColor: WidgetStatePropertyAll(Color(0xFF556B2F)),
        )),
      ),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const MyHomePage(),
        '/account': (context) => AccountPage(),
        '/cart': (context) => const CartPage(),
        '/categories': (context) => const CategoriesPage(),
        '/signup': (context) => const SignUpPage(),
        '/editProfile': (context) => EditAccountPage()
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
        appBar: MyAppBar(),
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
