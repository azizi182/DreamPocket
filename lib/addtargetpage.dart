import 'package:flutter/material.dart';

class Addtargetpage extends StatefulWidget {
  const Addtargetpage({super.key});

  @override
  State<Addtargetpage> createState() => _AddtargetpageState();
}

class _AddtargetpageState extends State<Addtargetpage> {
  TextEditingController targerAmountController = TextEditingController();
  TextEditingController startingAmountController = TextEditingController();
  TextEditingController savingAmountController = TextEditingController();
  TextEditingController targetTitleController = TextEditingController();
  int targetWeek = 0;
  int targetWeekCalculated = 0;
  String targetTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Target'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 180, 133, 56),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(32.0), // space yang dlm
                margin: EdgeInsets.all(16.0), // space luar
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // column input
                child: Column(
                  children: [
                    TextField(
                      controller: targetTitleController,
                      decoration: InputDecoration(
                        labelText: 'Target Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: targerAmountController,
                      decoration: InputDecoration(
                        labelText: 'Target Amount (RM)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: startingAmountController,
                      decoration: InputDecoration(
                        labelText: 'Starting Amount (RM)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: savingAmountController,
                      decoration: InputDecoration(
                        labelText: 'Saving Amount per Week (RM)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    //button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: calculateMethod,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              236,
                              160,
                              38,
                            ),
                          ),
                          child: Text('Save'),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            targetTitleController.clear();
                            targerAmountController.clear();
                            startingAmountController.clear();
                            savingAmountController.clear();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              236,
                              160,
                              38,
                            ),
                          ),
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                //output
                padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                margin: EdgeInsets.all(16.0),
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Target Detail',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Target Title: $targetTitle\nTarget Week: $targetWeek weeks',
                      style: TextStyle(fontSize: 18),
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

  //method calculate
  void calculateMethod() {
    //error handling
    try {
      if (targetTitleController.text.isEmpty ||
          targerAmountController.text.isEmpty ||
          startingAmountController.text.isEmpty ||
          savingAmountController.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please fill in all fields.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      String targetTitleCalculated = targetTitleController.text;
      double? targetAmount = double.tryParse(
        targerAmountController.text,
      ); // more secure parsing, if user put string thier become null.
      double? startingAmount = double.tryParse(startingAmountController.text);
      double? savingAmount = double.tryParse(savingAmountController.text);

      if (targetAmount == null ||
          startingAmount == null ||
          savingAmount == null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please enter the number only'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    targerAmountController.clear();
                    startingAmountController.clear();
                    savingAmountController.clear();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
      // error handling
      if (targetAmount <= 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Target Amount must be greater than 0.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // formula
      targetWeekCalculated = ((targetAmount - startingAmount) / savingAmount)
          .round(); // double to int

      Future.delayed(const Duration(seconds: 6), () {
        Navigator.pop(context, {
          'title': targetTitleCalculated,
          "week": targetWeekCalculated,
        });
      });

      if (targetWeekCalculated < 0) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Your amount not logic'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      print('Target Title: $targetTitle');
      print('Target Amount: $targetAmount');
      print('Starting Amount: $startingAmount');
      print('Saving Amount: $savingAmount');
      print('Target Week: $targetWeekCalculated');

      setState(() {
        targetWeek = targetWeekCalculated;
        targetTitle = targetTitleCalculated;
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
