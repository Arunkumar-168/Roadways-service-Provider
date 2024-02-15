import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:roadways_service_provider/sub.dart';
import 'package:roadways_service_provider/service/service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';

class vehicle extends StatefulWidget {
  const vehicle({Key? key}) : super(key: key);

  @override
  _vehicleState createState() => _vehicleState();
}

class _vehicleState extends State<vehicle> {
  TextEditingController VehiclemobilenumberController = TextEditingController();
  TextEditingController vehicleregisternumberController =
      TextEditingController();
  TextEditingController VehicleseatcountController = TextEditingController();
  TextEditingController VehicletotaltyresController = TextEditingController();
  TextEditingController selectedVehicleTypeIdController =
      TextEditingController();
  TextEditingController selectedBrandNameIdController = TextEditingController();
  TextEditingController selectedVehicleModelController =
      TextEditingController();
  TextEditingController selectedUserTypeController = TextEditingController();
  TextEditingController selectedFuelTypeController = TextEditingController();
  TextEditingController selectedRegisterStateController =
      TextEditingController();
  TextEditingController selectedInsuranceTypeController =
      TextEditingController();
  TextEditingController selectedGPSEnabledController = TextEditingController();
  TextEditingController dateInput1 = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();
  String? Vehiclemobilenumber;
  String? vehicleregisternumber;
  String? Vehicleseatcount;
  int? selectedVehicleTypeId;
  int? selectedBrandNameId;
  int? selectedVehicleModel;
  String? selectedUserType;
  String? selectedFuelType;
  String? Vehicletotaltyres;
  int? selectedRegisterState;
  String? selectedInsuranceType;
  String? selectedGPSEnabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? loginToken;
  List<Map<String, dynamic>>? vehicleType;
  List<Map<String, dynamic>>? brandname;
  List<Map<String, dynamic>>? vehiclemodel;
  List<Map<String, dynamic>>? states;

  @override
  void initState() {
    dateInput1.text = ""; // Set the initial value of text field 1
    dateInput2.text = "";
    _initializeData();
    super.initState();
  }

  Future<String?> initializeSharedPrefs() async {
    final storage = FlutterSecureStorage();
    var loginToken = await storage.read(key: 'login_token');
    return loginToken;
  }

  void _initializeData() async {
    loginToken = await initializeSharedPrefs();
    if (loginToken != null) {
      await getStates();
      await getbrand();
      await getvehiclemodel();
      await getVehicleType();
    }
  }

  @override
  void didUpdateWidget(covariant vehicle oldWidget) {
    super.didUpdateWidget(oldWidget);
    getvehiclemodel();
    // This code will be executed when the widget is updated.
    // You can perform side effects based on the updated widget here.
  }

  // Add this method to initialize loginToken

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  // String? filePath;

  // void _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.any, // You can specify the file types you want to allow.
  //   );

  //   if (result != null) {
  //     setState(() {
  //       filePath = result.files.single.path;
  //       print(filePath);
  //     });
  //   }
  // }

