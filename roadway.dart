import 'package:flutter/material.dart';
import 'package:roadways_service_provider/Home.dart';
import 'package:roadways_service_provider/addservices.dart';

class RoadWaysInfoApp extends StatefulWidget {
  const RoadWaysInfoApp({Key? key}) : super(key: key);

  @override
  _RoadWaysInfoAppState createState() => _RoadWaysInfoAppState();
}

class _RoadWaysInfoAppState extends State<RoadWaysInfoApp> {
  bool isChecked1 = false;

  void onCheckboxChanged1(bool? value) {
    setState(() {
      isChecked1 = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RoadWays Info Services"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    );
                  },
                ),
                const SizedBox(width: 10),
                Container(
                  width: 150,
                  height: 50,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.symmetric(vertical: 1),
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
                          builder: (context) => const DatePickerExample(),
                        ),
                      );
                    },
                    child: const Text(
                      "Add Vehicles",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Saved Service List',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
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
                  DataColumn(label: Text('Select in\nRoadWays Info\nservice')),
                  DataColumn(label: Text('Vehicle Number')),
                  DataColumn(label: Text('Vehicle Name')),
                  DataColumn(label: Text('Is GPS Enabled')),
                  DataColumn(label: Text('Next_FC_Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Checkbox(
                          value: isChecked1,
                          onChanged: onCheckboxChanged1,
                        ),
                      ),
                      const DataCell(Text('TN001')),
                      const DataCell(Text('Mahindra')),
                      const DataCell(Text('Yes')),
                      const DataCell(Text('2023-11-10')),
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
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Checkbox(
                          value: isChecked1,
                          onChanged: onCheckboxChanged1,
                        ),
                      ),
                      const DataCell(Text('TN002')),
                      const DataCell(Text('Mahindra')),
                      const DataCell(Text('Yes')),
                      const DataCell(Text('2023-11-10')),
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
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Checkbox(
                          value: isChecked1,
                          onChanged: onCheckboxChanged1,
                        ),
                      ),
                      const DataCell(Text('TN003')),
                      const DataCell(Text('Mahindra')),
                      const DataCell(Text('Yes')),
                      const DataCell(Text('2023-11-10')),
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
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Checkbox(
                          value: isChecked1,
                          onChanged: onCheckboxChanged1,
                        ),
                      ),
                      const DataCell(Text('TN004')),
                      const DataCell(Text('Mahindra')),
                      const DataCell(Text('Yes')),
                      const DataCell(Text('2023-11-10')),
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
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Checkbox(
                          value: isChecked1,
                          onChanged: onCheckboxChanged1,
                        ),
                      ),
                      const DataCell(Text('TN005')),
                      const DataCell(Text('Mahindra')),
                      const DataCell(Text('Yes')),
                      const DataCell(Text('2023-11-10')),
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
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Checkbox(
                          value: isChecked1,
                          onChanged: onCheckboxChanged1,
                        ),
                      ),
                      const DataCell(Text('TN006')),
                      const DataCell(Text('Mahindra')),
                      const DataCell(Text('Yes')),
                      const DataCell(Text('2023-11-10')),
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
                  ),
                  // Add more rows as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
