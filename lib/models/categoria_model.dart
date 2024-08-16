class CategoriaModel {
  final int id;
  final String nombre;

  CategoriaModel({required this.id, required this.nombre});

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      id: json['CategoriaID'],
      nombre: json['Nombre'],
    );
  }
}
