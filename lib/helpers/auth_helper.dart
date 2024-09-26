import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:sepatuv5/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  AuthHelper._privateConstructor();
  static final AuthHelper _instance = AuthHelper._privateConstructor();
  static AuthHelper get instance => _instance;

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static final account = Account(client);

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('userId');
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isLoggedIn', value);
  }

  loginEmailPassword(String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    try {
      final models.Session response = await account.createEmailSession(
        email: email,
        password: password,
      );
      prefs.setString('userId', response.userId);
      prefs.setString('email', email);
      prefs.setString('password', password);
      setLoggedIn(true);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  signUpEmailPassword(String email, String password, {String? username}) async {
    final SharedPreferences prefs = await _prefs;
    try {
      final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: username,
      );
      final models.Session response = await account.createEmailSession(
        email: email,
        password: password,
      );
      prefs.setString('userId', response.userId);
      prefs.setString('email', email);
      prefs.setString('password', password);
      setLoggedIn(true);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('userId');
    prefs.remove('email');
    prefs.remove('password');
    setLoggedIn(false);
    account.deleteSessions();
  }

  Future<String?> getUsernameById(String userId) async {
    // Implement logic to fetch the username based on the user ID
    // This might involve making a request to your backend or querying a database
    // Replace 'getUsernameFromBackend' with your actual method to fetch the username
    return await getUsernameFromBackend(userId);
  }

  Future<String?> getUsernameFromBackend(String userId) async {
    // Implement your logic to fetch the username from your backend
    // This could be a database query or an API call
    // Replace this with the actual logic to fetch the username
    return ''; // Replace with your actual username retrieval logic
  }
}
