import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OwnerDetailsPage extends StatefulWidget {
  const OwnerDetailsPage({Key? key}) : super(key: key);
  @override
  _OwnerDetailsPageState createState() => _OwnerDetailsPageState();
}

class _OwnerDetailsPageState extends State<OwnerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2017/08/nature-design.jpg'),
                    fit: BoxFit.cover)),
            // ignore: sized_box_for_whitespace
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: const Alignment(0.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoURL ??
                      'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                  radius: 60.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            user.displayName ?? "User Name Not available",
            style: const TextStyle(
                fontSize: 25.0,
                //color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.email ?? 'User Email not available',
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.phoneNumber ?? "User Phone Number not available",
            style: const TextStyle(
                fontSize: 15.0,
                color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}
