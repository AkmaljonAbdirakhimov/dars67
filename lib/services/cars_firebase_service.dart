import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars67/models/car.dart';

class CarsFirebaseService {
  final _firebaseFireStore = FirebaseFirestore.instance.collection("cars");

  Stream<QuerySnapshot> getCars() async* {
    yield* _firebaseFireStore.snapshots();
  }

  Future<void> addCar(String name) async {
    await _firebaseFireStore.add({
      "name": name,
    });
  }

  Future<void> editCar(String id, String newName) async {
    await _firebaseFireStore.doc(id).update({
      "name": newName,
    });
  }

  Future<void> delete(String id) async {
    await _firebaseFireStore.doc(id).delete();
  }
}
