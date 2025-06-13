import 'package:flutter/material.dart';
import 'package:habit_sprout1/models/action_model.dart';

class HomePage extends StatefulWidget {
  final LocalUser? user;
  final num? level;

  const HomePage({super.key, required this.user, required this.level});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 11, 156, 16))),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _personalInfo(widget.user, widget.level),
            const SizedBox(height: 40),
            _carbonFootprint(widget.user),
            const SizedBox(height: 40),
            const Align(
              alignment: Alignment(-0.95, 0),
              child: Text(
                'Take Action',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            _shortCuts(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Tips for you',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            _tipsForYou(),
          ],
        ),
      ),
    );
  }
}

Stack _personalInfo(LocalUser? user, num? level) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Image.asset('assets/images/Group 103.png'),
      ),
      Positioned(
        left: 10.0,
        top: 10.0,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user?.imageUrl ?? ""),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: 'Hi, ',
                      style: TextStyle(
                          height: 1,
                          color: Color.fromRGBO(33, 47, 85, 1),
                          fontSize: 22)),
                  TextSpan(
                      text: '\n${user?.name ?? 'Guest'}',
                      style: const TextStyle(
                          fontFamily: "OpenSans",
                          color: Color.fromRGBO(33, 47, 85, 1),
                          height: 1,
                          fontSize: 25,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(width: 130),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Level     ${level.toString()}',
                      style: const TextStyle(
                          height: 1, color: Colors.white, fontSize: 17)),
                  TextSpan(
                      text: '\n${user?.points ?? 0}',
                      style: const TextStyle(
                          fontFamily: "OpenSans",
                          color: Colors.white,
                          height: 1.2,
                          fontSize: 17,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Container _carbonFootprint(LocalUser? user) {
  return Container(
    height: 255,
    decoration: const BoxDecoration(
      color: Color.fromARGB(201, 255, 255, 255),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          offset: Offset(0, 4),
          blurRadius: 4,
        ),
      ],
    ),
    child: Row(children: [
      const SizedBox(width: 30),
      Image.asset('assets/images/Carbon_foot_print.png', height: 62.51),
      const SizedBox(width: 20),
      Expanded(
        child: Column(children: [
          const SizedBox(height: 10),
          const Text('YOUR ANNUAL EMISSIONS',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          Text(user?.co2Footprint.toStringAsFixed(2) ?? '0',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w800)),
          const Text("CO₂e TONS",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                    text: 'DID YOU KNOW...\nTo offset your emissions,',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                TextSpan(
                    text:
                        ' you should plant ${((user?.co2Footprint ?? 0) * 32.5).ceil()} trees!',
                    style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(20, 162, 50, 1))),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: const Alignment(0.9, 0.9),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                backgroundColor: Colors.transparent,
                // foregroundColor: const Color.fromRGBO(
                //     33, 47, 85, 1), // Change the text and icon color
              ),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Take assessment',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 18.0), // Space between text and icon
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ]),
      ),
    ]),
  );
}

SingleChildScrollView _shortCuts() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _promptActionButtons(
            'CARRY OUT A TASK',
            'assets/images/9934274_task_list_check_menu_document_icon.png',
            const Color.fromARGB(255, 19, 241, 23)),
        _promptActionButtons(
            'JOIN A CHALLENGE',
            'assets/images/8660269_leader_teamwork_leadership_team_success_icon.png',
            Colors.white),
        _promptActionButtons(
            'CREATE A CHALLENGE',
            'assets/images/44753_magic_wand_icon.png',
            const Color.fromRGBO(225, 190, 231, 1)),
      ],
    ),
  );
}

SingleChildScrollView _tipsForYou() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        _buildTipCard(
            'A balanced diet', 'assets/images/Balanced_philosophy_V2.png'),
        _buildTipCard(
            'Local Produce', 'assets/images/shutterstock_141202630.png'),
        _buildTipCard('What are nanoplastics?',
            'assets/images/bottled-water_nanoplastics_microplastics_240-thousand-toxic-chemicals_contaminated_3m.png'),
        _buildTipCard("Water and safety", 'assets/images/water-update.png'),
        _buildTipCard("Circular economy",
            'assets/images/flat-design-circular-economy-infographic_23-2149205986.png'),
      ],
    ),
  );
}

Widget _promptActionButtons(String text, String imagePath, Color color) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(BorderSide.none),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      width: 179,
      height: 158,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: const Color.fromRGBO(33, 47, 85, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Image.asset(imagePath, height: 74, width: 79),
            const SizedBox(height: 22),
            Text(text,
                style: const TextStyle(
                    height: 1, fontSize: 13, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    ),
  );
}

Widget _buildTipCard(String title, String imagePath) {
  return SizedBox(
    width: 150,
    height: 200,
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50), // Circular shape
          child: Image.asset(
            imagePath,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        ),
      ],
    ),
  );
}
