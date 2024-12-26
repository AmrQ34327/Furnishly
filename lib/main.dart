import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furnishly/model/model.dart' as model;
import 'package:furnishly/model/model.dart';
import 'package:furnishly/views/checkout_page.dart';
import 'package:furnishly/views/contact_us_page.dart';
import 'package:furnishly/views/edit_profile.dart';
import 'package:furnishly/views/faq_page.dart';
import 'package:furnishly/views/my_orders.dart';
import 'package:furnishly/views/view_single_product.dart';
import 'package:furnishly/views/view_products.dart';
import 'package:furnishly/views/wishlist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:furnishly/views/account_page.dart';
import 'package:furnishly/views/cart_page.dart';
import 'package:furnishly/views/cateogries_page.dart';
import 'package:furnishly/views/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'views/sign_up_page.dart';
import 'model/fakedata.dart';
import 'controller/controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<Account> accountsBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(CategoryAdapter());
  accountsBox = await Hive.openBox<Account>('accountsBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(accountsBox)),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Load the local account if a user is logged in
      if (Provider.of<UserProvider>(context, listen: false).currentUser ==
          null) {
        //  load local account
        Provider.of<UserProvider>(context, listen: false)
            .loadLocalAccount(user.uid);
      }
    }
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Color(0xFFDAA520)),
            backgroundColor: const Color(0xFF001F54),
            foregroundColor: Colors.white,
            titleTextStyle: GoogleFonts.cinzel(
              color: const Color(0xFFDAA520),
              fontWeight: FontWeight.bold,
              fontSize: width * 0.06,
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
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          foregroundColor:
              WidgetStatePropertyAll(Color.fromARGB(255, 255, 255, 255)),
          backgroundColor: WidgetStatePropertyAll(Color(0xFF556B2F)),
        )),
        chipTheme: ChipThemeData(
          shape: StadiumBorder(),
          backgroundColor: Color(0xFF2C3E50),
          selectedColor: Color(0xFFB58D4B),
          disabledColor: Colors.white,
          padding: EdgeInsets.all(4.0), // make it adaptive
          labelStyle: TextStyle(
            color: Colors.white, // Text color inside chip
            fontWeight: FontWeight.bold,
            fontSize: width * 0.03,
          ),
          elevation: 4,
        ),
      ),
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const MyHomePage(),
        '/account': (context) => AccountPage(),
        '/cart': (context) => CartPage(),
        '/categories': (context) => const CategoriesPage(),
        '/signup': (context) => const SignUpPage(),
        '/editProfile': (context) => EditAccountPage(),
        '/viewProducts': (context) => ViewProducts(),
        '/viewSingleProduct': (context) => ViewSingleProduct(),
        '/wishlist': (context) => WishlistPage(),
        '/checkout': (context) => CheckOutPage(),
        '/myOrders': (context) => MyOrdersPage(),
        '/faq': (context) => FAQPage(),
        '/contactUsPage': (context) => ContactUsPage(),
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
  String query = '';
  var filteredProductsList = [];
  final TextEditingController searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProductsList = productList; // Initially show all products
  }

  // Function to filter products based on search query
  void updateSearch(String query) {
    setState(() {
      filteredProductsList = productList
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: MyAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(width * 0.042),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Discover",
                      style: Theme.of(context).primaryTextTheme.bodyLarge),
                  SizedBox(height: height * 0.03),
                  // the search bar
                  TextField(
                    controller: searchBarController,
                    onChanged: (value) {
                      setState(() {
                        query = value; // Update query whenever the text changes
                      });
                      updateSearch(query);
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.07),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  // products list
                  searchBarController.text.isNotEmpty
                      ? SizedBox(
                          height: filteredProductsList.isEmpty
                              ? height * 0.2
                              : height * 0.4,
                          child: filteredProductsList.isEmpty
                              ? Center(
                                  child: Text(
                                    'No products found',
                                    style: TextStyle(fontSize: width * 0.045),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: filteredProductsList.length,
                                  itemBuilder: (context, index) {
                                    final product = filteredProductsList[index];
                                    return ListTile(
                                        leading: Container(
                                          height: height * 0.4,
                                          width: width * 0.25,
                                          child: Image.asset(
                                            product.imagePath,
                                            width: width * 0.2,
                                            height: height * 0.2,
                                            fit: BoxFit.fill,
                                          ),
                                        ), // Example icon
                                        title: Text(product.title),
                                        subtitle: Text(product.description),
                                        trailing: Text('\$${product.price}'));
                                  }))
                      : const SizedBox(),
                  // add new widgets here
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShowProducts(
                          title: 'Hot Deals',
                          showMoreFunction: () {
                            // show more logic
                            Navigator.pushNamed(context, '/viewProducts',
                                arguments: "showDiscount");
                          },
                          shownFilteredProductsList: discountedProductsList),
                      ShowProducts(
                          title: "Office",
                          showMoreFunction: () {
                            Navigator.pushNamed(context, '/viewProducts',
                                arguments: "Office");
                          },
                          shownFilteredProductsList:
                              showProductsByCategory("Office")),
                      ShowProducts(
                          title: "Living Room",
                          showMoreFunction: () {
                            Navigator.pushNamed(context, '/viewProducts',
                                arguments: "Living Room");
                          },
                          shownFilteredProductsList:
                              showProductsByCategory("Living Room")),
                      ShowProducts(
                          title: "Dining Room",
                          showMoreFunction: () {
                            Navigator.pushNamed(context, '/viewProducts',
                                arguments: "Dining Room");
                          },
                          shownFilteredProductsList:
                              showProductsByCategory("Dining Room")),
                      ShowProducts(
                          title: "Bedroom",
                          showMoreFunction: () {
                            Navigator.pushNamed(context, '/viewProducts',
                                arguments: "Bedroom");
                          },
                          shownFilteredProductsList:
                              showProductsByCategory("Bedroom")),
                      ShowProducts(
                          title: "Outdoors",
                          showMoreFunction: () {
                            Navigator.pushNamed(context, '/viewProducts',
                                arguments: "Outdoors");
                          },
                          shownFilteredProductsList:
                              showProductsByCategory("Outdoors")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: const MyDrawer(),
        bottomNavigationBar: const MyBottomNavigationBar());
  }
}

class ShowProducts extends StatelessWidget {
  final String title;
  final VoidCallback showMoreFunction;
  final List shownFilteredProductsList;

  const ShowProducts(
      {super.key,
      required this.title,
      required this.showMoreFunction,
      required this.shownFilteredProductsList});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        // First row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize:
                    Theme.of(context).primaryTextTheme.bodyMedium!.fontSize,
                fontWeight:
                    Theme.of(context).primaryTextTheme.bodySmall!.fontWeight,
                color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
              ),
            ),
            InkWell(
              onTap: showMoreFunction,
              child: Text(
                'Show More',
                style: TextStyle(
                  fontSize:
                      Theme.of(context).primaryTextTheme.bodySmall!.fontSize,
                  fontWeight:
                      Theme.of(context).primaryTextTheme.bodyMedium!.fontWeight,
                  color: Theme.of(context).primaryTextTheme.bodyMedium!.color,
                ),
              ),
            ),
          ],
        ),
        // this is the products row, maybe add a small SizedBox here
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            if (index < shownFilteredProductsList.length) {
              final product = shownFilteredProductsList[index];
              return Container(
                padding: EdgeInsets.all(width * 0.02),
                child: GestureDetector(
                  onTap: () {
                    // open prodcut
                    Navigator.pushNamed(context, '/viewSingleProduct',
                        arguments: product.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyImageContainer(
                        child: Image.asset(
                          product.imagePath,
                          width: width * 0.22,
                          height: height * 0.13,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .fontSize,
                          fontWeight: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .fontWeight,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .color,
                        ),
                      ),
                      SizedBox(height: height * 0.035)
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ),
      ],
    );
  }
}
