import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      backgroundColor: Colors.blueGrey[800],
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, 20, 26, 10),
          child: Text("main"),
        ),
        NavigationDrawerDestination(
      
          icon: Icon(Icons.add),
          label: Text("data"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.add_shopping_cart_outlined),
          label: Text("Home Screen"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.add),
          label: Text("data"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.add),
          label: Text("data"),
        ),
        Padding(padding: EdgeInsets.fromLTRB(28, 10, 16, 10), child: Divider()),
        Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More op'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.logout_outlined),
          label: Text("Cerrar sesion"),
        ),
      ],
    );
  }
}
