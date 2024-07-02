import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars67/models/car.dart';
import 'package:dars67/services/firebase_storage_service.dart';

class CarsFirebaseService {
  final _firebaseFireStore = FirebaseFirestore.instance.collection("cars");
  final _firebaseStorageService = FirebaseStorageService();

  Stream<QuerySnapshot> getCars() async* {
    yield* _firebaseFireStore.snapshots();
  }

  Future<void> addCar(String name, File file) async {
    final imageUrl = await _firebaseStorageService.uploadFile(name, file);
    await _firebaseFireStore.add({
      "name": name,
      "imageUrl": imageUrl,
    });
  }

  Future<void> editCar({
    required String id,
    required String oldImageUrl,
    required String newName,
    required File newFile,
  }) async {
    final imageUrl = await _firebaseStorageService.changeFile(
      oldImageUrl: oldImageUrl,
      newFile: newFile,
    );

    await _firebaseFireStore.doc(id).update({
      "name": newName,
      "imageUrl": imageUrl,
    });
  }

  Future<void> delete(String id, String imageUrl) async {
    _firebaseStorageService.deleteFile(imageUrl);
    await _firebaseFireStore.doc(id).delete();
  }
}
