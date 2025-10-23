import 'package:flutter/material.dart';
import 'package:instagramclone/resources/auth_methods.dart';
import 'package:instagramclone/routes/routes.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/widgets/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 54,
              ),
              SizedBox(height: 64),
              CustomTextfield(
                hintText: 'Enter Your Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              SizedBox(height: 24),
              CustomTextfield(
                hintText: 'Enter Your Password',
                textInputType: TextInputType.emailAddress,
                textEditingController: _passwordController,
                isPass: true,
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: Container(
                  child: Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account? "),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.signup);
                    },
                    child: Container(
                      child: const Text(
                        " Sign Up.",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
