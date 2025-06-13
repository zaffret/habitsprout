import 'package:flutter/material.dart';
import 'package:habit_sprout1/models/action_model.dart';

class FootprintTab extends StatelessWidget {
  final LocalUser? user;

  const FootprintTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Replace with actual userId logic
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Your Annual Footprint',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 20),
        _questionnaire(context),
        const SizedBox(height: 15),
        SizedBox(height: 450, child: _footprints()),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 5),
            Text(
              'Reference emissions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _referencedEmissions(),
        const SizedBox(height: 10),
      ],
    );
  }

  Container _questionnaire(BuildContext context) {
    return Container(
      width: 410,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(201, 255, 255, 255),
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.question_answer, size: 32), // Clipboard icon
          const SizedBox(width: 16), // Spacing
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Take the assessment questionnaire',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Last taken: April 25, 2024',
                  // Format date
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the questionnaire screen
              Navigator.of(context)
                  .pushNamed('/questionnaire', arguments: user!.id);
            },
            child: const Icon(Icons.arrow_forward,
                size: 24, color: Colors.black), // Arrow icon
          ),
        ],
      ),
    );
  }

  Container _referencedEmissions() {
    Color getBarColor(double value) {
      if (value < 3) {
        return Colors.green;
      } else if (value >= 3 && value <= 6) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(201, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmissionBar(
            'Sustainable lifestyle',
            2.50,
            getBarColor(2.50),
          ),
          const SizedBox(height: 10),
          _buildEmissionBar(
            'National Average',
            8.91,
            getBarColor(8.91),
          ),
          const SizedBox(height: 10),
          _buildEmissionBar(
            'You',
            user!.co2Footprint.toDouble(),
            getBarColor(user!.co2Footprint.toDouble()),
          ),
        ],
      ),
    );
  }

  Widget _buildEmissionBar(String label, double value, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(label,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              width: value * 20, // Scale the width based on value
            ),
          ],
        ),
        const SizedBox(height: 5),
        const SizedBox(width: 10),
        Text('$value CO₂e TONS',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _footprints() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildCard(
          'Carbon Footprint',
          '${user?.co2Footprint.toStringAsFixed(2)} CO₂e TONS',
          Colors.green,
          'assets/images/carbon-footprint.png',
        ),
        _buildCard(
          'Water Footprint',
          '${user!.waterFootprint} Gallons',
          Colors.blue,
          'assets/images/water.png',
        ),
        _buildCard(
          'Energy Footprint',
          '${user!.energyFootprint} kWh',
          Colors.orange,
          'assets/images/power.png',
        ),
        _buildCard(
          'Food Waste',
          '${user!.foodWaste} Kilograms',
          Colors.lime,
          'assets/images/food-waste.png',
        ),
      ],
    );
  }

  Widget _buildCard(String title, String value, Color color, String image) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          width: 180,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Center content
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Image.asset(image, height: 78, width: 78),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
