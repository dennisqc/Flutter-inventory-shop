import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopflutter/models/categoria_model.dart';


class CategoriaService {
  final String baseUrl;

  CategoriaService({required this.baseUrl});

  Future<List<CategoriaModel>> fetchCategorias() async {
    final response = await http.get(Uri.parse('$baseUrl/categorias'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((categoria) => CategoriaModel.fromJson(categoria)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
