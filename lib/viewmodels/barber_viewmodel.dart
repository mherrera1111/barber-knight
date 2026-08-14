import 'package:flutter/material.dart';
import '../models/service_model.dart';

class BarberViewModel extends ChangeNotifier {
  // Si deseas mantener datos de prueba estáticos temporalmente adaptados al nuevo modelo:
  final List<ServiceModel> services = [
    ServiceModel(
      id: '1',
      category: 'cabello',
      name: 'Corte Tradicional',
      description: 'Corte con tijera y máquina.',
      durationMinutes: 30,
      price: 25000.0,
    ),
    ServiceModel(
      id: '2',
      category: 'barba',
      name: 'Barba Premium',
      description: 'Perfilado con toalla caliente.',
      durationMinutes: 30,
      price: 18000.0,
    ),
    ServiceModel(
      id: '3',
      category: 'facial',
      name: 'Cuidado Facial',
      description: 'Limpieza facial profunda.',
      durationMinutes: 90,
      price: 130000.0,
    ),
  ];

  String? selectedDate;
  String? selectedTime;

  final List<String> availableDates = ['Lu 06', 'Ma 07', 'Mi 08', 'Jue 09'];
  final List<String> availableTimes = ['09:00 AM', '10:30 AM', '02:00 PM', '04:30 PM', '05:00 PM'];

  void selectDate(String date) {
    selectedDate = date;
    notifyListeners();
  }

  void selectTime(String time) {
    selectedTime = time;
    notifyListeners();
  }
}