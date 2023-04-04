import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/my_button.dart';
import 'components/my_text_field.dart';
import 'components/square_tile.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTab;
   LoginPage({super.key, required this.onTab});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn()async {

    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    Navigator.pop(context);
    }on FirebaseAuthException catch (e) {
       Navigator.pop(context);
      if(e.code == 'user-not-found'){
        //show error to user
        wrongEmailMessage();
        
      }else if(e.code == 'wrong-password'){
        //show error to user
        wrongPasswordMessage();
        
      }
    }
  }
  void wrongEmailMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          backgroundColor: Colors.purple,
          title: Text('Incorrect Email',
          style: TextStyle(color: Colors.white),
          ),
        );
      }
    
    );
  }
  void wrongPasswordMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          backgroundColor: Colors.purple,
          title: Text('Incorrect Password',
          style: TextStyle(color: Colors.white),
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
                //welcome
                const Text(
                  "Welcome back you\'ve been missed!",
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
                 //forgot password
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 25.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                     children: const [
                       Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 97, 97, 97),
                        ),
                        ),
                     ],
                   ),
                 ),
                  spaceSmall(),
                MyButton(
                  text: 'Sign In',
                  onTab:signUserIn,
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
                    const Text('Not a member?',
                    style: TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTab,
                      child: const Text('Register now',
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