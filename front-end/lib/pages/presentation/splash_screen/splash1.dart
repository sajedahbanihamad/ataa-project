import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// Skip
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login_screen');
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color(0xFFBCBCBC),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Image
              Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 25),
                      blurRadius: 50,
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/image1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              /// Title
              const Text(
                "Give Items a Second Life",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// Description
              const Text(
                "Donate food, clothes, furniture,and more to trusted charities easily.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF475569),
                ),
              ),

              const Spacer(),

              /// Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xff529160),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xffB8E2C1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff529160),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/splash2');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        "assets/images/arrow1.svg",
                        width: 18,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
