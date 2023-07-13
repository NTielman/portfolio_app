import 'package:flutter/material.dart';

void main() {
  runApp(const MiCard());
}

class MiCard extends StatelessWidget {
  const MiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio Card',
        theme: ThemeData(
          fontFamily: 'Lexend',
          primarySwatch: Colors.indigo,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        home: MediaQuery.of(context).orientation == Orientation.portrait
            ? const PotraitPage()
            : const LandscapePage());
  }
}

class ListCard extends StatelessWidget {
  final String cardText;
  final IconData cardIcon;

  const ListCard({
    super.key,
    required this.cardText,
    required this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 25.0,
      ),
      child: ListTile(
        leading: Icon(
          cardIcon,
          color: Colors.indigo.shade300,
        ),
        title: Text(cardText),
      ),
    );
  }
}

class MiAvatar extends StatelessWidget {
  const MiAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.indigo, BlendMode.screen),
            image: AssetImage('images/flame-869.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          foregroundImage: AssetImage('images/dev_icon.png'),
          radius: 100.0,
        ),
      ),
    );
  }
}

class PotraitPage extends StatelessWidget {
  const PotraitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 0.5],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigo,
                Color.fromARGB(255, 9, 3, 30),
              ],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/stars.gif'),
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MiAvatar(),
                const Text(
                  'Nneka Tielman',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Paytone',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Fullstack Developer'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.indigo.shade50,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 5.0),
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.indigo.shade400,
                  ),
                ),
                const ListCard(
                  cardText: '+31 123 456 789',
                  cardIcon: Icons.phone,
                ),
                const ListCard(
                  cardText: 'nneka@gmail.com',
                  cardIcon: Icons.mail,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LandscapePage extends StatefulWidget {
  const LandscapePage({super.key});

  @override
  State<LandscapePage> createState() => _LandscapePageState();
}

class _LandscapePageState extends State<LandscapePage> {
  double topPos = 0.5;
  double leftPos = 10.0;
  final double _eyesWidth = 102.5;
  final double _eyesHeight = 25.0;
  final double _eyeGap = 15.0;

  void _handleTap(tapEvent) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Offset tapPosition = tapEvent.globalPosition;
    setState(() {
      topPos = _eyesHeight / (screenHeight / tapPosition.dy) - 12.5;
      leftPos =
          ((_eyesWidth - _eyeGap) / 2) / (screenWidth / tapPosition.dx) - 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _handleTap(details),
      onHorizontalDragUpdate: (details) => _handleTap(details),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            height: _eyesHeight,
            width: _eyesWidth,
            top: 242.5,
            left: 415.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pupil(
                  topPos: topPos,
                  leftPos: leftPos,
                ),
                Container(
                  width: _eyeGap,
                ),
                Pupil(
                  topPos: topPos,
                  leftPos: leftPos,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Pupil extends StatelessWidget {
  final double topPos;
  final double leftPos;

  const Pupil({
    super.key,
    required this.topPos,
    required this.leftPos,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: topPos,
              left: leftPos,
              child: Image.asset('images/pupil.png'),
            ),
          ],
        ),
      ),
    );
  }
}
