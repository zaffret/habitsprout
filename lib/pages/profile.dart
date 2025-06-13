import 'package:flutter/material.dart';
import 'package:habit_sprout1/models/action_model.dart';
import 'package:habit_sprout1/pages/image.dart';
import 'package:habit_sprout1/pages/setttings.dart';
import '../widgets/impact.dart';
import '../widgets/footprint.dart';

class ProfilePage extends StatelessWidget {
  final LocalUser? user;
  final num? level;
  final String? title;
  final String? badge;

  const ProfilePage({
    super.key,
    required this.user,
    required this.level,
    required this.title,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 11, 156, 16),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 5),
            _userStats(context),
            const SizedBox(height: 15),
            _profileTabs(context, user),
          ],
        ),
      ),
    );
  }

  Widget _userStats(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 121,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(201, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 158, 158, 158).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageUploadPage(
                      userId: user!.id,
                      imageUrl: user!.imageUrl,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    user!.imageUrl,
                    width: 150,
                    height: 150,
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user!.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(width: 100),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsPage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 20,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 160,
                      height: 56,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromARGB(255, 28, 152, 17),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            badge!,
                            width: 46,
                            height: 46,
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Level ${level.toString()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Color.fromRGBO(33, 47, 85, 1),
                                ),
                              ),
                              Text(
                                title!,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 100,
                      height: 56,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromARGB(255, 28, 152, 17),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/11475488_light_bulb_plant_environment_nature_icon.png',
                            width: 26,
                            height: 37,
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Points',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Color.fromRGBO(33, 47, 85, 1),
                                ),
                              ),
                              Text(
                                user!.points.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
    );
  }

  Widget _profileTabs(BuildContext context, LocalUser? user) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  123, 255, 255, 255), // TabBar background color
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TabBar(
              indicatorWeight: 0,
              labelColor: const Color.fromARGB(255, 38, 148, 18),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
              indicator: BoxDecoration(
                border: const Border(bottom: BorderSide.none),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 38, 148, 18),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
                color: const Color.fromARGB(255, 11, 212, 18),
                borderRadius: BorderRadius.circular(20.0),
                shape: BoxShape.rectangle,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Impact'),
                Tab(text: 'Footprint'),
              ],
            ),
          ),
          SizedBox(
            height: 800,
            child: TabBarView(
              children: [
                ImpactTab(user: user),
                FootprintTab(user: user, key: const Key('footprintTab')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
