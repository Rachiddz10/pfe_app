import 'package:flutter/material.dart';
import 'package:pfe_app/screens/main_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({required this.idNumber, required this.name, Key? key}) : super(key: key);
  static const String id = 'splash_screen';
  final int idNumber;
  final String name;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //------- City api (id + name) ------
  int? id;
  String? name;
  void initializeData() {
    id = widget.idNumber;
    name = widget.name;
  }

  //-----------------------------------

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/mansorah.jpg'),
              colorFilter: ColorFilter.mode(Colors.green.withOpacity(0.2), BlendMode.saturation),
              fit: BoxFit.cover,
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SizedBox(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                '$name',
                                textStyle: const TextStyle(
                                  fontSize: 45.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.end,
                                speed: const Duration(milliseconds: 250),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                        child: SizedBox(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(
                                'A breif welcoming description',
                                textStyle: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0, top: 50.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            elevation: 5.0,
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, MainScreen.id);
                              },
                              minWidth: 150.0,
                              height: 42.0,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Visit this Town',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
