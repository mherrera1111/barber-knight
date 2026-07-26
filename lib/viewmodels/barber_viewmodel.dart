import 'package:flutter/material.dart';
import '../models/service_model.dart';

class BarberViewModel extends ChangeNotifier {
  final List<ServiceModel> services = [
    ServiceModel(name: 'Corte Tradicional', description: 'Corte con tijera y máquina.', duration: '30 minutos', price: '\$ 25.000'),
    ServiceModel(name: 'Barba Premium', description: 'Perfilado con toalla caliente.', duration: '30 minutos', price: '\$ 18.000'),
    ServiceModel(name: 'Cuidado Facial', description: 'Limpieza facial profunda.', duration: '90 minutos', price: '\$ 130.000'),
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