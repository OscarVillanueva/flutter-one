class User {
  String username;
  String password;

  int id;
  String name;
  String lastName;
  String phone;
  String email;
  String photo;

  User(this.username, this.password, this.name, this.lastName, this.phone,
      this.email, this.photo, this.id);

  User.fromLogin(this.username, this.password);

  factory User.fromJSON(Map<String, dynamic> map) {
    return User(map["username"], map["password"], map["name"], map["lastName"],
        map["phone"], map["email"], map["photo"], map["id"]);
  }

  Map<String, dynamic> toJSON() {
    return {"username": username, "password": password};
  }
}
