class User {
  String username;
  String password;

  User(this.username, this.password);

  Map<String, dynamic> toJSON() {
    return {"username": username, "password": password};
  }
}
