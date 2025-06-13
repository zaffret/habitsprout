// impact_tab.dart
import 'package:flutter/material.dart';
import 'package:habit_sprout1/models/action_model.dart';

class ImpactTab extends StatelessWidget {
  final LocalUser? user;
  const ImpactTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(height: 30),
        Text(user!.tally.toString(),
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 38, 148, 18))),
        const SizedBox(height: 3),
        const Text('ACTIONS',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 38, 148, 18))),
        const SizedBox(height: 20),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(201, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3))
                ]),
            width: 394,
            height: 65,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                width: 113,
                alignment: Alignment.center,
                child: Text(user!.co2.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 38, 148, 18))),
              ),
              Container(
                width: 75.33,
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/Carbon_foot_print2.png',
                  width: 55.33,
                  height: 36.89,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text('kg CO₂e\nsaved',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 38, 148, 18))),
              )
            ])),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(201, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3))
              ]),
          width: 394,
          height: 65,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 113,
              alignment: Alignment.center,
              child: Text(user!.water.toString(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue)),
            ),
            Container(
              width: 75.33,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/9035077_water_icon.png',
                width: 32.33,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text('L Water\nsaved',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue)),
            )
          ]),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(201, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3))
              ]),
          width: 394,
          height: 65,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 113,
              alignment: Alignment.center,
              child: Text(user!.energy.toString(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(225, 141, 12, 1))),
            ),
            Container(
              width: 75.33,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/4023885_battery_electric_energy_storage_icon.png',
                width: 24,
                height: 47,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text('kWh Energy\nsaved',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(225, 141, 12, 1))),
            )
          ]),
        ),
      ],
    ));
  }
}
