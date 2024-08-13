import 'package:flutter/material.dart';
import 'package:shopflutter/widgets/side_menu.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Page"),
      ),
      body: Center(
        child: Text("Content of the Inventory Page"),
      ),
      drawer:
          SideMenu(), // Aquí es donde deberías incluir tu drawer personalizado.
    );
  }
}
