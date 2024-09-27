import 'package:flutter/material.dart';
import 'package:ktdgkt/Bai1/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _MyWelcomeState();
}

const String urlLogo = "assets/images/calendar.png";

class _MyWelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       // padding: const EdgeInsets.all(8.0),
      //  decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/images/back.jfif"),
      //     fit: BoxFit.cover,
      //   )
      //  ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                
              ),
              Image.asset(
                urlLogo,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image),
                    
              ),
              const SizedBox(
                height: 0,
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Pacifico',
                  color: Color.fromARGB(255, 139, 241, 143),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 20,
                      //height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyLogin()),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
