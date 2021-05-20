import 'package:flutter/material.dart';
import 'package:sanjeevani/screens/dashboard/dashboard.dart';
import 'package:sanjeevani/services/flutterfire_service.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sanjeevani"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width / 1.25,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "example@mail.com",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                    labelText: "E-Mail",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "required";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width / 1.25,
                child: TextFormField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "required";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white54,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate = await register(_emailController.text,
                        _passwordController.text, context);
                    if (shouldNavigate) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashBoard(),
                        ),
                      );
                    }
                  },
                  child: const Text("Sign-Up"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white54,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate = await signIn(_emailController.text,
                        _passwordController.text, context);
                    if (shouldNavigate) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashBoard(),
                        ),
                      );
                    }
                  },
                  child: const Text("Sign-In"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white54,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate = await signInWithGoogle(context);
                    if (shouldNavigate) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashBoard(),
                        ),
                      );
                    }
                  },
                  child: const Text("Sign-In with Google"),
                ),
              ),
            ],
          ),
        ));
  }
}
