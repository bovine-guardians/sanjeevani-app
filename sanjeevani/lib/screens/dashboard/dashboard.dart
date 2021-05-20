import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sanjeevani/screens/dashboard/pages/pages.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> pages = [
    const InsuranceDetailsPage(),
    const LivestockDetailsPage(),
    const OwnerDetailsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "Sanjeevani",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Sign Out"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Phoenix.rebirth(context);
              },
            )
          ],
        )),
        appBar: AppBar(
          title: const Text("Dashboard"),
          elevation: 0.0,
        ),
        body: TabBarView(
          children: pages,
        ),
        bottomNavigationBar: const TabBar(tabs: [
          Tab(icon: Icon(Icons.layers)),
          Tab(icon: Icon(Icons.sports_hockey)),
          Tab(icon: Icon(Icons.person))
        ]),
      ),
    );
  }
}
