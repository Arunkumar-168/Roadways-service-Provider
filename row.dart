import 'package:flutter/material.dart';
import 'package:roadways_service_provider/Home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("RoadWays Info Services"),
          ),
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
            Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_circle_left),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    ); // Add your arrow button functionality here
                  },
                ),

                const SizedBox(width: 50),
                // const Expanded(
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       'Roadways\nInfo\nServices List',
                //       style: TextStyle(
                //         fontSize: 15,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
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
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Vehicle Number')),
                  DataColumn(label: Text('Vehicle Name')),
                  DataColumn(label: Text('Is\nGPS\nEnabled')),
                  DataColumn(label: Text('GPS\nNext\nRecharge\nDate')),
                  DataColumn(label: Text('Next FC Date')),
                  DataColumn(label: Text('Service\nActivation\nStatus')),
                  DataColumn(label: Text('Subscription')),
                  DataColumn(label: Text('End Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _roadWayInfoItems.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(Text(item.vehicleNumber)),
                      DataCell(Text(item.vehicleName)),
                      DataCell(Text(item.isGpsEnabled ? 'Yes' : 'No')),
                      DataCell(Text(item.nextFcDate)),
                      DataCell(Text(item
                          .nextFcDate)), // You can replace with the actual field
                      DataCell(Text(item
                          .nextFcDate)), // You can replace with the actual field
                      DataCell(Text(item
                          .nextFcDate)), // You can replace with the actual field
                      DataCell(Text(item
                          .nextFcDate)), // You can replace with the actual field
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
                                // _roadWayInfoItems.remove(item); // You should not remove items from the list while iterating
                              },
                              child: const Text("Remove"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoadWayInfoItem {
  final String vehicleNumber;
  final String vehicleName;
  final bool isGpsEnabled;
  final String nextFcDate;

  RoadWayInfoItem({
    required this.vehicleNumber,
    required this.vehicleName,
    required this.isGpsEnabled,
    required this.nextFcDate,
  });
}

List<RoadWayInfoItem> _roadWayInfoItems = [
  RoadWayInfoItem(
    vehicleNumber: "TN001",
    vehicleName: "Mahindra",
    isGpsEnabled: false,
    nextFcDate: "2023-11-01",
  ),
  RoadWayInfoItem(
    vehicleNumber: "TN002",
    vehicleName: "TATA ace",
    isGpsEnabled: true,
    nextFcDate: "2023-11-05",
  ),
  RoadWayInfoItem(
    vehicleNumber: "TN003",
    vehicleName: "Mahindra",
    isGpsEnabled: false,
    nextFcDate: "2023-11-01",
  ),
  RoadWayInfoItem(
    vehicleNumber: "TN004",
    vehicleName: "TATA ace",
    isGpsEnabled: true,
    nextFcDate: "2023-11-05",
  ),
  RoadWayInfoItem(
    vehicleNumber: "TN005",
    vehicleName: "Mahindra",
    isGpsEnabled: false,
    nextFcDate: "2023-11-01",
  ),
  RoadWayInfoItem(
    vehicleNumber: "TN006",
    vehicleName: "TATA ace",
    isGpsEnabled: true,
    nextFcDate: "2023-11-05",
  ),
  RoadWayInfoItem(
    vehicleNumber: "TN007",
    vehicleName: "Mahindra",
    isGpsEnabled: false,
    nextFcDate: "2023-11-01",
  ),
  RoadWayInfoItem(
    vehicleNumber: "TN008",
    vehicleName: "TATA ace",
    isGpsEnabled: true,
    nextFcDate: "2023-11-05",
  ),

  // Add more items as needed
];
