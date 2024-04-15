import 'dart:collection';
import 'dart:developer';
import 'package:flutter_application_1/models/user_models.dart';
import 'package:flutter_application_1/utilities/firebase_constrans.dart';
import 'package:flutter_application_1/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserProfileController extends GetxController {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController categoryTextEditingController = TextEditingController();
  TextEditingController somematterTextEditingController =
      TextEditingController();
  TextEditingController labeIconTextEditingController = TextEditingController();
  TextEditingController labelmatterTextEditingController =
      TextEditingController();
  TextEditingController helpmessageTextEditingController =
      TextEditingController();

  UserModel myUserModel = UserModel();

  bool isLoading = false;

  updateProfile({UserModel? userModel}) async {
    userModel ??= UserModel();
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    userModel.username = userNameTextEditingController.text.toLowerCase();
    userModel.fullName = fullNameTextEditingController.text;
    userModel.bio = bioTextEditingController.text;
    userModel.location = locationTextEditingController.text;
    userModel.category = categoryTextEditingController.text;
    userModel.phoneNumber = phoneNumberTextEditingController.text;

    // todo
    myUserModel.username = userModel.username;
    myUserModel.fullName = userModel.fullName;
    myUserModel.bio = userModel.bio;
    myUserModel.location = userModel.location;
    myUserModel.category = userModel.category;
    myUserModel.phoneNumber = userModel.phoneNumber;

    Map<String, dynamic> map = HashMap();
    map['username'] = userNameTextEditingController.text;
    map['bio'] = bioTextEditingController.text;
    map['fullName'] = fullNameTextEditingController.text;
    map['location'] = locationTextEditingController.text;
    map['category'] = categoryTextEditingController.text;
    map['phoneNumber'] = phoneNumberTextEditingController.text;
    map['Somematter'] = somematterTextEditingController.text;
    map['labelIcon'] = labeIconTextEditingController.text;
    map['labelmatter'] = labelmatterTextEditingController.text;
    map['helpmessage'] = helpmessageTextEditingController.text;
    // await userCollectionReference.doc(uid).update(map);
    Utilities.showToast("Profile details updated successfully.");
    Get.back();
  }

  // createAccount({UserModel? userModel}) async {
  //   try {
  //     userModel ??= UserModel();
  //     User user = FirebaseAuth.instance.currentUser!;
  //     userModel.username = user.email!.split("@")[0];
  //     userModel.fullName = user.displayName ?? "";
  //     userModel.email = user.email ?? "";
  //     userModel.uid = user.uid;
  //     userModel.createdAt = FieldValue.serverTimestamp(); // Add this line
  //     userModel.profilePic = user.photoURL ?? "";
  //     userModel.platform = Utilities().getCurrentPlafom();
  //     await userCollectionReference.doc(user.uid).set(userModel.toMap());
  //     Utilities.showToast("Successfully, created account, welcome to app");
  //   } catch (e) {
  //     Utilities.showToast("failed to create account $e");
  //   }
  // }
}
