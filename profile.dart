import 'package:flutter/material.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String? selectedValue;
  String name = "";
  String aadhaarnumber = "";
  String otp = "";
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
                                        aadhaarnumber: aadhaarnumber,
                                        otp: otp,
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
                                        aadhaarnumber = value["aadhaarnumber"];
                                        otp = value["otp"];
                                        doornumberShopnumber =
                                            value["doornumber/shopnumber"];
                                        streetname = value["streetname"];
                                        landmark = value["landmark"];
                                        district = value["district"];
                                        selectState = value["selectstate"];
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
                            const Text("Aadhaar Number",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(aadhaarnumber),
                            const SizedBox(height: 8),
                            const Text("OTP",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(otp),
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
  final String aadhaarnumber;
  final String otp;
  final String doornumberShopnumber;
  final String streetname;
  final String landmark;
  final String district;
  final String selectState;
  final String pincode;

  const SecondPage({
    Key? key,
    required this.name,
    required this.aadhaarnumber,
    required this.otp,
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
  TextEditingController aadhaarnumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController doornumberShopnumberController =
      TextEditingController();
  TextEditingController streetnameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController selectStateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    aadhaarnumberController.text = widget.aadhaarnumber;
    otpController.text = widget.otp;
    doornumberShopnumberController.text = widget.doornumberShopnumber;
    streetnameController.text = widget.streetname;
    landmarkController.text = widget.landmark;
    districtController.text = widget.district;
    selectStateController.text = widget.selectState;
    pincodeController.text = widget.pincode;
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
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "Enter Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: aadhaarnumberController,
                              decoration: InputDecoration(
                                hintText: "Enter Aadhaar Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("Verify & Send OTP"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: otpController,
                              decoration: InputDecoration(
                                hintText: "Enter OTP",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("Resend OTP"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Address Details',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: doornumberShopnumberController,
                              decoration: InputDecoration(
                                hintText: "Enter Door Number / Shop Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: streetnameController,
                              decoration: InputDecoration(
                                hintText: "Enter Street Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: landmarkController,
                              decoration: InputDecoration(
                                hintText: "Enter Landmark",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: districtController,
                              decoration: InputDecoration(
                                hintText: "Enter District",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: selectedValue,
                              items: ['Tamil nadu', 'No'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Select State",
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: pincodeController,
                              decoration: InputDecoration(
                                hintText: "Enter Pincode",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                              ),
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
                                        "aadhaarnumber":
                                            aadhaarnumberController.text,
                                        "otp": otpController.text,
                                        "doornumber/shopnumber":
                                            doornumberShopnumberController.text,
                                        "streetname": streetnameController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedTextField extends StatelessWidget {
  final String label;
  final bool isPassword;

  const RoundedTextField(
      {Key? key, required this.label, this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 43, 42, 42),
          width: 1,
        ),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
