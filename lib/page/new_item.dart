import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopflutter/page/list_product_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _pricePurchaseController;
  late TextEditingController _priceSaleController;
  late TextEditingController _stockController;
  late TextEditingController _skuController;
  late TextEditingController _imageUrlController;

  String? selectedSubCategory; // Valor seleccionado para el DropdownButton

  List<Map<String, String>> subCategories = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _pricePurchaseController = TextEditingController();
    _priceSaleController = TextEditingController();
    _stockController = TextEditingController();
    _skuController = TextEditingController();
    _imageUrlController = TextEditingController();

    fetchSubCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _pricePurchaseController.dispose();
    _priceSaleController.dispose();
    _stockController.dispose();
    _skuController.dispose();
    _imageUrlController.dispose();
    super.dispose();
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
          if (subCategories.isNotEmpty) {
            selectedSubCategory = subCategories[0]['SubCategoriaID'];
          }
        });
      } else {
        throw Exception('Failed to load subcategories');
      }
    } catch (e) {
      print('Error fetching subcategories: $e');
    }
  }

  Future<void> submitProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final newProduct = {
        'Nombre': _nameController.text.trim(),
        'Descripcion': _descriptionController.text.trim(),
        'PrecioCompra': double.tryParse(_pricePurchaseController.text) ?? 0.0,
        'PrecioVenta': double.tryParse(_priceSaleController.text) ?? 0.0,
        'CantidadEnStock': int.tryParse(_stockController.text) ?? 0,
        'sku': _skuController.text.trim(),
        'SubCategoria': selectedSubCategory ?? '', // Usar el valor seleccionado
        'URLImage': _imageUrlController.text.trim().isNotEmpty
            ? _imageUrlController.text.trim()
            : null, // La imagen es opcional
      };

      try {
        final response = await http.post(
          Uri.parse(
              'http://10.0.2.2:5000/productos'), // URL para enviar la información
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(newProduct),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Producto registrado con éxito')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ListProductItem(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al registrar el producto')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Producto'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pricePurchaseController,
                decoration: InputDecoration(labelText: 'Precio de Compra'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un precio de compra';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceSaleController,
                decoration: InputDecoration(labelText: 'Precio de Venta'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un precio de venta';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Cantidad en Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la cantidad en stock';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(labelText: 'SKU'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el SKU';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedSubCategory,
                decoration: InputDecoration(labelText: 'Subcategoría'),
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
                    return 'Por favor seleccione una subcategoría';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration:
                    InputDecoration(labelText: 'URL de Imagen (Opcional)'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitProduct,
                child: const Text('Registrar Producto'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 36),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
