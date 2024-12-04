import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle), label: "Account"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
      ],
      iconSize: width * 0.06,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/categories');
            break;
          case 2:
            Navigator.pushNamed(context, '/account');
            break;
          case 3:
            Navigator.pushNamed(context, '/cart');
            break;
        }
      },
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      title: Text(
        "Furnishly",
        style: TextStyle(
          color: Theme.of(context).appBarTheme.titleTextStyle!.color,
          fontWeight: Theme.of(context).appBarTheme.titleTextStyle!.fontWeight,
          fontSize: Theme.of(context).appBarTheme.titleTextStyle!.fontSize,
        ),
      ),
      actions: [
        // takes you to account page and changed to first name
        // when signed in
        TextButton(
            onPressed: () {},
            child: Text(
              "Sign in",
              style: TextStyle(
                color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                fontSize: width * 0.036,
              ),
            )),
      ],
    );
  }
}

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2897731066.
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width * 0.5,
        child: Drawer(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          child: ListView(
            children: [
              // will be sign in / or account name depending on state
              DrawerHeader(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Theme.of(context)
                              .appBarTheme
                              .titleTextStyle!
                              .color,
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                ),
                title: Text(
                  "Wishlist",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                onTap: () {
                  // here will take the user to wishlist page
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color),
                title: Text(
                  "My Orders",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                onTap: () {
                  // here will take the user to my orders page
                },
              ),
              ListTile(
                leading: Icon(Icons.phone,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color),
                title: Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                onTap: () {
                  // here will take the user to support page
                },
              ),
              ListTile(
                leading: Icon(Icons.help,
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color),
                title: Text(
                  "FAQ",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle!.color,
                  ),
                ),
                onTap: () {
                  // here will take the user to FAQ page
                },
              ),
              // a sign out that appears if signed in
              const ListTile(),
            ],
          ),
        ));
  }
}
