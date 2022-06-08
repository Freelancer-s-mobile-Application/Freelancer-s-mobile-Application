class User {
  String id;
  String username;
  String email;
  String address;
  String displayname;
  String phonenumber;
  String description;
  String majorId;

  User(this.username, this.email, this.address, this.displayname,
      this.phonenumber, this.description, this.majorId, this.id);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "address": address,
      "displayname": displayname,
      "phonenumber": phonenumber,
      "description": description,
      "major_id": majorId,
    };
  }

  fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    email = map['email'];
    address = map['address'];
    displayname = map['displayname'];
    phonenumber = map['phonenumber'];
    description = map['description'];
    majorId = map['majorId'];
  }
}
