import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:9098/api/auth'; // Replace with your backend URL

  // Method to register a new user
  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String email,
    required String password,
    String? imagePath,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/register'), // Assuming '/register' is your registration endpoint
    );

    request.fields['username'] = username;
    
    request.fields['email'] = email;
    request.fields['password'] = password;

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imagePath,
      ));
    }

    try {
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Debugging output
      print('Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        final errorResponse = json.decode(responseBody);
        final errorMessage = errorResponse['message'] ?? 'Failed to register user';
        throw Exception('Failed to register user: ${response.statusCode} $errorMessage');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  // Method to log in an existing user
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'), // Assuming '/login' is your login endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    // Debugging output
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      final errorMessage = errorResponse['message'] ?? 'Failed to login user';
      throw Exception('Failed to login user: ${response.statusCode} $errorMessage');
    }
  }

  // Method to verify a token
  Future<bool> verifyToken(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-token'), // Assuming '/verify-token' is your token verification endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': token,
      }),
    );

    // Debugging output
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['valid'] == true; // Assuming the response contains a field 'valid'
    } else {
      throw Exception('Failed to verify token: ${response.statusCode} ${response.body}');
    }
  }

  // Method to send a password reset email
Future<Map<String, dynamic>> sendPasswordResetEmail(String email) async {
  final response = await http.post(
    Uri.parse('$baseUrl/forget-password'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
    }),
  );

  // Debugging output
  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 201) {
    try {
      return json.decode(response.body);
    } catch (e) {
      throw Exception('Failed to parse response: $e');
    }
  } else {
    // Only throw an exception for HTTP errors, not for successful responses
    throw Exception('Failed to send password reset email: ${response.body}');
  }
}
Future<Map<String, dynamic>> getProfile({required String token}) async {
  final response = await http.get(
    Uri.parse('$baseUrl/profile'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  // Debugging output
  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    final errorResponse = json.decode(response.body);
    final errorMessage = errorResponse['message'] ?? 'Failed to get profile';
    throw Exception('Failed to get profile: ${response.statusCode} $errorMessage');
  }
}

}