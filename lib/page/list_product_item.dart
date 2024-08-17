import 'package:flutter/material.dart';
import 'package:shopflutter/api/product_select.dart';
import 'package:shopflutter/models/product_model.dart';
import 'package:shopflutter/page/product_item.dart';
import 'package:shopflutter/widgets/side_menu.dart';

class ListProductItem extends StatefulWidget {
  const ListProductItem({super.key});

  @override
  State<ListProductItem> createState() => _ListProductItemState();
}

class _ListProductItemState extends State<ListProductItem> {
  List<ProductModel> products = [];
  final ProductSelect productService =
      ProductSelect(baseUrl: 'http://10.0.2.2:5000');

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  fetchProducts() async {
    try {
      final products = await productService.fetchProducts();
      setState(() {
        this.products = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas en la cuadrícula
                childAspectRatio: 0.7, // Relación de aspecto de cada elemento
                crossAxisSpacing: 8, // Espacio horizontal entre los elementos
                mainAxisSpacing: 8, // Espacio vertical entre los elementos
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
                            // Navega a la nueva pantalla mostrando los detalles del producto
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductItem(product: product),
                              ),
                            );
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
      drawer: SideMenu(),
    );
  }
}
