import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/my_button.dart';
import 'components/my_text_field.dart';
import 'components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTab;
   const RegisterPage({super.key, required this.onTab});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void signUserUp()async {

    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      );

    try {
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    }else{
      showErrorMessage("Passwords don't match!");
    }
    Navigator.pop(context);
    }on FirebaseAuthException catch (e) {
       Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }
  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.purple,
          title: Center(
            child: Text(
              message,
            style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 224, 224),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spaceMedium(),
                //logo
                const Icon(
                  Icons.lock,
                  size: 50,
                  color: Color.fromARGB(255, 0, 0, 0),
                  ),
                spaceMedium(),
                //create
                const Text(
                  "Let\'s create an account for you!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 97, 97, 97),
                    fontSize: 16,
                  ),
                ),
                spaceMedium(),
                //username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail', obscureText: false,
                ),
                spaceSmall(),
                //password textfield
                 MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                 ),
                 spaceSmall(),
                 MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                 ),
                  spaceSmall(),
                MyButton(
                  text: 'Sign Up',
                  onTab:signUserUp,
                ),
                spaceMedium(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: colors(),
                      ))
                    ],
                  ),
                ),
                spaceSmall(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SquareTile(imagePath: 'lib/images/google.png'),
                    SizedBox(width: 25),
                    SquareTile(imagePath: 'lib/images/apple.png'),
                  ],
                ),
                spaceSmall(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: colors(),
                      ))
                    ],
                  ),
                ),
                spaceSmall(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?',
                    style: TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTab,
                      child: const Text('Login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ],
                ),
                spaceSmall()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color colors() => const Color.fromARGB(255, 189, 189, 189);

  SizedBox spaceLarge() => const SizedBox(height: 50);
  SizedBox spaceSmall() => const SizedBox(height: 10);
  SizedBox spaceMedium() => const SizedBox(height: 25);
}