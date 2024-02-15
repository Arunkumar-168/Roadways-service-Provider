import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String? selectedValue;
  String name = "";
  String mobilenumber = "";
  String doornumberShopnumber = "";
  String streetname = "";
  String landmark = "";
  String district = "";
  String selectState = "";
  String pincode = "";

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
                      height: 1,
                    ),
                    Text(
                      'RoadWays Info services',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height,
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
                      width: 150,
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
                              'Profile Details',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 10,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.green],
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SecondPage(
                                        name: name,
                                        mobilenumber: mobilenumber,
                                        doornumberShopnumber:
                                            doornumberShopnumber,
                                        streetname: streetname,
                                        landmark: landmark,
                                        district: district,
                                        selectState: selectState,
                                        pincode: pincode,
                                      ),
                                    ),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        name = value["name"];
                                        mobilenumber = value["mobilenumber"];
                                        doornumberShopnumber =
                                            value["doornumber/shopnumber"];
                                        streetname = value["streetname"];
                                        landmark = value["landmark"];
                                        district = value["district"];
                                        selectState = value["selectState"];
                                        pincode = value["pincode"];
                                      });
                                    }
                                  });
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Name",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(name),
                            const SizedBox(height: 8),
                            const Text("Mobile Number",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(mobilenumber),
                            const SizedBox(height: 8),
                            const Text("Door Number / Shop Number",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(doornumberShopnumber),
                            const SizedBox(height: 8),
                            const Text("Street Name",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(streetname),
                            const SizedBox(height: 8),
                            const Text("Landmark",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(landmark),
                            const SizedBox(height: 8),
                            const Text("District",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(district),
                            const SizedBox(height: 8),
                            const Text("Select State",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(selectState),
                            const SizedBox(height: 8),
                            const Text("Pincode",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(pincode),
                          ],
                        ),
                      ),
                    ),
                  ],
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
  final String name;
  final String mobilenumber;
  final String doornumberShopnumber;
  final String streetname;
  final String landmark;
  final String district;
  final String selectState;
  final String pincode;

  const SecondPage({
    Key? key,
    required this.name,
    required this.mobilenumber,
    required this.doornumberShopnumber,
    required this.streetname,
    required this.landmark,
    required this.district,
    required this.selectState,
    required this.pincode,
  }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController doornumberShopnumberController =
      TextEditingController();
  TextEditingController streetnameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController selectStateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  String? name;
  String? mobilenumber;
  String? doornumberShopnumber;
  String? streetname;
  String? landmark;
  String? district;
  String? selectState;
  String? pincode;

  String? selectedValue;
  List<Map<String, dynamic>>? states;
  List<Map<String, dynamic>>? profile;
  int? selectedState;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initializeData();
    super.initState();
    nameController.text = widget.name;
    mobilenumberController.text = widget.mobilenumber;
    doornumberShopnumberController.text = widget.doornumberShopnumber;
    streetnameController.text = widget.streetname;
    landmarkController.text = widget.landmark;
    districtController.text = widget.district;
    selectStateController.text = widget.selectState;
    pincodeController.text = widget.pincode;
  }

  List<String?>? loginToken;
  String? uniqueId;
  bool _isLoading = false;

  Future<List<String?>> initializeSharedPrefs() async {
    final storage = FlutterSecureStorage();
    var loginToken = await storage.read(key: 'login_token');
    uniqueId = await storage.read(key: 'uniqueId');

    // Return a List containing uniqueId and loginToken
    return [uniqueId, loginToken];
  }

  void _initializeData() async {
    loginToken = await initializeSharedPrefs();
    if (loginToken != null) {
      // Access elements like loginToken[0] and loginToken[1]
      await user();
      await getStates();
    }
  }

  Future<void> user() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginToken![1]}',
      };

      var request = http.Request(
        'GET',
        Uri.parse('https://api.teckiko.com/roadways/users'),
      );

      request.headers.addAll(headers);

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        List<dynamic> profileData = json.decode(response.body);

        if (profileData.isNotEmpty) {
          List<Map<String, dynamic>> profileList = profileData
              .map<Map<String, dynamic>>((profile) => {
                    'profileuid': profile['uid'],
                    'name': profile['name'],
                  })
              .toList();

          Map<String, dynamic> loggedInUserProfile = profileList.firstWhere(
            (userProfile) => userProfile['profileuid'] == uniqueId![0],
            orElse: () => {'profileuid': '', 'name': ''},
          );

          if (loggedInUserProfile['profileuid'].isNotEmpty) {
            print('Profile found: $loggedInUserProfile');
            print('UniqueId: $uniqueId');
            // You may want to navigate to the profile page here
          } else {
            print('User profile not found for uniqueId: ${uniqueId![0]}');
          }

          setState(() {
            profile = profileList;
          });
        } else {
          print('No profiles found');
        }
      } else {
        print('Failed to fetch user profiles: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      // You might want to show an error message to the user
    }
  }

  Future<void> getStates() async {
    try {
      if (loginToken != null) {
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${loginToken![1]}',
        };

        var request = http.Request(
          'GET',
          Uri.parse(
              'https://api.teckiko.com/roadways/states?country_code=eq.IN'),
        );

        request.headers.addAll(headers);

        http.Response response =
            await http.get(request.url, headers: request.headers);

        if (response.statusCode == 200) {
          try {
            List<dynamic> statesResult = json.decode(response.body);
            if (statesResult.isNotEmpty) {
              List<Map<String, dynamic>> statesList = statesResult
                  .map<Map<String, dynamic>>((state) => {
                        'stateid': state['id'],
                        'name': state['name'],
                      })
                  .toList();

              setState(() {
                states = statesList;
              });
            }
          } catch (e) {
            print('Error decoding JSON: $e');
          }
        } else {
          print('Failed to get countries: ${response.reasonPhrase}');
        }
      } else {
        print('Access Token is null or not found in the response.');
      }
    } catch (e) {
      print('Error getting countries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    if (!_isLoading) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 156, 235, 228),
        body: SizedBox(
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
                      height: 1,
                    ),
                    Text(
                      'RoadWays Info services',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                        width: 180,
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
                                'Profile Details',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Name',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Enter the name';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    mobilenumber = value;
                                  });
                                },
                                controller: mobilenumberController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Mobile Number',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Enter the Vehicle Mobile Number';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Address Details',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    doornumberShopnumber = value;
                                  });
                                },
                                controller: doornumberShopnumberController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Door Number/Shop Number',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Enter the Vehicle Mobile Number';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    streetname = value;
                                  });
                                },
                                controller: streetnameController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Street Name',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Enter the Vehicle Mobile Number';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    landmark = value;
                                  });
                                },
                                controller: landmarkController,
                                decoration: InputDecoration(
                                  labelText: 'Enter LandMark',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Enter the Vehicle Mobile Number';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    district = value;
                                  });
                                },
                                controller: districtController,
                                decoration: InputDecoration(
                                  labelText: 'Enter District',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Enter the Vehicle Mobile Number';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: DropdownButtonFormField<int>(
                                  value: selectState ?? states![0]['select'],
                                  items: states!
                                      .map((state) => DropdownMenuItem<int>(
                                            value: state['stateid'],
                                            child: Text(state['name']),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedState = value;
                                    });
                                  },
                                  // validator: (value) {
                                  //   if (value == null) {
                                  //     return 'Select is required';
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    labelText: 'Select State',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1, // Adjust the width as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    pincode = value;
                                  });
                                },
                                controller: pincodeController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Pincode',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Enter the Vehicle Mobile Number';
                                //   }
                                //   return null;
                                // },
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 20.0),
                                  Container(
                                    width: 100,
                                    padding: const EdgeInsets.all(5),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "cancel",
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
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Colors.blue, Colors.green],
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop({
                                          "name": nameController.text,
                                          "mobilenumber":
                                              mobilenumberController.text,
                                          "doornumber/shopnumber":
                                              doornumberShopnumberController
                                                  .text,
                                          "streetname":
                                              streetnameController.text,
                                          "landmark": landmarkController.text,
                                          "district": districtController.text,
                                          "selectstate":
                                              selectStateController.text,
                                          "pincode": pincodeController.text,
                                        });
                                      },
                                      child: const Text(
                                        "save",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
      );
    } else {
      // Display a loading indicator or a different widget while data is loading
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // or any other widget
        ),
      );
    }
  }
}
