import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/service_model.dart';
import '../viewmodels/barber_viewmodel.dart';

class DetailView extends StatefulWidget {
  final ServiceModel service;
  const DetailView({super.key, required this.service});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final BarberViewModel viewModel = BarberViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightBlue,
      appBar: AppBar(
        backgroundColor: AppColors.midnightBlue,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const Text('CONFIRMAR RESERVA', style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text('Resumen: ${widget.service.name}', style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                 Text('${widget.service.durationMinutes} min | \$${widget.service.price.toStringAsFixed(0)}', 
                  style: const TextStyle(color: AppColors.goldenPalm, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('Selecciona el día:', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.availableDates.length,
                itemBuilder: (context, index) {
                  final date = viewModel.availableDates[index];
                  final isSelected = viewModel.selectedDate == date;
                  return GestureDetector(
                    onTap: () => setState(() => viewModel.selectDate(date)),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.goldenPalm : AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(date, style: TextStyle(color: isSelected ? AppColors.midnightBlue : AppColors.white, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Horarios disponibles:', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: viewModel.availableTimes.map((time) {
                final isSelected = viewModel.selectedTime == time;
                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  selectedColor: AppColors.goldenPalm,
                  backgroundColor: AppColors.surfaceDark,
                  labelStyle: TextStyle(color: isSelected ? AppColors.midnightBlue : AppColors.white),
                  onSelected: (bool selected) {
                    setState(() => viewModel.selectTime(time));
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldenPalm,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('¡Turno confirmado con éxito!')),
                  );
                },
                child: const Text('CONFIRMAR TURNO', style: TextStyle(color: AppColors.midnightBlue, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}