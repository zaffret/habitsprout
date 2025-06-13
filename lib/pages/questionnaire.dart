import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SurveyForm extends StatefulWidget {
  static const routeName = '/questionnaire';

  const SurveyForm({super.key});

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  double? mealPreference;
  double? smokePreference;
  double? vehicleOwnership;
  double? groceryShopping;
  double? showerFrequency;
  double? light;
  String? userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is String) {
      setState(() {
        userId = arguments;
      });
    }
  }

  void _submitForm() async {
    if (mealPreference == null ||
        smokePreference == null ||
        vehicleOwnership == null ||
        groceryShopping == null ||
        showerFrequency == null ||
        light == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please answer all the questions before submitting.')),
      );
      return;
    }

    // Calculate the values based on the selected preferences
    double co2Fp = mealPreference! + smokePreference! + vehicleOwnership!;
    double waste = groceryShopping!;
    double waterFp = showerFrequency!;
    double energyFp = light!;

    try {
      await updateFootprint(userId!, co2Fp, energyFp, waste, waterFp);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Approximating your footprints...'),
          duration: Duration(seconds: 1),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Your footprints have been updated successfully!')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update footprint: $e')),
      );
    }
  }

  Future<void> updateFootprint(
      String userId, double co2, double energy, double waste, double water) {
    return FirebaseFirestore.instance.collection('users').doc(userId).update({
      'co2Fp': co2,
      'energyFp': energy,
      'waste': waste,
      'waterFp': water,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Q1. What would best describe your meals?'),
            ListTile(
              title: const Text('Vegan'),
              leading: Radio<double>(
                value: 0.89,
                groupValue: mealPreference,
                onChanged: (value) {
                  setState(() {
                    mealPreference = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Non-Vegan'),
              leading: Radio<double>(
                value: 4.67,
                groupValue: mealPreference,
                onChanged: (value) {
                  setState(() {
                    mealPreference = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Mostly Vegan'),
              leading: Radio<double>(
                value: 1.53,
                groupValue: mealPreference,
                onChanged: (value) {
                  setState(() {
                    mealPreference = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Mostly Non-Vegan'),
              leading: Radio<double>(
                value: 3.99,
                groupValue: mealPreference,
                onChanged: (value) {
                  setState(() {
                    mealPreference = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Q2. Do you smoke?'),
            ListTile(
              title: const Text('No'),
              leading: Radio<double>(
                value: 0.0,
                groupValue: smokePreference,
                onChanged: (value) {
                  setState(() {
                    smokePreference = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Yes'),
              leading: Radio<double>(
                value: 1.0,
                groupValue: smokePreference,
                onChanged: (value) {
                  setState(() {
                    smokePreference = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("I smoke e-cigarettes"),
              leading: Radio<double>(
                value: 0.5,
                groupValue: smokePreference,
                onChanged: (value) {
                  setState(() {
                    smokePreference = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Yes, but not much"),
              leading: Radio<double>(
                value: 0.8,
                groupValue: smokePreference,
                onChanged: (value) {
                  setState(() {
                    smokePreference = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Q3. What type of vehicles do you own and how many?'),
            ListTile(
              title: const Text('2 cars and above'),
              leading: Radio<double>(
                value: 9.76,
                groupValue: vehicleOwnership,
                onChanged: (value) {
                  setState(() {
                    vehicleOwnership = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Just 1 car'),
              leading: Radio<double>(
                value: 5.67,
                groupValue: vehicleOwnership,
                onChanged: (value) {
                  setState(() {
                    vehicleOwnership = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Electric vehicle'),
              leading: Radio<double>(
                value: 1.5,
                groupValue: vehicleOwnership,
                onChanged: (value) {
                  setState(() {
                    vehicleOwnership = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Bikes'),
              leading: Radio<double>(
                value: 0.3,
                groupValue: vehicleOwnership,
                onChanged: (value) {
                  setState(() {
                    vehicleOwnership = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Public transport'),
              leading: Radio<double>(
                value: 3.21,
                groupValue: vehicleOwnership,
                onChanged: (value) {
                  setState(() {
                    vehicleOwnership = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Q4. How often do you grocery shop?'),
            ListTile(
              title: const Text('Everyday'),
              leading: Radio<double>(
                value: 68,
                groupValue: groceryShopping,
                onChanged: (value) {
                  setState(() {
                    groceryShopping = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Around every 2/3 days'),
              leading: Radio<double>(
                value: 34,
                groupValue: groceryShopping,
                onChanged: (value) {
                  setState(() {
                    groceryShopping = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Every week'),
              leading: Radio<double>(
                value: 26,
                groupValue: groceryShopping,
                onChanged: (value) {
                  setState(() {
                    groceryShopping = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Every month'),
              leading: Radio<double>(
                value: 14,
                groupValue: groceryShopping,
                onChanged: (value) {
                  setState(() {
                    groceryShopping = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('Q5. How often do you shower?'),
            ListTile(
              title: const Text('Everyday'),
              leading: Radio<double>(
                value: 1360,
                groupValue: showerFrequency,
                onChanged: (value) {
                  setState(() {
                    showerFrequency = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Twice a day'),
              leading: Radio<double>(
                value: 2089,
                groupValue: showerFrequency,
                onChanged: (value) {
                  setState(() {
                    showerFrequency = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Not often'),
              leading: Radio<double>(
                value: 1385,
                groupValue: showerFrequency,
                onChanged: (value) {
                  setState(() {
                    showerFrequency = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Every week'),
              leading: Radio<double>(
                value: 429,
                groupValue: showerFrequency,
                onChanged: (value) {
                  setState(() {
                    showerFrequency = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("I don't shower, I bathe"),
              leading: Radio<double>(
                value: 2671,
                groupValue: showerFrequency,
                onChanged: (value) {
                  setState(() {
                    showerFrequency = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text("Q6. What kind of lights do you use in your house?"),
            ListTile(
              title: const Text('LED'),
              leading: Radio<double>(
                value: 8536,
                groupValue: light,
                onChanged: (value) {
                  setState(() {
                    light = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Incandescent'),
              leading: Radio<double>(
                value: 14565,
                groupValue: light,
                onChanged: (value) {
                  setState(() {
                    light = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Fluorescent'),
              leading: Radio<double>(
                value: 10788,
                groupValue: light,
                onChanged: (value) {
                  setState(() {
                    light = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(33, 47, 85, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(357, 57),
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onPressed: () {
                  _submitForm();
                },
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
