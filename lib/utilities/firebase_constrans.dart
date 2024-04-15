import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

int subScriptionAmount = 100;

CollectionReference userCollectionReference =
    FirebaseFirestore.instance.collection("users");

CollectionReference storiesCollectionReference =
    FirebaseFirestore.instance.collection("stories");

CollectionReference bluetickRequestsCollectionReference =
    FirebaseFirestore.instance.collection("bluetickRequests");

CollectionReference HelplineRequestCollectionReference =
    FirebaseFirestore.instance.collection("helpline");

CollectionReference ConnectedToAllAuthRequestsCollectionReference =
    FirebaseFirestore.instance.collection("bluetickRequests");

CollectionReference subscriptionCollectionReference =
    FirebaseFirestore.instance.collection("Subscriptions");

firebase_storage.Reference storiesStorageReference =
    firebase_storage.FirebaseStorage.instance.ref().child('stories');
