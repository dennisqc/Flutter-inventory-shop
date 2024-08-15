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
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
      },
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("Nombre de Usuario"),
          accountEmail: Text("usuario@correo.com"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://dthezntil550i.cloudfront.net/f4/latest/f41908291942413280009640715/1280_960/1b2d9510-d66d-43a2-971a-cfcbb600e7fe.png"), 
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey[800], 
          ),
        ),
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
        NavigationDrawerDestination(
          icon: Icon(Icons.logout_outlined),
          label: Text("Cerrar sesión"),
        ),
      ],
    );
  }
}
