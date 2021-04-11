import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_coffee/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Collection refernce
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugar': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snaqpshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.data()['name'] ?? "",
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugars'] ?? '0');
    }).toList();
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
