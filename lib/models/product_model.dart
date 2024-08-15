class ProductModel {
  final int productoID;
  final String nombre;
  final String descripcion;
  final double precioCompra;
  final double precioVenta;
  final int cantidadEnStock;
  final String fechaCreacion;

  ProductModel({
    required this.productoID,
    required this.nombre,
    required this.descripcion,
    required this.precioCompra,
    required this.precioVenta,
    required this.cantidadEnStock,
    required this.fechaCreacion,
  });

  // Factory constructor to create a Product instance from a JSON object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productoID: json['ProductoID'],
      nombre: json['Nombre'],
      descripcion: json['Descripcion'],
      // Manejar el caso donde el valor podría ser una cadena
      precioCompra: (json['PrecioCompra'] is String
          ? double.parse(json['PrecioCompra'])
          : json['PrecioCompra'].toDouble()),
      precioVenta: (json['PrecioVenta'] is String
          ? double.parse(json['PrecioVenta'])
          : json['PrecioVenta'].toDouble()),
      cantidadEnStock: json['CantidadEnStock'],
      fechaCreacion: json['FechaCreacion'],
    );
  }

  // Method to convert a Product instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'ProductoID': productoID,
      'Nombre': nombre,
      'Descripcion': descripcion,
      'PrecioCompra': precioCompra,
      'PrecioVenta': precioVenta,
      'CantidadEnStock': cantidadEnStock,
      'FechaCreacion': fechaCreacion,
    };
  }
}
