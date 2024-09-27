import 'package:flutter/material.dart';
import 'package:ktdgkt/Bai1/task_list.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/back.jfif"),
          fit: BoxFit.cover,
        )
       ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                'Daily Planner',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Pacifico',
                  color: Color.fromARGB(255, 139, 241, 143),
                ),
              ),
                ),
                //nhap email
                const SizedBox(
                  height: 100,
                ),
                TextFormField(
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                        labelText: "Email", icon: Icon(Icons.email),
                        filled: true,
                      fillColor: Color.fromARGB(255, 241, 234, 234),
                        
                        ),
                        
                        ),
                //Nhap pass
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passcontroller,
                  decoration: const InputDecoration(
                      labelText: "Password", icon: Icon(Icons.password),
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 234, 234),
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TaskList()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0))),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    )),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0))),
                      child: const Text(
                        "Login with SSO",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