  Future<void> getVehicleType() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };

    var request = http.Request(
      'GET',
      Uri.parse('https://api.teckiko.com/roadways/vehicletypes'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      try {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> vehicleTypesResult = json.decode(responseBody);
        if (vehicleTypesResult.isNotEmpty) {
          List<Map<String, dynamic>> vehicleTypeList = vehicleTypesResult
              .map<Map<String, dynamic>>((vehicleType) => {
                    'vtypeid': vehicleType['vtypeid'],
                    'vtype': vehicleType['vtype'],
                  })
              .toList();
          setState(() {
            vehicleType = vehicleTypeList;
          });
        }
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getvehiclemodel() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };

    var request = http.Request(
      'GET',
      Uri.parse(
          'https://api.teckiko.com/roadways/vmodels?vtypeid=eq.$selectedVehicleTypeId&vbrandid=eq.$selectedBrandNameId'),
    );

    request.headers.addAll(headers);

    if (selectedVehicleTypeId != null && selectedBrandNameId != null) {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        try {
          String responseBody = await response.stream.bytesToString();
          List<dynamic> VehicleModelResult = json.decode(responseBody);
          if (VehicleModelResult.isNotEmpty) {
            List<Map<String, dynamic>> VehicleModelList =
                VehicleModelResult.map<Map<String, dynamic>>((vehiclemodel) => {
                      'vmid': vehiclemodel['vmid'],
                      'vmname': vehiclemodel['vmname'],
                    }).toList();

            setState(() {
              vehiclemodel = VehicleModelList;
              print(vehiclemodel);
            });
          }
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  Future<void> getbrand() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };

    var request = http.Request(
      'GET',
      Uri.parse('https://api.teckiko.com/roadways/brands'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      try {
        String responseBody = await response.stream.bytesToString();
        List<dynamic> BrandNameResult = json.decode(responseBody);
        if (BrandNameResult.isNotEmpty) {
          List<Map<String, dynamic>> brandnamelList =
              BrandNameResult.map<Map<String, dynamic>>((brand) => {
                    'brandid': brand['brandid'],
                    'brandname': brand['brandname'],
                  }).toList();

          setState(() {
            brandname = brandnamelList;
          });
        }
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getStates() async {
    try {
      if (loginToken != null) {
        var headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $loginToken',
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

  String? _filePath;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // You can specify the file types you want to allow.
    );

    if (result != null) {
      setState(() {
        if (result.files.single.bytes != null) {
          // If the file content is available as bytes, you can do something with it
          Uint8List fileBytes = result.files.single.bytes!;
          // Do something with fileBytes, for example, save it to a file or process it
          // ...
        }

        // You can also store the file path if needed
        _filePath = result.files.single.path ?? 'No path available';
        print(_filePath);
      });
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          // content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void addvehiclefunction() async {
    String message = '''

  Vehicle Type: $selectedUserType
  Seat Count: $Vehicleseatcount
  Fuel Type: $selectedFuelType

  Total Tyres: $Vehicletotaltyres
  Register Number: $vehicleregisternumber
  Register State: $selectedRegisterState

  GPS Enabled: $selectedGPSEnabled
  Insurance Type: $selectedInsuranceType
  Date Input 1: ${dateInput1.text}

  Date Input 2: ${dateInput2.text}
  Mobile Number: $Vehiclemobilenumber
''';

    _showAlertDialog('Details Submitted', message);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $loginToken',
    };
    var formdata = {
      "vtype": selectedVehicleTypeId,
      "vmodel": selectedVehicleModel,
      "vbrand": selectedBrandNameId,
      "vusetype": selectedUserType,
      "vseats": Vehicleseatcount,
      "vtons": 0,
      "vfuel": selectedFuelType,
      "vtyres": Vehicletotaltyres,
      "vregno": vehicleregisternumber,
      "vregstate": selectedRegisterState,
      "vgps": selectedGPSEnabled,
      "vinstype": selectedInsuranceType,
      "vinsdate": dateInput1.text,
      "vfcdate": dateInput2.text,
      "vvalidity": "2024-11-20",
      "vrcfile": null,
      "vinsfile": null,
      "votherfile": null,
      "vmobile": Vehiclemobilenumber,
      "visactive": 1,
      "createdat": "2023-11-11 12:00:00",
      "createdby": "rdc23000001",
      "updatedat": "2023-11-11 12:00:00",
      "updatedby": "rdc23000001",
      "vuserid": "rdc23000002"
    };
    print(formdata);
    var request = http.Request(
        'POST', Uri.parse('https://api.teckiko.com/roadways/vehicles'));
    request.body = json.encode(formdata);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  bool shouldShowDropdown() {
    return vehiclemodel != null;
  }

  final TextEditingController textStateController = TextEditingController();
  @override
  void dispose() {
    textStateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (vehicleType != null && brandname != null) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 156, 235, 228),
        appBar: AppBar(
          title: const Text('RoadWays Info Services'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: SizedBox(
          height: height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
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
                              Vehiclemobilenumber = value;
                            });
                          },
                          controller: VehiclemobilenumberController,
                          decoration: InputDecoration(
                            labelText: 'Vehicle Mobile Number',
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
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              vehicleregisternumber = value;
                            });
                          },
                          controller: vehicleregisternumberController,
                          decoration: InputDecoration(
                            labelText: 'Vehicle Register Number',
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
                          //     return 'Enter the Vehicle Register Number';
                          //   }
                          //   return null;
                          // },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: DropdownButtonFormField<int>(
                            value: selectedVehicleTypeId ??
                                vehicleType![0]
                                    ['select'], // Set default value here
                            items: vehicleType!
                                .map((vehicleType) => DropdownMenuItem<int>(
                                      value: vehicleType['vtypeid'],
                                      child: Text(vehicleType['vtype']),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedVehicleTypeId = value;
                              });
                              getvehiclemodel();
                            },
                            decoration: InputDecoration(
                              labelText: 'Select a Vehicle Type',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: DropdownButtonFormField<int>(
                            value:
                                selectedBrandNameId ?? brandname![0]['select'],
                            items: brandname!
                                .map((brandname) => DropdownMenuItem<int>(
                                      value: brandname['brandid'],
                                      child: Text(brandname['brandname']),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBrandNameId = value;
                              });
                              getvehiclemodel();
                            },
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Select is required';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              labelText: 'Select a Brand Name',
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
                        const SizedBox(height: 20),
                        Container(
                          child: Visibility(
                            visible: shouldShowDropdown(),
                            child: DropdownButtonFormField<int>(
                              value: selectedVehicleModel ??
                                  vehiclemodel?[0]['search'],
                              items: (vehiclemodel ?? [])
                                  .map((vehicle) => DropdownMenuItem<int>(
                                        value: vehicle['vmid'],
                                        child: Text(vehicle['vmname']),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedVehicleModel = value;
                                });
                              },
                              // validator: (value) {
                              //   if (value == null) {
                              //     return 'Select is required';
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                labelText: 'Select Vehicle Model',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: DropdownButtonFormField<String>(
                            onChanged: (newValue) {
                              setState(() {
                                selectedUserType = newValue!;
                              });
                            },
                            value:
                                selectedUserType, // Assign the selected value
                            items: [
                              'Passenger User Type',
                              'Commercial User Type',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Select is required';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              labelText: 'Vehicle User Type',
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
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (newValue) {
                            setState(() {
                              Vehicleseatcount = newValue;
                            });
                          },
                          controller: VehicleseatcountController,
                          decoration: InputDecoration(
                            labelText: 'Vehicle Seat Count',
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
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: DropdownButtonFormField<String>(
                            onChanged: (newValue) {
                              setState(() {
                                selectedFuelType = newValue!;
                              });
                            },
                            value:
                                selectedFuelType, // Assign the selected value
                            items: [
                              'Gas',
                              'Petrol',
                              'Disel',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Select is required';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              labelText: 'Vehicle Fuel Type',
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
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (newValue) {
                            setState(() {
                              Vehicletotaltyres = newValue;
                            });
                          },
                          controller: VehicletotaltyresController,
                          decoration: InputDecoration(
                            labelText: 'Vehicle Total Tyres',
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
                          //   if (value == null) {
                          //     return 'Select is required';
                          //   }
                          //   return null;
                          // },
                        ),
                        const SizedBox(height: 20),
                        FormField<String>(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select is required';
                            }
                            return null;
                          },
                          builder: (FormFieldState<String> state) {
                            return Container(
                              width: 50,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 43, 42, 42),
                                  width: 1,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<int>(
                                  // Changed to int
                                  isExpanded: true,
                                  hint: Text(
                                    'Select State',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  value: selectedRegisterState ??
                                      states![0]['select']
                                          as int?, // Cast as int?
                                  items: states!
                                      .map((state) => DropdownMenuItem<int>(
                                            // Changed to int
                                            value: state['stateid']
                                                as int, // Cast as int
                                            child: Text(state['name']
                                                as String), // Cast to String
                                          ))
                                      .toList(),
                                  onChanged: (int? value) {
                                    // Changed to int?
                                    setState(() {
                                      selectedRegisterState = value;
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 200,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: textStateController,
                                    searchInnerWidgetHeight: 50,
                                    searchInnerWidget: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        right: 8,
                                        left: 8,
                                      ),
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        controller: textStateController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search State',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn:
                                        (items, selectedRegisterState) => items
                                            .value
                                            .toString()
                                            .toLowerCase()
                                            .contains(selectedRegisterState
                                                .toLowerCase()),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 200,
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        const SizedBox(height: 10),
                        Container(
                          width: 200,
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        const SizedBox(height: 10),
                        Container(
                          width: 200,
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        const Text(
                          'Additional Details*',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          child: DropdownButtonFormField<String>(
                            onChanged: (newValue) {
                              setState(() {
                                selectedInsuranceType = newValue!;
                              });
                            },
                            value:
                                selectedInsuranceType, // Assign the selected value
                            items: [
                              'insurance type',
                              'passenger vehicle insurance',
                              'commercial insurance',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Select is required';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              labelText: 'Insurance Type',
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
                        const SizedBox(height: 20),
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
                              color: const Color.fromARGB(255, 43, 42, 42),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: dateInput1,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate(context, dateInput1);
                                },
                              ),
                              border: InputBorder.none,
                              hintText: "Insurance_Valid_Till",
                              hintStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            readOnly: false,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateInput1.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
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
                              color: const Color.fromARGB(255, 43, 42, 42),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: dateInput2,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate(context, dateInput2);
                                },
                              ),
                              border: InputBorder.none,
                              hintText: "Next_FC_Date",
                              hintStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateInput2.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        Container(
                          child: DropdownButtonFormField<String>(
                            onChanged: (newValue) {
                              setState(() {
                                selectedGPSEnabled = newValue!;
                              });
                            },
                            value:
                                selectedGPSEnabled, // Assign the selected value
                            items: [
                              'YES',
                              'NO',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Select is required';
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              labelText: 'Is Gps Enabled',
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
                        const SizedBox(height: 10),
                        Container(
                          width: 200,
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        const SizedBox(height: 10),
                        Container(
                          width: 200,
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
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
                                    color: const Color.fromARGB(
                                        255, 189, 232, 238),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const servicePage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
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
                                      if (_formKey.currentState!.validate()) {
                                        addvehiclefunction();
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         const Example(),
                                        //   ),
                                        // ); // Use _login instead of loginFunction
                                      }
                                    },
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
