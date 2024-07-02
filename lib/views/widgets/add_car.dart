import 'dart:io';

import 'package:dars67/controllers/cars_controller.dart';
import 'package:dars67/models/car.dart';
import 'package:dars67/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ManageCar extends StatefulWidget {
  ManageCar({super.key, this.car});

  final Car? car;

  @override
  State<ManageCar> createState() => _ManageCarState();
}

class _ManageCarState extends State<ManageCar> {
  final nameController = TextEditingController();
  File? imageFile;

  @override
  void initState() {
    super.initState();

    if (widget.car != null) {
      nameController.text = widget.car!.name;
    }
  }

  void uploadImage(ImageSource imageSource) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(source: imageSource);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final carsController = context.read<CarsController>();
    // Provider.of<CarsController>(context, listen: false)

    return AlertDialog(
      title: Text(widget.car == null ? "Qo'shish" : "O'zgartirish"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mashina nomi",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Rasm Tanlang",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    uploadImage(ImageSource.camera);
                  },
                  label: const Text("Kamera"),
                  icon: const Icon(Icons.camera),
                ),
                TextButton.icon(
                  onPressed: () {
                    uploadImage(ImageSource.gallery);
                  },
                  label: const Text("Galleriya"),
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
            if (imageFile != null)
              SizedBox(
                height: 200,
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            if (widget.car != null && imageFile == null)
              SizedBox(
                height: 200,
                child: Image.network(
                  widget.car!.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
          ],
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
            Helpers.showProgressDialog(context);
            final carsController = context.read<CarsController>();

            if (widget.car == null) {
              await carsController.addCar(nameController.text, imageFile!);
            } else {
              await carsController.editCar(
                id: widget.car!.id,
                oldImageUrl: widget.car!.imageUrl,
                newName: nameController.text,
                newFile: imageFile!,
              );
            }

            if (context.mounted) {
              Navigator.pop(context); // progress dialog yopamiz
              Navigator.pop(context); // add car dialog yopamiz
            }
          },
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
