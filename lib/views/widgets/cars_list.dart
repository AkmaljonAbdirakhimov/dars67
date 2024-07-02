import 'package:dars67/controllers/cars_controller.dart';
import 'package:dars67/models/car.dart';
import 'package:dars67/utils/helpers.dart';
import 'package:dars67/views/widgets/add_car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarsList extends StatefulWidget {
  const CarsList({super.key});

  @override
  State<CarsList> createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  final nameController = TextEditingController();

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
                    return Card(
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(car.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  car.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        Helpers.showProgressDialog(context);
                                        await carsController.deleteCar(
                                          car.id,
                                          car.imageUrl,
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return ManageCar(car: car);
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
