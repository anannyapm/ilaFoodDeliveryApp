
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


final Future<FirebaseApp> firbaseInitialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final firebaseMessaging = FirebaseMessaging.instance;


FirebaseAuth auth = FirebaseAuth.instance;
late CollectionReference userCollectionRef;
late CollectionReference restaurantCollectionRef;
late CollectionReference productCollectionRef;
late CollectionReference carouselCollectionRef;
late CollectionReference categoryCollectionRef;
late CollectionReference orderCollectionRef;
late CollectionReference notificationCollectionRef;


