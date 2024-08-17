class ProductModel {
  final int productoID;
  final String nombre;
  final String descripcion;
  final double precioCompra;
  final double precioVenta;
  final int cantidadEnStock;
  final String fechaCreacion;
  final String urlImage;
  final String sku;
  final String categoria;
  final String subCategoria;

  ProductModel({
    required this.productoID,
    required this.nombre,
    required this.descripcion,
    required this.precioCompra,
    required this.precioVenta,
    required this.cantidadEnStock,
    required this.fechaCreacion,
    required this.urlImage,
    required this.sku,
    required this.categoria,
    required this.subCategoria,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productoID: json['ProductoID'],
      nombre: json['Nombre'],
      descripcion: json['Descripcion'],
      precioCompra: (json['PrecioCompra'] is String
          ? double.parse(json['PrecioCompra'])
          : json['PrecioCompra'].toDouble()),
      precioVenta: (json['PrecioVenta'] is String
          ? double.parse(json['PrecioVenta'])
          : json['PrecioVenta'].toDouble()),
      cantidadEnStock: json['CantidadEnStock'],
      fechaCreacion: json['FechaCreacion'],
      urlImage: json['urlImage'],
      sku: json['sku'],
      categoria: json['Categoria'],
      subCategoria: json['SubCategoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductoID': productoID,
      'Nombre': nombre,
      'Descripcion': descripcion,
      'PrecioCompra': precioCompra,
      'PrecioVenta': precioVenta,
      'CantidadEnStock': cantidadEnStock,
      'FechaCreacion': fechaCreacion,
      'sku': sku,
      'urlImage': urlImage,
      'Categoria': categoria,
      // 'SubCategoria': subCategoria,
    };
  }
}
