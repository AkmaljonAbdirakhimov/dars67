import 'dart:convert';

import 'package:dars67/controllers/cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCar extends StatelessWidget {
  AddCar({super.key});

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final carsController = context.read<CarsController>();
    // Provider.of<CarsController>(context, listen: false)

    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Mashina nomi",
        suffixIcon: IconButton(
          onPressed: () {
            carsController.addCar(nameController.text);
            nameController.clear();
          },
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
