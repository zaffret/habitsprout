import 'package:flutter/material.dart';
import '../models/action_model.dart';

class ActionCard extends StatelessWidget {
  final int tally;
  final GreenAction action;
  final VoidCallback onTap;

  const ActionCard(
      {required this.action,
      required this.tally,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
            width: 394,
            height: 121,
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 96,
                  height: 93,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: action.categoryColor),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Image.asset(
                        action.imageUrl,
                        width: 58,
                        height: 58,
                        fit: BoxFit
                            .cover, // Adjust this based on your image requirements
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 69,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: action.categoryColor),
                            child: Text(
                              action.category,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          if (action.co2 != 0) ...[
                            const SizedBox(width: 5),
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      const Color.fromARGB(255, 39, 150, 43)),
                              child: Text(
                                '${action.co2} kg CO₂',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          if (action.water != 0) ...[
                            const SizedBox(width: 5),
                            Container(
                              alignment: Alignment.center,
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.blue.shade200),
                              child: Text(
                                '${action.water} L',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          if (action.energy != 0) ...[
                            const SizedBox(width: 5),
                            Container(
                              alignment: Alignment.center,
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.yellow.shade200),
                              child: Text(
                                '${action.energy} kWhr',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          action.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 50),
              ],
            )),
      ),
    );
  }
}
