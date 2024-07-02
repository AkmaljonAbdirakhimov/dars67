import 'dart:io';

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

  Future<void> addCar(String name, File file) async {
    await _carsFirebaseService.addCar(name, file);
  }

  Future<void> editCar({
    required String id,
    required String oldImageUrl,
    required String newName,
    required File newFile,
  }) async {
    await _carsFirebaseService.editCar(
      id: id,
      oldImageUrl: oldImageUrl,
      newName: newName,
      newFile: newFile,
    );
  }

  Future<void> deleteCar(String id, String imageUrl) async {
    await _carsFirebaseService.delete(id, imageUrl);
  }
}
