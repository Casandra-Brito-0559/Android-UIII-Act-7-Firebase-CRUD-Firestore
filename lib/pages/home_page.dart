import 'package:flutter/material.dart';
import '../services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Libros",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        elevation: 4,
      ),
      body: FutureBuilder(
        future: getLibros(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final libro = snapshot.data?[index];
                return Dismissible(
                  key: Key(libro["uid"]),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    // Confirmación antes de eliminar
                    return await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text("¿Eliminar \"${libro["titulo"]}\"?"),
                          content: const Text(
                            "Esta acción no se puede deshacer.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Sí, eliminar"),
                            ),
                          ],
                        );
                      },
                    ) ?? false; // Por si el usuario cierra el diálogo
                  },
                  onDismissed: (_) async {
                    await deleteLibro(libro["uid"]);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Libro \"${libro["titulo"]}\" eliminado."),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      title: Text(
                        libro["titulo"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "${libro["autor"]} • ${libro["genero"]}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: libro,
                        );
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Agregar nuevo libro',
      ),
    );
  }
}
