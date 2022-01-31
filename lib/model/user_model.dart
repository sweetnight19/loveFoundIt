class User_model {
  late int _id;
  late String _name;
  late String _email;
  late String _phone;

  User_model(item, String username, String email, String phoneNumber) {
    _id = item;
    _name = username;
    _email = email;
    _phone = phoneNumber;
  }

  get id => _id;

  set id(id) {
    _id = id;
  }

  get name => _name;

  set name(name) {
    _name = name;
  }

  get email => _email;

  set email(email) {
    _email = email;
  }

  get phone => _phone;

  set phone(phone) {
    _phone = phone;
  }
}
