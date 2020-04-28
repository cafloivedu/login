class User {
  static int CLASS_ID = 0;
  String id = "";
  String email = "";
  String password = "";

  User(String email, String password) {
    this.id = CLASS_ID.toString();
    this.email = email;
    this.password = password;
    CLASS_ID++;
  }
}
