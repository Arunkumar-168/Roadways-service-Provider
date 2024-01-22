import 'package:flutter/material.dart';
import 'package:roadways_service_provider/SignupPage.dart';
import 'package:roadways_service_provider/service.dart';
import 'package:roadways_service_provider/forget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tokenFunction();
  var loginToken = await initializeSharedPrefs(); // Use 'await' here
  runApp(MyApp(loginToken: loginToken));
}

Future<String?> initializeSharedPrefs() async {
  final storage = FlutterSecureStorage();
  var loginToken = await storage.read(key: 'login_token');
  return loginToken;
}

String? accessToken;
String? password;
String? mobilenumber;
late String? loginToken;

class MyApp extends StatelessWidget {
  final String? loginToken;

  const MyApp({Key? key, this.loginToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loginToken != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: servicePage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(accessToken: loginToken),
      );
    }
  }
}

Future<void> tokenFunction() async {
  const headers = {'Content-Type': 'application/x-www-form-urlencoded'};

  var request = http.Request(
      'POST',
      Uri.parse(
          'https://api.teckiko.com/auth/realms/roadwaysrealm/protocol/openid-connect/token'));
  request.bodyFields = {
    'username': 'rdc23000001',
    'password': 'abcd1234',
    'grant_type': 'password',
    'client_id': 'roadwaysclient',
    'client_secret': 'hQuKg2etb6uWTXA1ri6lryfSSXkfksXR',
  };

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  var responseBody = await response.stream.bytesToString();

  var decodedData = json.decode(responseBody);

  if (response.statusCode == 200) {
    final storage = FlutterSecureStorage();
    await storage.write(
        key: 'access_token', value: decodedData['access_token']);
    accessToken = await storage.read(key: 'access_token');
  } else {
    print(response.reasonPhrase);
  }
}

class LoginPage extends StatefulWidget {
  final String? accessToken;

  const LoginPage({Key? key, this.accessToken}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailMobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailMobileController = TextEditingController(); // Removed this line
    _passwordController = TextEditingController();
  }

  bool _passwordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmailMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or mobile number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> _login() async {
    if (mobilenumber == null || password == null) {
      print('Mobile number or password is null');
      return; // or handle the case as per your application's logic
    }
    final storage = FlutterSecureStorage();
    String? uniqueId;

    // Check if accessToken is not null before using it in headers
    if (mobilenumber != null) {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken',
      };

      var requestUser = http.Request(
          'GET',
          Uri.parse(
              'https://api.teckiko.com/roadways/users?select=name,uniqueid,usertype,idnumber&mobile=eq.$mobilenumber'));

      requestUser.headers.addAll(headers);

      http.StreamedResponse response = await requestUser.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var decodedData = json.decode(responseBody);

        if (decodedData is List && decodedData.isNotEmpty) {
          uniqueId = decodedData[0]['uniqueid'];

          if (password != null && uniqueId != null) {
            const headers = {
              'Content-Type': 'application/x-www-form-urlencoded'
            };
            var request = http.Request(
                'POST',
                Uri.parse(
                    'https://api.teckiko.com/auth/realms/roadwaysrealm/protocol/openid-connect/token'));
            request.bodyFields = {
              'username': uniqueId,
              'password': password!,
              'grant_type': 'password',
              'client_id': 'roadwaysclient',
              'client_secret': 'hQuKg2etb6uWTXA1ri6lryfSSXkfksXR',
            };
            request.headers.addAll(headers);

            http.StreamedResponse response = await request.send();
            var responseBody = await response.stream.bytesToString();
            var decodedData = json.decode(responseBody);

            if (response.statusCode == 200) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const servicePage(),
                ),
              );

              await storage.write(
                  key: 'login_token', value: decodedData['access_token']);
              String? loginToken = await storage.read(key: 'login_token');
              // print('login Token: $loginToken');
            } else {
              print(response.reasonPhrase);
            }
          }
        } else {
          // Handle case where decodedData is empty
        }
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 136, 209, 228),
      body: GestureDetector(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 54, 216, 154),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'RoadWays Info service',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 25),
                          height: height / 1.3,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                'Login/Signup',
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: TextFormField(
                                  controller: _emailMobileController,
                                  onChanged: (value) {
                                    setState(() {
                                      mobilenumber = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email/Mobile Number',
                                    labelStyle: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.green,
                                    ),
                                    suffix: const Icon(
                                      Icons.call,
                                      color: Colors.green,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 8,
                                      ),
                                    ),
                                  ),
                                  validator: (value) =>
                                      validateEmailMobile(value),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 8,
                                      ),
                                    ),
                                    labelText: "Password",
                                    labelStyle: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.green,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      color: Colors.green,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Password(),
                                        ),
                                      );
                                    },
                                    child: const Text("Forget Password?"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  Container(
                                    width: 100,
                                    height: 50,
                                    padding: const EdgeInsets.all(1),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _login(); // Use _login instead of loginFunction
                                        }
                                      },
                                      child: const Text(
                                        " Login",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('New user?'),
                                  const SizedBox(width: 8.0),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage(),
                                          // accessToken: widget.accessToken
                                        ),
                                      );
                                    },
                                    child: const Text('Sign Up'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
