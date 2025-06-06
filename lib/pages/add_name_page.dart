import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Añadir Nombre",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 129, 160, 245),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Ingrese el nombre"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await addPeople(nameController.text).then((_) {
                  Navigator.pop(context);
                });
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
