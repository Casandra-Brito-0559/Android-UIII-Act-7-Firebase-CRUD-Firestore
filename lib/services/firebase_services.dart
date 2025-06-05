import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getLibros() async {
  List libros = [];
  CollectionReference collectionReferenceLibros = db.collection("Libros");
  QuerySnapshot queryLibros = await collectionReferenceLibros.get();

  for (var doc in queryLibros.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final libro = {
      "uid": doc.id,
      "titulo": data["titulo"],
      "autor": data["autor"],
      "genero": data["genero"],
      "fechapubli": data["fechapubli"],
      "precio": data["precio"],
      "cantidad": data["cantidad"],
    };
    libros.add(libro);
  }

  return libros;
}

Future<void> addLibro(Map<String, dynamic> libro) async {
  await db.collection("Libros").add(libro);
}

Future<void> updateLibro(String uid, Map<String, dynamic> libro) async {
  await db.collection("Libros").doc(uid).update(libro);
}

Future<void> deleteLibro(String uid) async {
  await db.collection("Libros").doc(uid).delete();
}