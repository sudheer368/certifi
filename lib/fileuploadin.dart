import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'controller/user_controller.dart';

class ImageUploading extends StatefulWidget {
  ImageUploading({Key? key}) : super(key: key);

  @override
  State<ImageUploading> createState() => _ImageUploadingState();
}

class _ImageUploadingState extends State<ImageUploading> {
  UserProfileController userProfileController =
      Get.put(UserProfileController());
  XFile? _image;
  bool _isSearching = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
  if (_image == null) {
    // No image selected
    return;
  }

  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child('profile_pics/${_image!.name}');
    UploadTask uploadTask = storageRef.putFile(File(_image!.path!));

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Upload progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    });

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    // Now you have the download URL, save it to your user's profile
    userProfileController.myUserModel.profilePic = downloadURL;

    // Update other profile details if needed
    userProfileController.updateProfile(); // Update profile in your controller

    // Optionally, you can show a success message or perform other UI updates
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image uploaded successfully')),
    );
  } catch (e) {
    print('Error uploading photo: $e');
    // Handle errors, show error message etc.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to upload image')),
    );
  }
}

  void _openSearchField() {
    setState(() {
      _isSearching = true;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _closeSearchField() {
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
                cursorColor:
                    Colors.white, // Add this line to set the cursor color
              )
            : Text(
                'Certi__uploding',
                style: TextStyle(color: Colors.white),
              ),
        actions: _isSearching
            ? [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _closeSearchField,
                ),
              ]
            : [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _openSearchField,
                ),
              ],
      ),
      body: GetBuilder<UserProfileController>(
        builder: (userProfileController) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the border radius as needed
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image != null
                                ? FileImage(File(_image!.path))
                                : userProfileController
                                            .myUserModel.profilePic !=
                                        null
                                    ? NetworkImage(userProfileController
                                        .myUserModel.profilePic!)
                                    : AssetImage(
                                        'assets/placeholder_image.png',
                                        package:
                                            'your_package_name', // Replace with your actual package name if applicable
                                      ) as ImageProvider<Object>,
                          ),
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                        bottom: -10,
                        left: 80,
                      )
                    ],
                  ),
                  TextField(
                    controller:
                        userProfileController.userNameTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'PERSON NAME',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    maxLength: 24,
                    maxLines: 1,
                    controller:
                        userProfileController.fullNameTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'ROLL NUMBER',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller:
                        userProfileController.emailTextEditingController,
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'YEAR',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: userProfileController.bioTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'School name',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: _uploadImage,
                    child: const Text('Upload'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
