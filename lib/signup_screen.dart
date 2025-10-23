import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/resources/auth_methods.dart';
import 'package:instagramclone/routes/routes.dart';
import 'package:instagramclone/utils/utils.dart';
import 'package:instagramclone/widgets/custom_textfield.dart';

import 'utils/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _img;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _img = im;
    });
  }

  signUp() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _img!,
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
              Stack(
                children: [
                  _img != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_img!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://w7.pngwing.com/pngs/304/275/png-transparent-user-profile-computer-icons-profile-miscellaneous-logo-monochrome.png',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              CustomTextfield(
                hintText: 'Enter Your Username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              SizedBox(height: 24),
              CustomTextfield(
                hintText: 'Enter Your Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              SizedBox(height: 24),
              CustomTextfield(
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              SizedBox(height: 24),
              CustomTextfield(
                hintText: 'Enter Your Bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  await signUp();
                },
                child: Container(
                  child: Text('Sign Up'),
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
                    child: Text("Already have an account? "),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.signup);
                          },
                          child: Container(
                            child: Text(
                              " Sign In.",
                              style: const TextStyle(
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
