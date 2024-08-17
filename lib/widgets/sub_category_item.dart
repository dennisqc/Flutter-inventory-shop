import 'package:flutter/material.dart';
import 'package:shopflutter/models/product_model.dart'; // Asegúrate de tener la ruta correcta

class SubCategoryItem extends StatelessWidget {
  final List<ProductModel> products;

  SubCategoryItem({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: product.urlImage.isNotEmpty
                              ? Image.network(
                                  product.urlImage,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 150,
                                )
                              : Icon(
                                  Icons.shopping_bag,
                                  size: 80,
                                  color: Colors.grey[300],
                                ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          product.nombre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.descripcion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Price: \$${product.precioVenta.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            print('Clicked on ${product.nombre}');
                          },
                          child: Text('Ver Producto'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
