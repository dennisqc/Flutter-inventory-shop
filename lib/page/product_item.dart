import 'package:flutter/material.dart';
import 'package:shopflutter/page/edit_item.dart';
import 'package:shopflutter/widgets/side_menu.dart';
import '../models/product_model.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;

  const ProductItem({
    required this.product,
    super.key,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late ProductModel _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  void _refreshProduct() async {
    // Aquí podrías implementar una lógica para obtener el producto actualizado
    // Por ejemplo, hacer una solicitud HTTP para obtener el producto actualizado
    // Suponiendo que tienes un método para obtener el producto por ID
    // final updatedProduct = await _fetchProduct(widget.product.productoID);
    // setState(() {
    //   _product = updatedProduct;
    // });
    // Para simplificar, solo llamamos a setState
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Color(0xFF586FA9), // Azul marino
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _product.urlImage.isNotEmpty
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        _product.urlImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
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
                      _product.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF586FA9), // Azul marino
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Description: ${_product.descripcion}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'SKU: ${_product.sku}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Compra Price: S/.${_product.precioCompra.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sale Price: S/.${_product.precioVenta.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.greenAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Stock: ${_product.cantidadEnStock}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Category: ${_product.categoria}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sub-Category: ${_product.subCategoria}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditItem(
                              product: _product,
                            ),
                          ),
                        );

                        // Si se realizaron cambios, actualizamos la vista
                        if (result == true) {
                          _refreshProduct();
                        }
                      },
                      child: Text('Editar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF586FA9), // Azul marino
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF586FA9), // Azul marino
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: SideMenu(),
    );
  }
}
