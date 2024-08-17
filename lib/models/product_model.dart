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
  final int categoriaId;
  final String subCategoria;
  final int subCategoriaId;
  final int stock;

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
    required this.categoriaId,
    required this.subCategoriaId,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productoID: json['ProductoID'] ??
          0, // Proporciona un valor predeterminado si es null
      nombre: json['Nombre'] ?? '',
      descripcion: json['Descripcion'] ?? '',
      precioCompra: (json['PrecioCompra'] is String
          ? double.tryParse(json['PrecioCompra']) ?? 0.0
          : (json['PrecioCompra'] as num).toDouble()),
      precioVenta: (json['PrecioVenta'] is String
          ? double.tryParse(json['PrecioVenta']) ?? 0.0
          : (json['PrecioVenta'] as num).toDouble()),
      cantidadEnStock: json['CantidadEnStock'] ?? 0,
      fechaCreacion: json['FechaCreacion'] ?? '',
      urlImage: json['urlImage'] ?? '',
      sku: json['sku'] ?? '',
      categoria: json['Categoria'] ?? '',
      subCategoria: json['SubCategoria'] ?? '',
      categoriaId: json['CategoriaID'] ?? 0,
      subCategoriaId: json['SubCategoriaID'] ?? 0,
      stock:  json['stock'] ?? 0,
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
      'SubCategoria': subCategoria,
      'SubCategoriaID': subCategoriaId,
      'CategoriaID': categoriaId,
      'stock':stock,
    };
  }
}
