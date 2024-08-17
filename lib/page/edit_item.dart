import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopflutter/widgets/side_menu.dart';
import 'dart:convert';
import '../models/product_model.dart';

class EditItem extends StatefulWidget {
  final ProductModel product;

  const EditItem({
    required this.product,
    super.key,
  });

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditItem> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _pricePurchaseController;
  late TextEditingController _priceSaleController;
  late TextEditingController _stockController;
  late TextEditingController _imageUrlController;
  late TextEditingController _skuController;
  late TextEditingController _subCategoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.nombre);
    _descriptionController =
        TextEditingController(text: widget.product.descripcion);
    _pricePurchaseController =
        TextEditingController(text: widget.product.precioCompra.toString());
    _priceSaleController =
        TextEditingController(text: widget.product.precioVenta.toString());
    _stockController =
        TextEditingController(text: widget.product.cantidadEnStock.toString());
    _imageUrlController = TextEditingController(text: widget.product.urlImage);
    _skuController = TextEditingController(text: widget.product.sku);
    _subCategoryController =
        TextEditingController(text: widget.product.subCategoriaId.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _pricePurchaseController.dispose();
    _priceSaleController.dispose();
    _stockController.dispose();
    _imageUrlController.dispose();
    _skuController.dispose();
    _subCategoryController.dispose();
    super.dispose();
  }

  Future<void> updateProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      print('Image URL: ${_imageUrlController.text}'); // Verifica el valor aquí

      final updatedProduct = ProductModel(
        productoID: widget.product.productoID,
        nombre: _nameController.text.trim(),
        descripcion: _descriptionController.text.trim(),
        precioCompra: double.tryParse(_pricePurchaseController.text) ?? 0.0,
        precioVenta: double.tryParse(_priceSaleController.text) ?? 0.0,
        cantidadEnStock: int.tryParse(_stockController.text) ?? 0,
        fechaCreacion: widget
            .product.fechaCreacion, // Mantener la fecha de creación original
        urlImage: _imageUrlController.text.trim(),
        sku: _skuController.text.trim(),
        categoria: widget.product.categoria, // Mantener la categoría original
        subCategoria:
            widget.product.subCategoria, // Mantener la subcategoría original
        categoriaId: widget
            .product.categoriaId, // Mantener el ID de la categoría original
        subCategoriaId: int.tryParse(_subCategoryController.text) ??
            widget.product.subCategoriaId, // Modificar el ID de la subcategoría
      );
      // Convertir el modelo a JSON y verificar el cuerpo de la solicitud
      final jsonBody = jsonEncode(updatedProduct.toJson());
      print(
          'Request body: $jsonBody'); // Imprimir el cuerpo de la solicitud para depuración

      try {
        final response = await http.put(
          Uri.parse(
              'http://10.0.2.2:5000/productos/${widget.product.productoID}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(updatedProduct.toJson()),
        );
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          print('Product updated successfully');
          Navigator.pop(context);
        } else {
          print('Failed to update product');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pricePurchaseController,
                decoration: InputDecoration(labelText: 'Purchase Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a purchase price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceSaleController,
                decoration: InputDecoration(labelText: 'Sale Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a sale price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(labelText: 'SKU'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the SKU';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subCategoryController,
                decoration: InputDecoration(labelText: 'Sub-Category ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the sub-category ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: updateProduct,
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 36),
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
