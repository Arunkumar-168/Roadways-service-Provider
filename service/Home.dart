import 'package:flutter/material.dart';
import 'package:roadways_service_provider/service/Enquiry.dart';
import 'package:roadways_service_provider/service/row.dart';
import 'package:roadways_service_provider/service/profile.dart';
import 'package:roadways_service_provider/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:roadways_service_provider/service/service.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // _initializeData();
    super.initState();
  }

  Future<void> _logout(BuildContext context) async {
    try {
      final storage = FlutterSecureStorage();
      await storage.delete(key: 'login_token');
      await Future.delayed(Duration.zero);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (error) {
      print('Error during logout: $error');
    }
  }
  // Future<String?> initializeSharedPrefs() async {
  //   final storage = FlutterSecureStorage();
  //   var loginToken = await storage.read(key: 'login_token');
  //   return loginToken;
  // }

  // void _initializeData() async {
  //   loginToken = await initializeSharedPrefs();
  //   if (loginToken != null) {
  //     await _logout(context);
  //   }
  // }

  // Future<void> _logout(BuildContext context) async {
  //   const headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           'https://api.teckiko.com/auth/realms/roadwaysrealm/protocol/openid-connect/logout'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     try {
  //       final storage = FlutterSecureStorage();
  //       await storage.delete(key: 'login_token');
  //       await Future.delayed(Duration.zero);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const LoginPage(),
  //         ),
  //       );
  //     } catch (error) {
  //       print('Error during logout: $error');
  //     }
  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  // @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 156, 235, 228),
      appBar: AppBar(
        title: const Text('RoadWays Info services'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const profilePage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 100),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text(' Service List:'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                ); // Navigate to the service list page
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Vehicles'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const servicePage(),
                  ),
                ); // Navigate to the add service page
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.person),
            //   title: const Text('Profile'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const profilePage(),
            //       ),
            //     ); // Navigate to the profile page
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Enquiry'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
                // Navigate to the enquiry page
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Logout'),
              onTap: () {
                _logout(context); // Navigate to the profile page
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              height: height / 1.3,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Service List',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Added to create space between service options
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.local_shipping,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const servicelist(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Goods&Carrier",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                              width: 10), // Adjust the spacing between images
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Container(
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.directions_bus_rounded,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const servicelist(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Tours&Travels",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.local_taxi,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const servicelist(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Cab&Taxi",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Adjust the spacing between images
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.directions_car,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyHomePage(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Auto",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.local_car_wash_sharp,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const servicelist(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Ambulance",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Adjust the spacing between images
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.local_car_wash,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const servicelist(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Car wash",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 20),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Container(
                      //       width: 120,
                      //       height: 50,
                      //       padding: const EdgeInsets.all(1),
                      //       margin: const EdgeInsets.symmetric(vertical: 1),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         gradient: const LinearGradient(
                      //           colors: [Colors.blue, Colors.green],
                      //         ),
                      //       ),
                      //       child: TextButton(
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => const servicePage(),
                      //             ),
                      //           );
                      //         },
                      //         child: const Text(
                      //           "Add Vehicles",
                      //           style: TextStyle(
                      //             fontSize: 15,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
