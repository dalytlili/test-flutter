import 'package:flutter/material.dart';
import 'package:front_flutter/screen/constants.dart';
import 'package:front_flutter/screen/nav_bar-screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_flutter/widgets/custom_scaffold.dart';
import 'package:front_flutter/services/api_service.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formSignInkey = GlobalKey<FormState>();
  bool rememberPassword = false;
  bool obscurePassword = true; // For password visibility toggle
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Improved email validation regex
  String? emailValidator(String? value) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter Email';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        
        children: [
          const Expanded(
            
            flex: 1,
            child: SizedBox(height: 10),
          ),
          Expanded(
            flex: 7,
            child: Container(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),

              child: Form(
                key: _formSignInkey,
                child: Column(
                  
                  children: [
                    // Add logo
                    const SizedBox(height: 20),
                    Image.asset(
                      
                      'assets/images/logo11.png', // Replace with the correct path to your image
                      height: 100, // Adjust the height as needed
                    ),
                    const SizedBox(height: 20),
                   const Align(
  alignment: Alignment.centerLeft, // Aligner à gauche
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Loging',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      SizedBox(height: 5),
      Text(
        'Enter your email and password .',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
      ),
    ],
  ),
),



                    const SizedBox(height: 20),
                  TextFormField(
  controller: _emailController,
  validator: emailValidator,
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter Email',
    hintStyle: const TextStyle(color: Colors.black26),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 2, 2, 2), width: 2), 
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12), 
    ),
  ),
),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: obscurePassword,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                     decoration: InputDecoration(
  labelText: 'Password',
  hintText: 'Enter Password',
  hintStyle: const TextStyle(color: Colors.black26),
  border: const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black12),
  ),
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2),
  ),
  enabledBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black12), 
  ),
  suffixIcon: IconButton(
    icon: Icon(
      obscurePassword ? Icons.visibility : Icons.visibility_off,
    ),
    onPressed: () {
      setState(() {
        obscurePassword = !obscurePassword;
      });
    },
  ),
),

                    ),
                    const SizedBox(height: 20),
              Row(
  mainAxisAlignment: MainAxisAlignment.end, // يجعل العناصر داخل الصف محاذية لليمين
  children: [
    const Text(
      'Forget password?',
      style: TextStyle(color: Colors.black54),
    ),
  ],
),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                        height: 60,
                      child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
backgroundColor: kprimaryColor,      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), 
      ),),
                        onPressed: () async {
                          if (_formSignInkey.currentState!.validate()) {
                            try {
                              final response = await _apiService.loginUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              await _secureStorage.write(
                                  key: 'userEmail', value: _emailController.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login Successful!')),
                              );

                              await _secureStorage.write(key: 'isLoggedIn', value: 'true');
                              await _secureStorage.write(
                                  key: 'accessToken', value: response['accessToken']);
                              await _secureStorage.write(
                                  key: 'refreshToken', value: response['refreshToken']);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNavBar()),
                                (Route<dynamic> route) => false,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login Failed: ${e.toString()}')),
                              );
                            }
                          }
                        },
                        child: const Text('Log In',
 style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Don\'t have an account ? ',
                          style: TextStyle(color: Colors.black45),
                        ),
                        Text(
                          'Signup',
style: TextStyle(color: kprimaryColor),
                        ),
                      ],
                      
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
