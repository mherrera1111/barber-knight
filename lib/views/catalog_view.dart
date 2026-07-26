import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../viewmodels/barber_viewmodel.dart';
import 'detail_view.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BarberViewModel();

    return Scaffold(
      backgroundColor: AppColors.midnightBlue,
      appBar: AppBar(
        backgroundColor: AppColors.midnightBlue,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text('NUESTROS SERVICIOS', style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.greyText.withOpacity(0.3)),
              ),
              child: const TextField(
                style: TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: AppColors.greyText),
                  hintText: 'Buscar servicio...',
                  hintStyle: TextStyle(color: AppColors.greyText),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.services.length,
                itemBuilder: (context, index) {
                  final service = viewModel.services[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.white)),
                          child: const Center(child: Text('X', style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(service.name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(service.description, style: const TextStyle(color: AppColors.greyText, fontSize: 12)),
                              const SizedBox(height: 6),
                              Text('Duración: ${service.duration}', style: const TextStyle(color: AppColors.white, fontSize: 12)),
                              Text('Precio: ${service.price}', style: const TextStyle(color: AppColors.goldenPalm, fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: AppColors.goldenPalm, size: 16),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => DetailView(service: service)));
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.goldenPalm,
        unselectedItemColor: AppColors.greyText,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Catálogo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pop(context);
        },
      ),
    );
  }
}