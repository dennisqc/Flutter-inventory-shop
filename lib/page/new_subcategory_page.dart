import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopflutter/widgets/side_menu.dart';

class NewSubcategoryPage extends StatefulWidget {
  @override
  _NewSubcategoryPageState createState() => _NewSubcategoryPageState();
}

class _NewSubcategoryPageState extends State<NewSubcategoryPage> {
  List<Map<String, dynamic>> categories = [];
  String? selectedCategory;
  final TextEditingController _subCategoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/categoriasall'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          categories = data
              .map((category) => {
                    'CategoriaID': category['CategoriaID'],
                    'Nombre': category['Nombre'],
                  })
              .toList();
        });
      } else {
        _showSnackbar('Error al cargar categorías: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackbar('Error de conexión: $e');
      debugPrint('Error en fetchCategories: $e');
    }
  }

  Future<void> addNewSubcategory(String subcategoryName) async {
    if (selectedCategory != null && subcategoryName.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:5000/subcategoriasinsert'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'Nombre': subcategoryName,
            'CategoriaID': selectedCategory,
          }),
        );

        if (response.statusCode == 201) {
          _showSnackbar('Subcategoría agregada exitosamente');
          setState(() {
            _subCategoryController.clear();
            selectedCategory = null; // Reset category selection
          });
        } else {
          _showSnackbar(
              'Error al agregar subcategoría: ${response.statusCode}');
        }
      } catch (e) {
        _showSnackbar('Error de conexión: $e');
        debugPrint('Error en addNewSubcategory: $e');
      }
    } else {
      _showSnackbar('Por favor, completa todos los campos');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Subcategoría'),
        backgroundColor: Color(0xFF586FA9), // Color azul personalizado
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciona una categoría:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategory,
              items: categories.map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem<String>(
                  value: category['CategoriaID'].toString(),
                  child: Text(category['Nombre']),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              hint: Text('Selecciona una categoría'),
              isExpanded: true,
            ),
            SizedBox(height: 20),
            Text(
              'Nombre de la nueva subcategoría:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _subCategoryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el nombre de la subcategoría',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newSubcategoryName = _subCategoryController.text;
                addNewSubcategory(newSubcategoryName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF586FA9), // Color azul personalizado
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text('Guardar Subcategoría'),
            ),
          ],
        ),
      ),
      drawer: SideMenu(),
    );
  }
}

void main() => runApp(MaterialApp(home: NewSubcategoryPage()));
