import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreData {
  final db = FirebaseFirestore.instanceFor(
    app: Firebase.app(),
    databaseId: 'oraklast',
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> getPointsStream() {
    return db.collection("points").snapshots();
  }
}
