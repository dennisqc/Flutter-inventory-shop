import 'package:flutter/material.dart';
import 'package:shopflutter/widgets/side_menu.dart';
import '../models/product_model.dart'; // Asegúrate de importar el modelo

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product.urlImage.isNotEmpty
                  ? Image.network(
                      product.urlImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    )
                  : Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: 250,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 100,
                        color: Colors.grey[500],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Description: ${product.descripcion}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Purchase Price: \$${product.precioCompra.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sale Price: \$${product.precioVenta.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Stock: ${product.cantidadEnStock}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Created: ${product.fechaCreacion}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Acción del botón, como agregar al carrito o volver
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 36),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),     drawer: SideMenu(),
    );
  }
}
