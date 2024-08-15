import 'package:flutter/material.dart';
import '../models/product_model.dart'; // Asegúrate de importar el modelo

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(Icons.shopping_cart, size: 50), 
        title: Text(product.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${product.descripcion}'),
            Text('Purchase Price: \$${product.precioCompra.toStringAsFixed(2)}'),
            Text('Sale Price: \$${product.precioVenta.toStringAsFixed(2)}'),
            Text('Stock: ${product.cantidadEnStock}'),
            Text('Created: ${product.fechaCreacion}'),
          ],
        ),
      ),
    );
  }
}
