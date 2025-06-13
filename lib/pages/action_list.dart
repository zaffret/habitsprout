import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habit_sprout1/models/action_model.dart';
import 'package:habit_sprout1/pages/action_details_page.dart';
import 'package:habit_sprout1/services/firebase_service.dart';
import 'package:habit_sprout1/widgets/action_card.dart';

class ActionsList extends StatefulWidget {
  static const routeName = '/actions_list';
  final LocalUser? user;
  const ActionsList({super.key, this.user});

  @override
  _ActionsListState createState() => _ActionsListState();
}

class _ActionsListState extends State<ActionsList> {
  LocalUser? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is LocalUser) {
      setState(() {
        user = arguments;
      });
    }
  }

  final FirebaseService _firebaseService = FirebaseService();

  Future<int> _getSameActionTally(String actionId) async {
    String userId = user!.id;
    SameActionTally tally = await _firebaseService
        .getSameActionTallyForCurrentDate(actionId, userId);
    return tally.tally;
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
      ),
      body: StreamBuilder<List<GreenAction>>(
        stream: _firebaseService.getActions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No actions found'));
          }

          List<GreenAction> actions = snapshot.data!;

          return ListView.builder(
            itemCount: actions.length,
            itemBuilder: (context, index) {
              return FutureBuilder<int>(
                future: _getSameActionTally(actions[index].id),
                builder: (context, tallySnapshot) {
                  if (tallySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (tallySnapshot.hasError) {
                    if (kDebugMode) print(tallySnapshot.error);
                    return Center(child: Text('Error: ${tallySnapshot.error}'));
                  }

                  int tally = tallySnapshot.data ?? 0;

                  return ActionCard(
                    action: actions[index],
                    tally: tally,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ActionDetails(action: actions[index], user: user),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
