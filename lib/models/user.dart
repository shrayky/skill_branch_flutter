import 'package:galleryapp/string_utils.dart';

enum LoginType {email, phone}

class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email}) 
  : _firstName = firstName, 
    _lastName = lastName, 
    this.phone = phone, 
    this.email = email 
    {
      _type = (email == null || email.isEmpty) ? LoginType.phone : LoginType.email;
      print("User ${this.name} is created");
    }

  factory User({String name, String phone, String email}) {
    if (name == null || name.isEmpty) 
      throw Exception("User name is empty");
    if ((phone == null || phone.isEmpty) && (email == null || email.isEmpty)) 
      throw Exception("User phone or email is empty");

    return User._(
      firstName: _getFirstName(name), 
      lastName: _getLastName(name),
      phone: phone == null ? '' : checkPhone(phone),
      email: email == null ? '' : checkEmail(email)
      );
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone){
    String pattern = r"^(?:[+0])?[0-9]{11}";
  
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty){
      throw Exception("Enter not empty phone number!");
    }
    else if (!RegExp(pattern).hasMatch(phone)){
      throw Exception("Enter a valid phone number: strting strats with + and containing only 11 digits!");
    }

    return phone;

  }

  static String checkEmail(String email){
    if (email == null || email.isEmpty)
      throw Exception("Enter not empty email!");

    if (!email.contains('@'))
      throw Exception("Please enter a valid email!");

    if (!email.contains('.'))
      throw Exception("Please enter a valid email!");

    return email.trim();
  }

  String get login{
    if (_type == LoginType.phone)
      return phone;
    else
     return email;
  }

  String get name => "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";

  void addFriends(Iterable<User> newFriends){
    friends.addAll(newFriends);
  }

  void removeFriends(User user){
    friends.remove(user);
  }

  String get userInfo => '''
  name: $name
  email: $email
  first name: $_firstName
  last name: $_lastName
  friends: ${friends.toList()}
  ''';

  @override
  String toString() {
    return '''
            name: $name
            email: $email
            friends: ${friends.toList()}
            ''';
  }

  @override
  bool operator ==(Object obj){
    if (obj == null)
      return false;

    if (obj is User) {
      return obj._firstName == _firstName && 
             obj._lastName == _lastName && (
             obj.phone == phone ||
             obj.email == email);
    }

    return false;
  }


}