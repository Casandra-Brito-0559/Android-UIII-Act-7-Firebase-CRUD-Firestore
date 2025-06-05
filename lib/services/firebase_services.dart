import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List>getPeople() async {
  List people=[];
  CollectionReference collectionReferencePeople=db.collection("people");
  QuerySnapshot queryPeople=await collectionReferencePeople.get();
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "name": data["name"],
       "uid": doc.id,
    };
    people.add(person);


  }

  await Future.delayed(const Duration(seconds: 5),);
  return people;
}
//Guardar en la base de datos
Future<void> addPeople(String name) async {
await db.collection("people").add({"name":name});
}


//Actualizar en la base de datos
Future<void> updatePeople(String uid,String newName) async {
await db.collection("people").doc(uid).update({"name":newName});
}

//Eliminar en la base de datos
Future<void> deletePeople(String uid) async {
await db.collection("people").doc(uid).delete();
}