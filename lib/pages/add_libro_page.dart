import 'package:flutter/material.dart';
import '../services/firebase_services.dart';

class AddLibroPage extends StatefulWidget {
  const AddLibroPage({super.key});

  @override
  State<AddLibroPage> createState() => _AddLibroPageState();
}

class _AddLibroPageState extends State<AddLibroPage> {
  final Map<String, TextEditingController> controllers = {
    "titulo": TextEditingController(),
    "autor": TextEditingController(),
    "genero": TextEditingController(),
    "fechapubli": TextEditingController(),
    "precio": TextEditingController(),
    "cantidad": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agregar Libro",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            for (var key in controllers.keys)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: controllers[key],
                  keyboardType:
                      (key == 'precio' || key == 'cantidad')
                          ? TextInputType.number
                          : TextInputType.text,
                  decoration: InputDecoration(
                    labelText: _formatLabel(key),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: _getIconForField(key),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await addLibro({
                    "titulo": controllers["titulo"]!.text,
                    "autor": controllers["autor"]!.text,
                    "genero": controllers["genero"]!.text,
                    "fechapubli": controllers["fechapubli"]!.text,
                    "precio": double.parse(controllers["precio"]!.text),
                    "cantidad": int.parse(controllers["cantidad"]!.text),
                  });
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text("Guardar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatLabel(String key) {
    switch (key) {
      case "fechapubli":
        return "Fecha de Publicación";
      default:
        return key[0].toUpperCase() + key.substring(1);
    }
  }

  Icon _getIconForField(String key) {
    switch (key) {
      case "titulo":
        return const Icon(Icons.book);
      case "autor":
        return const Icon(Icons.person);
      case "genero":
        return const Icon(Icons.category);
      case "fechapubli":
        return const Icon(Icons.date_range);
      case "precio":
        return const Icon(Icons.attach_money);
      case "cantidad":
        return const Icon(Icons.confirmation_number);
      default:
        return const Icon(Icons.text_fields);
    }
  }
}
