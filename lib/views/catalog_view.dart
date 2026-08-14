import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/service_model.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> with SingleTickerProviderStateMixin {
  List<ServiceModel> _todosLosServicios = [];
  bool _cargando = true;
  String _busqueda = '';
  late TabController _tabController;

  // Colores oficiales de Barber Knight
  static const Color colorAzul = Color(0xFF002654);
  static const Color colorGolden = Color(0xFFAA8E0A);
  static const Color colorBlanco = Colors.white;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchServicios();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchServicios() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/barber_knight_api/get_servicios.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _todosLosServicios = data.map((json) => ServiceModel.fromJson(json)).toList();
          _cargando = false;
        });
      }
    } catch (e) {
      setState(() {
        _cargando = false;
      });
    }
  }

  List<ServiceModel> _filtrarPorCategoriaYBusqueda(String categoria) {
    return _todosLosServicios.where((servicio) {
      final coincideCategoria = servicio.category.toLowerCase() == categoria.toLowerCase();
      final coincideBusqueda = servicio.name.toLowerCase().contains(_busqueda.toLowerCase()) ||
          servicio.description.toLowerCase().contains(_busqueda.toLowerCase());
      return coincideCategoria && coincideBusqueda;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAzul, // Fondo principal azul corporativo
      appBar: AppBar(
        backgroundColor: colorAzul,
        elevation: 0,
        title: const Text("Catálogo de Servicios", style: TextStyle(color: colorBlanco)),
        iconTheme: const IconThemeData(color: colorBlanco),
        bottom: TabBar(
          controller: _tabController,
          labelColor: colorGolden, // Pestaña seleccionada en Golden
          unselectedLabelColor: colorBlanco70(0.7),
          indicatorColor: colorGolden,
          tabs: const [
            Tab(text: "Cabello"),
            Tab(text: "Barba"),
            Tab(text: "Facial"),
          ],
        ),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator(color: colorGolden))
          : Column(
              children: [
                // Barra de búsqueda con contraste adecuado
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    onChanged: (value) => setState(() => _busqueda = value),
                    style: const TextStyle(color: colorBlanco),
                    decoration: InputDecoration(
                      labelText: "Buscar procedimiento...",
                      labelStyle: TextStyle(color: colorBlanco.withOpacity(0.7)),
                      prefixIcon: const Icon(Icons.search, color: colorGolden),
                      filled: true,
                      fillColor: const Color(0xFF001B3A), // Tono azul más oscuro para el input
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // Contenido de las pestañas
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildListaServicios(_filtrarPorCategoriaYBusqueda('cabello')),
                      _buildListaServicios(_filtrarPorCategoriaYBusqueda('barba')),
                      _buildListaServicios(_filtrarPorCategoriaYBusqueda('facial')),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Color colorBlanco70(double opacity) => colorBlanco.withOpacity(opacity);

  Widget _buildListaServicios(List<ServiceModel> servicios) {
    if (servicios.isEmpty) {
      return Center(
        child: Text("No se encontraron servicios", style: TextStyle(color: colorBlanco.withOpacity(0.7), fontSize: 16)),
      );
    }

    return ListView.builder(
      itemCount: servicios.length,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        final servicio = servicios[index];
        return Card(
          color: const Color(0xFF001B3A), // Tarjeta en azul profundo para contraste perfecto
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorGolden.withOpacity(0.3), width: 1), // Sutil borde Golden
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        servicio.name,
                        style: const TextStyle(
                          color: colorBlanco,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "\$${servicio.price.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: colorGolden,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  servicio.description,
                  style: TextStyle(color: colorBlanco.withOpacity(0.8), fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: colorGolden),
                    const SizedBox(width: 6),
                    Text(
                      "Duración: ${servicio.durationMinutes} minutos",
                      style: TextStyle(color: colorBlanco.withOpacity(0.7), fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}