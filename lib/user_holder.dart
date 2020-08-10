import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    print(user.toString());

    if (!users.containsKey(user.login))
      users[user.login] = user;
    else
      throw Exception('User with this name already exist!');
  }

  User registerUserByPhone(String name, String phone) {
    if (users.containsKey(phone)) {
      throw Exception('A user with this phone already exists');
    }

    User user = User(name: name, phone: phone);
    users[user.login] = user;

    return user;
  }

  User registerUserByEmail(String name, String email) {
    if (users.containsKey(email)) {
      throw Exception('A user with this email already exists');
    }

    User user = User(name: name, email: email);
    users[user.login] = user;

    return user;
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  void setFriends(String userLogin, Iterable<User> newFriends) {
    if (!users.containsKey(userLogin))
      throw Exception('There is no such user with login $userLogin!');

    users[userLogin].addFriends(newFriends);
  }

  User findUserInFriends(String userLogin, User usr) {
    if (!users.containsKey(userLogin))
      throw Exception('There is no such user with login $userLogin!');

    List<User> friendList = users[userLogin].friends;

    if (!friendList.contains(usr))
      throw Exception('${usr.login} is not a friend of the login $userLogin');

    return friendList.firstWhere((element) => element == usr);
  }

  List<User> importUsers(List<String> input) {
    List<User> data = <User>[];

    input.forEach((element) {

      var row = element.replaceAll('\n', '').trim().split(';');

      if (row.length != 0) {
        User newUser = User(name: row[0], phone: row[2], email: row[1]);
        data.add(newUser);
      }
    });
    return data;
  }
}
