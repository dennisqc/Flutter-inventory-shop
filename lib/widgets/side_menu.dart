import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopflutter/models/product_model.dart';
import 'package:shopflutter/page/list_product_item.dart';
import 'package:shopflutter/page/new_item.dart';
import 'package:shopflutter/widgets/sub_category_item.dart';
import 'dart:convert';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:5000/categorias'));
      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
        });
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchProductsBySubcategory(int subcategoryId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:5000/productos?subcategoria_id=$subcategoryId'),
      );
      if (response.statusCode == 200) {
        List<dynamic> productsJson = json.decode(response.body);

        // Convertir cada producto JSON a ProductModel
        List<ProductModel> products = productsJson
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoryItem(products: products),
          ),
        );
      } else {
        print('Failed to load products');
      }
    } catch (e) {
      print('Error2: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
      },
      children: [
        UserAccountsDrawerHeader(
          currentAccountPictureSize: const Size.square(80.0),
          accountName: Text(
            "Nombre de Usuario",
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: Text(
            "usuario@correo.com",
            style: TextStyle(color: Colors.white70),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://dthezntil550i.cloudfront.net/f4/latest/f41908291942413280009640715/1280_960/1b2d9510-d66d-43a2-971a-cfcbb600e7fe.png"),
          ),
          decoration: BoxDecoration(
            color: Color(0xFF586FA9), // Azul marino
          ),
        ),
        ListTile(
          title: Text(
            "Productos",
            style: TextStyle(color: Color(0xFF586FA9)),
          ),
          leading: Icon(Icons.inventory, color: Color(0xFF586FA9)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListProductItem(),
              ),
            );
          },
        ),
        ...categories.map<Widget>((category) {
          return ExpansionTile(
            title: Text(
              category['Nombre'],
              style: TextStyle(color: Color(0xFF586FA9)),
            ),
            leading: Icon(Icons.category, color: Color(0xFF586FA9)),
            children: (category['Subcategorias'] as List<dynamic>)
                .map<Widget>((subcat) {
              return ListTile(
                title: Text(
                  subcat['Nombre'],
                  style: TextStyle(color: Colors.grey[800]),
                ),
                onTap: () {
                  fetchProductsBySubcategory(subcat['SubCategoriaID']);
                },
              );
            }).toList(),
          );
        }).toList(),
        Divider(),
        ListTile(
          title: Text(
            "Nuevo Producto",
            style: TextStyle(color: Color(0xFF586FA9)),
          ),
          leading: Icon(Icons.add_box, color: Color(0xFF586FA9)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewItem(),
              ),
            );
          },
        ),
        ListTile(
          title: Text(
            "Nueva Categoria",
            style: TextStyle(color: Color(0xFF586FA9)),
          ),
          leading: Icon(Icons.category, color: Color(0xFF586FA9)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewItem(),
              ),
            );
          },
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              // Acción para cerrar sesión
              print("Cerrar sesión");
            },
            child: Text("Cerrar sesión"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF586FA9), // Azul marino
            //  onPrimary: Colors.white,
              minimumSize: Size(double.infinity, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
