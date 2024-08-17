import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopflutter/page/list_product_item.dart';
import 'package:shopflutter/widgets/side_menu.dart';
import '../models/product_model.dart';

class EditItem extends StatefulWidget {
  final ProductModel product;

  const EditItem({required this.product, super.key});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditItem> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _pricePurchaseController;
  late final TextEditingController _priceSaleController;
  late final TextEditingController _stockController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _skuController;

  final Color _customBlue = Color(0xFF586FA9); // Azul personalizado

  String? selectedSubCategory; // Valor seleccionado para el DropdownButton

  List<Map<String, String>> subCategories = [];

  @override
  void initState() {
    super.initState();
    _nameController = _createController(widget.product.nombre);
    _descriptionController = _createController(widget.product.descripcion);
    _pricePurchaseController =
        _createController(widget.product.precioCompra.toString());
    _priceSaleController =
        _createController(widget.product.precioVenta.toString());
    _stockController =
        _createController(widget.product.cantidadEnStock.toString());
    _imageUrlController = _createController(widget.product.urlImage);
    _skuController = _createController(widget.product.sku);

    fetchSubCategories();
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
    super.dispose();
  }

  TextEditingController _createController(String text) {
    return TextEditingController(text: text);
  }

  Future<void> fetchSubCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/subcategorias'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final uniqueSubCategories = <Map<String, String>>[];
        final seenIds = <String>{};

        for (var item in data) {
          final id = item['SubCategoriaID'].toString();
          final name = item['Nombre'].toString();
          if (id.isNotEmpty && !seenIds.contains(id)) {
            uniqueSubCategories.add({
              'SubCategoriaID': id,
              'Nombre': name,
            });
            seenIds.add(id);
          }
        }

        setState(() {
          subCategories = uniqueSubCategories;
          selectedSubCategory =
              widget.product.subCategoriaId.toString(); // Set initial value
        });
      } else {
        throw Exception('Failed to load subcategories');
      }
    } catch (e) {
      print('Error fetching subcategories: $e');
    }
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProduct = ProductModel(
        productoID: widget.product.productoID,
        nombre: _nameController.text.trim(),
        descripcion: _descriptionController.text.trim(),
        precioCompra: double.tryParse(_pricePurchaseController.text) ?? 0.0,
        precioVenta: double.tryParse(_priceSaleController.text) ?? 0.0,
        cantidadEnStock: int.tryParse(_stockController.text) ?? 0,
        fechaCreacion: widget.product.fechaCreacion,
        urlImage: _imageUrlController.text.trim(),
        sku: _skuController.text.trim(),
        categoria: widget.product.categoria,
        subCategoria: selectedSubCategory ?? '', // Usar el valor seleccionado
        categoriaId: widget.product.categoriaId,
        stock: widget.product.stock,
        subCategoriaId:
            int.tryParse(selectedSubCategory!) ?? widget.product.subCategoriaId,
      );

      final jsonBody = jsonEncode(updatedProduct.toJson());
      print('Request body: $jsonBody');

      try {
        final response = await http.put(
          Uri.parse(
              'http://10.0.2.2:5000/productos/${widget.product.productoID}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonBody,
        );
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          print('Product updated successfully');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListProductItem(),
            ),
          ); // Pasar true para indicar que se actualizó
        } else {
          print('Failed to update product');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: _customBlue),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _customBlue),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: _customBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _nameController,
                labelText: 'Name',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a name'
                    : null,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Description',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _pricePurchaseController,
                labelText: 'Purchase Price',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a purchase price'
                    : null,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _priceSaleController,
                labelText: 'Sale Price',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a sale price'
                    : null,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _stockController,
                labelText: 'Stock',
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter stock quantity'
                    : null,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _imageUrlController,
                labelText: 'Image URL',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the image URL'
                    : null,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _skuController,
                labelText: 'SKU',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the SKU'
                    : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedSubCategory,
                decoration: InputDecoration(labelText: 'Sub-Category'),
                items: subCategories.map((subCategory) {
                  return DropdownMenuItem<String>(
                    value: subCategory['SubCategoriaID'],
                    child: Text(subCategory['Nombre'] ?? ''),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSubCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a sub-category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _customBlue,
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
