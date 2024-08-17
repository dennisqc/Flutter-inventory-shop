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
  bool isLoading = true;
  bool hasError = false;
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
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
        backgroundColor: Color(0xFF586FA9), // Azul oscuro
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(child: Text('Error loading products'))
              : products.isEmpty
                  ? Center(child: Text('No products available'))
                  : GridView.builder(
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Color(0xFFE6F0FF), // Azul claro
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
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(
                                              Icons.error,
                                              size: 80,
                                              color: Colors.grey[400],
                                            );
                                          },
                                        )
                                      : Icon(
                                          Icons.error,
                                          size: 80,
                                          color: Colors.grey[400],
                                        ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product.nombre,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF003366), // Azul oscuro
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  product.descripcion,
                                  style: TextStyle(
                                    color: Color(0xFF0066CC), // Azul medio
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Precio: S/.${product.precioVenta.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Text(
                                  'Stock: ${product.cantidadEnStock}',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
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
                                    backgroundColor:
                                        Color(0xFF586FA9), // Azul oscuro
                                    //  onPrimary: Colors.white, // Color del texto
                                    minimumSize: Size(double.infinity, 36),
                                    elevation: 4,
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
