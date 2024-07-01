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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddCar(),
            const SizedBox(height: 20),
            const Text(
              "List of Cars",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const CarsList(),
          ],
        ),
      ),
    );
  }
}
