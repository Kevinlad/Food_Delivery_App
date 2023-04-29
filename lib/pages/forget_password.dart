import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white));

  TextEditingController _emailText = TextEditingController();
  void dispose() {
    _emailText.dispose();
  }

  String? errorMessage = '';

  bool isloading = false;
  Future<void> _forgetPassword(context) async {
    if (_emailText.text.isEmpty) {
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('AlertDialog Title'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('This Field cannot be empty.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      try {
        isloading = true;
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailText.text.trim());
      } on FirebaseAuthException catch (e) {
        errorMessage = e.message;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('password reset'),
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                // style: const TextStyle(color: Colors.white),
                controller: _emailText,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email Here',
                  // hintStyle: const TextStyle(color: Colors.white),
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _forgetPassword(context);
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Sign in ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.white,
                  onPrimary: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
