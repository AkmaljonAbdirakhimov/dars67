import 'package:dars67/controllers/cars_controller.dart';
import 'package:dars67/views/widgets/add_car.dart';
import 'package:dars67/views/widgets/cars_list.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cars"),
        actions: [
          IconButton(
            onPressed: () {
              final firebaseAuth = FirebaseAuthService();
              firebaseAuth.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return ManageCar();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
