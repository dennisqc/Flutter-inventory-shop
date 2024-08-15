import 'package:flutter/material.dart';
import 'package:shopflutter/api/product_select.dart';
import 'package:shopflutter/models/product_model.dart';

class ListProductItem extends StatefulWidget {
  const ListProductItem({super.key});

  @override
  State<ListProductItem> createState() => _ListProductItemState();
}

class _ListProductItemState extends State<ListProductItem> {
  List<ProductModel> products = [];
  final ProductSelect productService = ProductSelect(baseUrl: 'http://10.0.2.2:5000'); // Para emulador de Android

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
        title: Text('Product List'),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator()) // Mostrar indicador de carga
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.nombre),
                  subtitle: Text('Price: \$${product.precioVenta}'),
                );
              },
            ),
    );
  }
}
