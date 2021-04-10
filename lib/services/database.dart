import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection refernce
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugar':sugars,
      'name':name,
      'strength':strength,
    });
  }
}
