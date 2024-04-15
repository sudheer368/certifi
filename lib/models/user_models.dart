import 'dart:collection';

class UserModel {
  String uid;
  dynamic createdAt;
  String username;
  String fullName;
  String email;
  String bio;
  String location;
  String phoneNumber;
  String category;
  String profilePic;
  bool isVerified; // for bluetick
  String address = "";
  dynamic latitude = "";
  dynamic longitude = "";
  String Samplelocation = "";
  String platform = "";

  UserModel(
      {this.uid = "",
      this.createdAt,
      this.username = "",
      this.fullName = "",
      this.email = "",
      this.bio = "",
      this.location = "",
      this.phoneNumber = "",
      this.category = "",
      this.profilePic = "",
      this.isVerified = false,
      this.address = "",
      this.latitude = "",
      this.longitude = "",
      this.Samplelocation = "",
      this.platform = ""});

// from firestore
  factory UserModel.fromMap(Map map) {
    return UserModel(
        uid: map['uid'] ?? "",
        createdAt: map['createdAt'],
        username: map['username'] ?? "",
        fullName: map['fullName'] ?? "",
        email: map['email'] ?? "",
        bio: map['bio'] ?? "",
        location: map['location'] ?? "",
        phoneNumber: map['phoneNumber'] ?? "",
        category: map['category'] ?? "",
        profilePic: map['profilePic'] ?? "",
        isVerified: map['isVerified'] ?? false,
        address: map['address'] ?? "",
        latitude: map['latitude'] ?? "",
        longitude: map['longitude'] ?? "",
        Samplelocation: map['Samplelocation'] ?? "",
        platform: map["platform"] ?? "");
  }

  // to firestore
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = HashMap();
    map["uid"] = uid;
    map["createdAt"] = createdAt;
    map["username"] = username;
    map["fullName"] = fullName;
    map["email"] = email;
    map["bio"] = bio;
    map["location"] = location;
    map["phoneNumber"] = phoneNumber;
    map["category"] = category;
    map["profilePic"] = profilePic;
    map['isVerified'] = isVerified;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map["platform"] = platform;
    map['Samplelocation'] = Samplelocation;
    return map;
  }
}
