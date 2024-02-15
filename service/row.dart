import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class servicelist extends StatefulWidget {
  const servicelist({Key? key}) : super(key: key);

  @override
  _servicelistState createState() => _servicelistState();
}

class _servicelistState extends State<servicelist> {
  String? loginToken;
  List<Map<String, dynamic>>? vehiclelist;

  @override
  void initState() {
    initializeAsync();
    super.initState();
  }

  Future<String?> initializeSharedPrefs() async {
    final storage = FlutterSecureStorage();
    var loginToken = await storage.read(key: 'login_token');
    return loginToken;
  }

  void initializeAsync() async {
    loginToken = await initializeSharedPrefs();
    if (loginToken != null) {
      await list();
    }
  }

  Future<void> list() async {
    var headers = {
      'Authorization': 'Bearer $loginToken',
    };
    var request = http.Request(
      'GET',
      Uri.parse('https://api.teckiko.com/roadways/vehicles'),
    );

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> vehiclelistResult = json.decode(responseBody);
        if (vehiclelistResult.isNotEmpty) {
          List<Map<String, dynamic>> vehicleList = vehiclelistResult
              .map<Map<String, dynamic>>((vehicleList) => {
                    'vtypeid': vehicleList['vtypeid'] ?? '',
                    'vregno': vehicleList['vregno'] ?? '',
                    'vmodel': vehicleList['vmodel'] ?? '',
                    'vgps': vehicleList['vgps'] ?? '',
                    'vinsdate': vehicleList['vinsdatel'] ?? '',
                    'vfcdate': vehicleList['vfcdate'] ?? '',
                    'vvalidity': vehicleList['vvalidity'] ?? '',
                    'visactive': vehicleList['visactive'] ?? '',
                  })
              .toList();
          setState(() {
            vehiclelist = vehicleList;
          });
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error during HTTP request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Service List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Vehicle\nRegistration No')),
                  DataColumn(label: Text('Vehicle Model')),
                  DataColumn(label: Text('Is GPS Enabled')),
                  DataColumn(label: Text('Vehicle\nInstallation\nDate')),
                  DataColumn(label: Text('Vehicle\nFC Date')),
                  DataColumn(label: Text('Vehicle\nValidity')),
                  DataColumn(label: Text('Is Vehicle Active')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: vehiclelist?.map((item) {
                      return DataRow(
                        cells: [
                          DataCell(Text(item['vregno'].toString())),
                          DataCell(Text(item['vmodel'].toString())),
                          DataCell(_getGpsWidget(item['vgps'])),
                          DataCell(Text(item['vinsdate'].toString())),
                          DataCell(Text(item['vfcdate'].toString())),
                          DataCell(Text(item['vvalidity'].toString())),
                          DataCell(_getIsActiveWidget(item['visactive'])),
                          DataCell(
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Implement your update action here
                                  },
                                  child: const Text("Update"),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    // Implement your remove action here
                                    // You should not remove items from the list while iterating
                                  },
                                  child: const Text("Remove"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    })?.toList() ??
                    [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGpsWidget(dynamic gpsValue) {
    String text;
    if (gpsValue is bool) {
      text = gpsValue ? 'Yes' : 'No';
    } else if (gpsValue is int) {
      text = (gpsValue == 1) ? 'Yes' : 'No';
    } else {
      text = 'yes';
    }
    return Text(text);
  }

  Widget _getIsActiveWidget(dynamic isActiveValue) {
    String text;
    if (isActiveValue is bool) {
      text = isActiveValue ? 'Yes' : 'No';
    } else if (isActiveValue is int) {
      text = (isActiveValue == 1) ? 'Yes' : 'No';
    } else {
      text = 'Unknown';
    }
    return Text(text);
  }
}
