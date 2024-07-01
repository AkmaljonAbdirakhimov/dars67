import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars67/models/car.dart';
import 'package:dars67/services/cars_firebase_service.dart';
import 'package:flutter/material.dart';

class CarsController with ChangeNotifier {
  final _carsFirebaseService = CarsFirebaseService();
  final List<Car> _list = [];

  Stream<QuerySnapshot> get list async* {
    yield* _carsFirebaseService.getCars();
  }

  Future<void> addCar(String name) async {
    await _carsFirebaseService.addCar(name);
  }

  Future<void> editCar(String id, String newName) async {
    await _carsFirebaseService.editCar(id, newName);
  }

  Future<void> deleteCar(String id) async {
    await _carsFirebaseService.delete(id);
  }
}
