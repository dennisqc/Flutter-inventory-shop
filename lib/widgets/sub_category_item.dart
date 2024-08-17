import 'package:flutter/material.dart';
import 'package:shopflutter/models/product_model.dart';
import 'package:shopflutter/page/product_item.dart';
import 'package:shopflutter/widgets/side_menu.dart';

class SubCategoryItem extends StatelessWidget {
  final List<ProductModel> products;

  const SubCategoryItem({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        backgroundColor: Color(0xFF586FA9), // Azul marino
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
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(12)),
                            child: product.urlImage.isNotEmpty
                                ? Image.network(
                                    product.urlImage,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 150,
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    width: double.infinity,
                                    height: 150,
                                    child: Icon(
                                      Icons.shopping_bag,
                                      size: 80,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          product.nombre,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF586FA9), // Azul marino
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          product.sku,
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Precio: S/.${product.precioVenta.toStringAsFixed(2)}',
                          style: TextStyle(
                            // color: Colors.greenAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductItem(product: product),
                              ),
                            );
                          },
                          child: Text('Ver Producto'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF586FA9), // Azul marino
                            // onPrimary: Colors.white,
                            minimumSize: Size(double.infinity, 36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      drawer: SideMenu(),
    );
  }
}
