import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  const Example({Key? key});

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
                height: 120,
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
                      'Road Ways Info',
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        height: height / 1.2,
                        width: 100,
                        margin: const EdgeInsets.all(20), // Reduced margin
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_circle_left),
                                      onPressed: () {
                                        // Navigate to the previous screen or page
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const SelectableText(
                                      'Select Subscription Package',
                                      style: TextStyle(
                                        color: Colors.blueAccent, // Text color
                                        fontSize: 15, // Text size
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(height: 10),
                                    // Use height instead of width for SizedBox
                                    Container(
                                      width: 200,
                                      height:
                                          190, // Increased the width to accommodate both elements side by side
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 219, 239, 241),
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      child: Column(
                                        // Use Row instead of Column
                                        children: <Widget>[
                                          const SelectableText(
                                            'One Month Subscription',
                                            style: TextStyle(
                                              color: Colors.red, // Text color
                                              fontSize: 15, // Text size
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          const SelectableText(
                                            'RS:200/Month',
                                            style: TextStyle(
                                              color: Colors.black, // Text color
                                              fontSize: 15, // Text size
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          const SelectableText(
                                            'Total Payable amount:0',
                                            style: TextStyle(
                                              color: Colors.black, // Text color
                                              fontSize: 15, // Text size
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          // To make the TextButton take available space

                                          Container(
                                            width: 150,
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.blue,
                                                  Colors.green
                                                ],
                                              ),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "Select",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(
                                        height:
                                            20), // Use height instead of width for SizedBox
                                    Container(
                                      width: 200,
                                      height:
                                          220, // Increased the width to accommodate both elements side by side
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 223, 239, 241),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        // Use Row instead of Column
                                        children: <Widget>[
                                          const SelectableText(
                                            'One Year Subscription',
                                            style: TextStyle(
                                              color: Colors.red, // Text color
                                              fontSize: 15, // Text size
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          const SelectableText(
                                            '(50% discount)',
                                            style: TextStyle(
                                              color: Colors.black, // Text color
                                              fontSize: 15, // Text size
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          const SelectableText(
                                            'RS:1200/Year',
                                            style: TextStyle(
                                              color: Colors.black, // Text color
                                              fontSize: 15, // Text size
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          const SelectableText(
                                            'Total Payable amount:0',
                                            style: TextStyle(
                                              color: Colors.black, // Text color
                                              fontSize: 15, // Text size
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          // To make the TextButton take available space
                                          Container(
                                            width: 150,
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.blue,
                                                  Colors.green
                                                ],
                                              ),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
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
                                    ),
                                  ],
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

  const RoundedTextField({
    Key? key,
    required this.label,
    this.isPassword = false,
  }) : super(key: key);

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
