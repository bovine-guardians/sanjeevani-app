import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_sign_in/google_sign_in.dart';

void raiseDialogBox(String text, String details, context) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(text, style: Theme.of(context).textTheme.headline6
                    //.copyWith(color: Colors.black),
                    ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(details,
                        style: Theme.of(context).textTheme.subtitle1
                        //.copyWith(color: Colors.black)
                        //style: TextStyle(color: Colors.red),
                        ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 50.0)),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Phoenix.rebirth(context);
                  },
                  child: const Text("Got It!"),
                ),
              ],
            ),
          ),
          margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim),
        child: child,
      );
    },
  );
}

Future<bool> signIn(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      raiseDialogBox(
          "User Not Found",
          "The user you have entered was not found in our databases. Please check your E-Mail or Sign-Up for a new account.",
          context);
    } else if (e.code == 'wrong-password') {
      raiseDialogBox(
          "Wrong Password",
          "The password you have provided was incorrect. Please check the password you have provided.",
          context);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return false;
}

Future<bool> register(
    String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      raiseDialogBox(
          "Weak Password",
          "Your password was too weak to enter, please use a stronger password. Hint: Use passwords that are atleast 8-characters and contain atleast one number",
          context);
    } else if (e.code == 'email-already-in-use') {
      raiseDialogBox(
          "E-Mail already in use",
          "The E-Mail you tried to sign up with was already in use, Please try to either Sign-In with the email or Sign-Up with a different E-Mail",
          context);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return false;
}

Future<bool> signInWithGoogle(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        raiseDialogBox("Account exists with different credential",
            "Check your credentials", context);
      } else if (e.code == 'invalid-credential') {
        raiseDialogBox(
            "Invalid Credentials", "Check your credentials", context);
      }
    } catch (e) {
      // handle this shit
    }
  }
  return false;
  //final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //final GoogleSignInAuthentication googleAuth =
  //    await googleUser!.authentication;
  //final credential = GoogleAuthProvider.credential(
  //  accessToken: googleAuth.accessToken,
  //  idToken: googleAuth.idToken,
  //);
//
  //try {
  //  await FirebaseAuth.instance.signInWithCredential(credential);
  //  return true;
  //} catch (e) {
  //  debugPrint(e.toString());
  //  return false;
  //}
}
