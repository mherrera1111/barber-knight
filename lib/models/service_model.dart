class ServiceModel {
  final String id;
  final String category;
  final String name;
  final String description;
  final int durationMinutes;
  final double price;

  ServiceModel({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'].toString(),
      category: json['categoria'] ?? '',
      name: json['nombre'] ?? '',
      description: json['descripcion'] ?? '',
      durationMinutes: int.tryParse(json['duracion_minutos'].toString()) ?? 0,
      price: double.tryParse(json['precio'].toString()) ?? 0.0,
    );
  }
}