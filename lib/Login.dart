import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/HomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_api/Signup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main.dart';
import 'HomePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginWithEmailPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to HomeScreen if login is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? AppLocalizations.of(context)!.loginFailed)),
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Navigate to HomeScreen if login is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? AppLocalizations.of(context)!.loginFailed)),
      );
    }
  }

  Widget _buildGoogleSignInButton() {
    return SquareTitle(
      onTap: _loginWithGoogle,
      imagePath: 'lib/images/google.jpeg', // Adjust the path as per your project structure
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(fontSize: 24, color: Colors.white, height: 10),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: _buildEmailTextField(),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: _buildPasswordTextField(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginWithEmailPassword,
                child: Text(AppLocalizations.of(context)!.login, style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 10),
              _buildGoogleSignInButton(),
              SizedBox(height: 40),
              Text(
                AppLocalizations.of(context)!.noAccount,
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text(AppLocalizations.of(context)!.signUp, style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
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

class SquareTitle extends StatelessWidget {
  final Future<void> Function() onTap;
  final String imagePath;

  const SquareTitle({
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onTap();
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.googleSignIn,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
