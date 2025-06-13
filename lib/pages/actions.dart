import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_sprout1/models/action_model.dart';
import 'package:habit_sprout1/pages/action_details_page.dart';
import 'package:habit_sprout1/pages/calender.dart';
import 'package:habit_sprout1/services/firebase_service.dart';
import 'package:habit_sprout1/widgets/action_card.dart';

class ActionsPage extends StatefulWidget {
  final LocalUser? user;
  const ActionsPage({super.key, required this.user});

  @override
  _ActionsPageState createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<int> _fetchDailyActionCount() async {
    int count = await fbService.dailyActionCount(widget.user!.id);
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Actions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 11, 156, 16))),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TableCalendarPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ),
                  )
                ],
              ),
            ),
            _horizontalCalendar(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.user!.tally.toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 11, 156, 16),
                          fontFamily: "OpenSans",
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const TextSpan(
                        text: "\nACTIONS\nDONE",
                        style: TextStyle(
                          color: Color.fromARGB(255, 11, 156, 16),
                          fontFamily: "OpenSans",
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                FutureBuilder<int>(
                  future: _fetchDailyActionCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      if (kDebugMode) print('Error: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: snapshot.data.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 11, 156, 16),
                                fontFamily: "OpenSans",
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const TextSpan(
                              text: "\nACTIONS\nTODAY",
                              style: TextStyle(
                                color: Color.fromARGB(255, 11, 156, 16),
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                          child: Text('No actions found for today'));
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "Favorite Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            StreamBuilder<List<GreenAction>>(
              stream: fbService.getFavoriteActionsByUserId(widget.user!.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  if (kDebugMode) print('Error: ${snapshot.error}');
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No favorite actions found'));
                } else {
                  final actions = snapshot.data!;
                  return _horizontalActionCards(actions);
                }
              },
            ),
            const Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "Take Action",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 19, 241, 23),
                borderRadius: BorderRadius.circular(12),
                border: const Border.fromBorderSide(BorderSide.none),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/9934274_task_list_check_menu_document_icon.png",
                        height: 74,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Be the change that you want to see.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 9, 184, 120),
                      foregroundColor: const Color.fromRGBO(33, 47, 85, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/actions_list', arguments: widget.user);
                    },
                    child: const Text(
                      "Explore actions",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // StreamBuilder<List<DailyActionRecord>>(
            //   stream: fbService.getDailyActionRecords(widget.user!.id),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       if (kDebugMode) print('Error: ${snapshot.error}');
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return Center(child: Text('No daily actions found'));
            //     } else {
            //       final dailyRecords = snapshot.data!;
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         itemCount: dailyRecords.length,
            //         itemBuilder: (context, index) {
            //           final record = dailyRecords[index];
            //           return ListTile(
            //             leading: CircleAvatar(
            //               backgroundColor: record.categoryColor,
            //               child: Text(
            //                 record.category.substring(0, 1).toUpperCase(),
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //             title: Text(record.name),
            //             subtitle: Text(record.timestamp),
            //             onTap: () {},
            //           );
            //         },
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _horizontalCalendar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_dates.length, (index) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: _dateSlots(
                  _dates[index]['day']!,
                  _dates[index]['date']!,
                  _selectedIndex == index,
                  _selectedIndex == index
                      ? const Color.fromARGB(255, 24, 195, 30)
                      : const Color.fromARGB(255, 78, 78, 78),
                ),
              ),
              const SizedBox(width: 10),
            ],
          );
        }),
      ),
    );
  }

  Widget _dateSlots(String day, String date, bool isSelected, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(15, 15, 1, 1),
                width: 2,
              ),
              color: isSelected
                  ? const Color.fromARGB(255, 42, 202, 48)
                  : const Color.fromRGBO(33, 47, 85, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 63,
            width: 45,
            alignment: Alignment.center,
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizontalActionCards(List<GreenAction> actions) {
    Future<int> getSameActionTally(String actionId) async {
      String userId = widget.user!.id;
      SameActionTally tally =
          await fbService.getSameActionTallyForCurrentDate(actionId, userId);

      return tally.tally;
    }

    return SizedBox(
      height: 440,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (actions.length / 3).ceil(),
        itemBuilder: (context, rowIndex) {
          int startIndex = rowIndex * 3;
          int endIndex =
              startIndex + 3 < actions.length ? startIndex + 3 : actions.length;

          List<Widget> rowChildren = [];
          for (int i = startIndex; i < endIndex; i++) {
            rowChildren.add(
              FutureBuilder<int>(
                future: getSameActionTally(actions[i].id),
                builder: (context, tallySnapshot) {
                  if (tallySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (tallySnapshot.hasError) {
                    return Center(child: Text('Error: ${tallySnapshot.error}'));
                  }
                  if (kDebugMode) print(tallySnapshot.data);

                  int tally = tallySnapshot.data ?? 0;

                  return ActionCard(
                    action: actions[i],
                    tally: tally,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActionDetails(
                            action: actions[i],
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          // Return a column of ActionCards for the current row
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rowChildren,
            ),
          );
        },
      ),
    );
  }

  final List<Map<String, String>> _dates = [
    {'day': 'Sun', 'date': '28'},
    {'day': 'Mon', 'date': '29'},
    {'day': 'Tue', 'date': '30'},
    {'day': 'Wed', 'date': '31'},
    {'day': 'Thu', 'date': '1'},
    {'day': 'Fri', 'date': '2'},
    {'day': 'Sat', 'date': '3'},
    {'day': 'Mon', 'date': '4'},
    {'day': 'Tue', 'date': '5'},
  ];
}
