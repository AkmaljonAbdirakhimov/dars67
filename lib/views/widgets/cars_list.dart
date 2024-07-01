import 'package:dars67/controllers/cars_controller.dart';
import 'package:dars67/models/car.dart';
import 'package:dars67/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsList extends StatefulWidget {
  const CarsList({super.key});

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  final nameController = TextEditingController();

  void editCar(Car car) {
    nameController.text = car.name;
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("O'zgaritish"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Mashina nomi",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Bekor Qilish"),
            ),
            FilledButton(
              onPressed: () async {
                final carsController = context.read<CarsController>();
                carsController.editCar(car.id, nameController.text);
                Navigator.pop(context);
              },
              child: const Text("Saqlash"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carsController = context.watch<CarsController>();
    // Provider.of<CarsController>(context)
    // Provider.of<CarsController>(context, listen: true)

    return Expanded(
      child: StreamBuilder(
        stream: carsController.list,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text("Mashinalar mavjud emas."),
            );
          }

          final cars = snapshot.data!.docs;

          return cars.isEmpty
              ? const Center(
                  child: Text("Mashinalar mavjud emas."),
                )
              : ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (ctx, index) {
                    final car = Car.fromMap(cars[index]);
                    return ListTile(
                      onTap: () {
                        editCar(car);
                      },
                      title: Text(car.name),
                      trailing: IconButton(
                        onPressed: () async {
                          Helpers.showProgressDialog(context);
                          await carsController.deleteCar(car.id);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
