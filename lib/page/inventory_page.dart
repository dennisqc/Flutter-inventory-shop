import 'package:flutter/material.dart';
import 'package:shopflutter/widgets/product_widget.dart';
import 'package:shopflutter/widgets/side_menu.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Page"),
        backgroundColor: Colors.blueGrey, // Cambia el color del AppBar si lo deseas
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Añade un padding para un mejor diseño
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Content of the Inventory Page",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ProductWidget(), // Incluye el widget del producto
            // Puedes añadir más widgets aquí si es necesario
          ],
        ),
      ),
      drawer: SideMenu(), // Incluye el menú lateral
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción que deseas realizar al presionar el botón
        },
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
