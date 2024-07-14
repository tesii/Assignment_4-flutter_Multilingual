import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Sign up successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.accountCreated)),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = AppLocalizations.of(context)!.weakPassword;
      } else if (e.code == 'email-already-in-use') {
        errorMessage = AppLocalizations.of(context)!.emailInUse;
      } else {
        errorMessage = AppLocalizations.of(context)!.genericError;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signUp),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.changeLanguage),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.english),
                          onTap: () {
                            MyApp.setLocale(context, const Locale('en'));
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.french),
                          onTap: () {
                            MyApp.setLocale(context, const Locale('fr'));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blueAccent,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.createAccount,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 30),
                _buildNameTextField(),
                SizedBox(height: 30),
                _buildEmailTextField(),
                SizedBox(height: 30),
                _buildPasswordTextField(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text(AppLocalizations.of(context)!.signUp),
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.alreadyHaveAccount,
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: TextStyle(color: Colors.orange, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.enterFullName,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.email,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.password,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: TextStyle(color: Colors.white),
      obscureText: true,
    );
  }
}
