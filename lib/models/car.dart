import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String id;
  String name;

  Car(this.id, this.name);

  factory Car.fromMap(QueryDocumentSnapshot query) {
    return Car(
      query.id,
      query['name'],
    );
  }
}
