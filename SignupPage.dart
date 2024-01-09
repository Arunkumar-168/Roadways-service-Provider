import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:roadways_service_provider/main.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _fullnameController = TextEditingController();

  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _emailoptionalController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _idnumberController = TextEditingController();

  String? fullname;
  String? mobilenumber;
  String? emailoptional;
  String? password;
  String? confirmpassword;
  String? idnumber;
  String? selectedValue;

  String? _filePath;
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  // String? selectedValue;

  bool _isValidpassword(String password) {
    // Check if the password contains only the allowed characters
    // RegExp allowedCharacters = RegExp(r'^[@$787]+$');
    RegExp allowedCharacters = RegExp(r'^[@$787a-zA-Z]+$');

    return allowedCharacters.hasMatch(password);
  }

  bool _isValidUsername(String username) {
    // Check if the username contains only the allowed characters
    RegExp allowedCharacters = RegExp(r'^[@$787a-zA-Z]+$');
    return allowedCharacters.hasMatch(username);
  }

  bool _ispasswordVisible = false;
  bool _isconfirmpasswordVisible = false;
  String? idproofNumber;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF88D1E4),
      body: GestureDetector(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFF36D89A),
                ),
                child: const Center(
                  child: Text(
                    'RoadWays Info services',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 25,
                        ),
                        height: height / 1.3,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Welcome to Roadways Info Services',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Profile Details',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    fullname = value;
                                  });
                                },
                                controller: _fullnameController,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  prefixIcon: const Icon(
                                    Icons.person,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Fullname';
                                  } else if (!_isValidUsername(value)) {
                                    return 'Invalid username';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    mobilenumber = value;
                                  });
                                },
                                controller: _mobilenumberController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                //maxLength: 10,
                                decoration: InputDecoration(
                                  // Fix: Use curly braces here
                                  labelText: 'Mobile Number',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  prefixIcon: const Icon(
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your mobile number';
                                  } else if (value.length != 10) {
                                    return 'Mobile number must be 10 digits';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    emailoptional = value;
                                  });
                                },
                                controller: _emailoptionalController,
                                decoration: InputDecoration(
                                  // Fix: Use curly braces here
                                  labelText: 'E-mail Optional',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.mail,
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your E-mail ID';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                controller: _passwordController,
                                obscureText: !_ispasswordVisible,
                                decoration: InputDecoration(
                                  // Fix: Use curly braces here
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.green,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _ispasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _ispasswordVisible =
                                            !_ispasswordVisible;
                                      });
                                    },
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value.length != 10) {
                                    return 'Password must be 10 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    confirmpassword = value;
                                  });
                                },
                                controller: _confirmpasswordController,
                                obscureText: !_isconfirmpasswordVisible,
                                decoration: InputDecoration(
                                  // Fix: Use curly braces here
                                  labelText: 'Confirm Password',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.green,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isconfirmpasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isconfirmpasswordVisible =
                                            !_isconfirmpasswordVisible;
                                      });
                                    },
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please confirm your password';
                                  } else if (value !=
                                      _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextField(
                                    decoration: const InputDecoration(
                                        labelText: 'ID Proof Number'),
                                    onChanged: (value) {
                                      setState(() {
                                        idnumber = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFF2B2A2A),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: _pickFile,
                                      child: const Text(
                                        'Choose File',
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: _pickFile,
                                        child: Text(
                                          _filePath ?? 'No file selected',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    height: 50,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    width: 100,
                                    height: 50,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SecondPage(
                                                fullname:
                                                    _fullnameController.text,
                                                mobilenumber:
                                                    _mobilenumberController
                                                        .text,
                                                emailoptional:
                                                    _emailoptionalController
                                                        .text,
                                                password:
                                                    _passwordController.text,
                                                confirmpassword:
                                                    _confirmpasswordController
                                                        .text,
                                                idnumber:
                                                    _idnumberController.text,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Next',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account?'),
                                  const SizedBox(width: 8.0),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text('Login'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
    required this.fullname,
    required this.mobilenumber,
    required this.emailoptional,
    required this.password,
    required this.confirmpassword,
    required this.idnumber,
  }) : super(key: key);

  final String fullname;
  final String mobilenumber;
  final String emailoptional;
  final String password;
  final String confirmpassword;
  final String idnumber;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _doorNumberController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  String? doorNumber;
  String? streetName;
  String? landmark;
  String? _selectedCity;
  String? _selectedState;
  String? _selectedCountry;

  bool isAccepted = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String>? countriesData;
  List<String>? statesData;
  List<String>? citiesData;
  String? countryCode;
//to print any value
  @override
  void initState() {
    super.initState();
    // Call your globally needed async functions here
    _initializeData();
  }

  void _initializeData() async {
    await getCountries();
    await getCities();
    await getStates();

    // Now you can access _selectedCountry and print its value
    print(_selectedCountry);
    print(_selectedState);
    print(_selectedCity);
  }

  Future<void> getCountries() async {
    try {
      // print(accessToken);
      if (accessToken != null) {
        String? accessTokenString = accessToken;

        if (accessTokenString != null) {
          var headers = {
            'Authorization': 'Bearer $accessTokenString',
          };

          var request = http.Request(
            'GET',
            Uri.parse('https://api.teckiko.com/roadways/countries'),
          );

          request.headers.addAll(headers);

          http.Response response =
              await http.get(request.url, headers: request.headers);

          if (response.statusCode == 200) {
            try {
              List<dynamic> countriesResult = json.decode(response.body);

              List<String> countryNames = countriesResult
                  .map((country) =>
                      country['name']?.toString() ?? "Default Country")
                  .toList();

              // print(countryNames);

              setState(() {
                countriesData = countryNames;
              });
            } catch (e) {
              print('Error decoding JSON: $e');
            }
          } else {
            print('Failed to get countries: ${response.reasonPhrase}');
          }
        } else {
          print('Access Token is null or not found in the response.');
        }
      } else {
        print('Access Token is null or not found.');
      }
    } catch (e) {
      print('Error getting countries: $e');
    }
  }

  Future<void> getCities() async {
    try {
      // print(accessToken);
      if (accessToken != null) {
        String? accessTokenString = accessToken;

        if (accessTokenString != null) {
          var headers = {
            'Authorization': 'Bearer $accessTokenString',
          };

          var request = http.Request(
            'GET',
            Uri.parse(
                'https://api.teckiko.com/roadways/cities?state_code=eq.TN'),
          );

          request.headers.addAll(headers);

          http.Response response =
              await http.get(request.url, headers: request.headers);

          if (response.statusCode == 200) {
            try {
              List<dynamic> citiesResult = json.decode(response.body);

              List<String> cityNames = citiesResult
                  .map((city) => city['name']?.toString() ?? "Default Country")
                  .toList();

              // print(cityNames);

              setState(() {
                citiesData = cityNames;
              });
            } catch (e) {
              print('Error decoding JSON: $e');
            }
          } else {
            print('Failed to get countries: ${response.reasonPhrase}');
          }
        } else {
          print('Access Token is null or not found in the response.');
        }
      } else {
        print('Access Token is null or not found.');
      }
    } catch (e) {
      print('Error getting countries: $e');
    }
  }

  Future<void> getStates() async {
    try {
      // print(accessToken);
      print(countryCode);
      if (accessToken != null) {
        String? accessTokenString = accessToken;

        if (accessTokenString != null) {
          var headers = {
            'Authorization': 'Bearer $accessTokenString',
          };

          var request = http.Request(
            'GET',
            Uri.parse(
                'https://api.teckiko.com/roadways/states?country_code=eq.$countryCode'),
          );

          request.headers.addAll(headers);

          http.Response response =
              await http.get(request.url, headers: request.headers);

          if (response.statusCode == 200) {
            try {
              List<dynamic> statesResult = json.decode(response.body);

              List<String> stateNames = statesResult
                  .map(
                      (state) => state['name']?.toString() ?? "Default Country")
                  .toList();

              // print(stateNames);

              setState(() {
                statesData = stateNames;
              });
            } catch (e) {
              print('Error decoding JSON: $e');
            }
          } else {
            print('Failed to get countries: ${response.reasonPhrase}');
          }
        } else {
          print('Access Token is null or not found in the response.');
        }
      } else {
        print('Access Token is null or not found.');
      }
    } catch (e) {
      print('Error getting countries: $e');
    }
  }

  void yourMethod() {
    countriesData?.firstWhere(
      (item) => item == _selectedCountry,
      orElse: () => 'DefaultCountry',
    );

    // Rest of your code...
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      print('name: ${widget.fullname}');
      print('mobile: ${widget.mobilenumber}');
      print('email: ${widget.emailoptional}');
      print('password: ${widget.password}');
      print('Confirm Password: ${widget.confirmpassword}');
      print('idnumber: ${widget.idnumber}');

      String concatenatedAddress =
          '${_doorNumberController.text}, ${_streetNameController.text}, ${_landmarkController.text}';

      print('addr: $concatenatedAddress');
      print('country: $_selectedCountry');
      print('city: $_selectedCity');
      print('state: $_selectedState');

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Basic cHJhdmVlbjprdW1hckAxMjM='
      };

      var request = http.Request(
          'POST', Uri.parse('https://api.teckiko.com/gord/insert'));
      request.body = json.encode({
        "name": widget.fullname,
        "mobile": widget.mobilenumber,
        "email": widget.emailoptional,
        "password": widget.password,
        "addr": concatenatedAddress,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF88D1E4),
      body: GestureDetector(
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFF36D89A),
                ),
                child: const Center(
                  child: Text(
                    'Road Ways Info Services',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 25,
                        ),
                        height: height / 1.3,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Welcome to Roadways Info Services',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Address Details',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    doorNumber = value;
                                  });
                                },
                                controller: _doorNumberController,
                                decoration: InputDecoration(
                                  labelText: 'Door Number',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 8,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Door Number is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    streetName = value;
                                  });
                                },
                                controller: _streetNameController,
                                decoration: InputDecoration(
                                  labelText: 'Street Name',
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 8,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Street Name is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    landmark = value;
                                  });
                                },
                                controller: _landmarkController,
                                decoration: InputDecoration(
                                  labelText: 'Landmark',
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 8,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Landmark is required';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 10),
                              Container(
                                  width: 150,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 43, 42, 42),
                                      width: 1,
                                    ),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    // value: _selectedCountry,
                                    items:
                                        (countriesData ?? ["Default Country"])
                                            .map((country) => DropdownMenuItem(
                                                  value: country,
                                                  child: Text(country),
                                                ))
                                            .toList(),

                                    onChanged: (value) {
                                      // print(value);
                                      setState(() {
                                        _selectedCountry = value;
                                        countryCode = countriesData?.firstWhere(
                                              (item) => item == value,
                                              orElse: () => 'DefaultCountry',
                                            ) ??
                                            'DefaultCountry';
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Select Country',
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Country is required';
                                      }
                                      return null;
                                    },
                                  )),
                              const SizedBox(height: 10), // Added a space
                              Container(
                                width: 250,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 43, 42, 42),
                                    width: 1,
                                  ),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedCountry,
                                  items: (countriesData ?? ["Default Country"])
                                      .map((country) => DropdownMenuItem(
                                            value: country,
                                            child: Text(country),
                                          ))
                                      .toList(),
                                  onChanged: (value) async {
                                    setState(() {
                                      _selectedCountry = value;
                                      _selectedState = null;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Select state',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'State is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 150,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 43, 42, 42),
                                    width: 1,
                                  ),
                                ),
                                child: DropdownButtonFormField<String>(
                                  // value: _selectedCity,
                                  items: (citiesData ?? ["Default City"])
                                      .map((city) => DropdownMenuItem(
                                            value: city,
                                            child: Text(city),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _selectedCity = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select is required';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Select City',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  Checkbox(
                                    value: isAccepted,
                                    onChanged: (value) {
                                      setState(() {
                                        isAccepted = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text('Accept the terms & conditions'),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    width: 100,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        _submitForm();
                                      },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account?'),
                                  const SizedBox(width: 8.0),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: const Text('Login'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
