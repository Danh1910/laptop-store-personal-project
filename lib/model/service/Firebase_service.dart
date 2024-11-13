import 'package:firebase_core/firebase_core.dart';

class Firebase_service{
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
}