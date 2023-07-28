import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:givison/src/constants/image_strings.dart';
import 'package:givison/src/constants/size.dart';
import 'package:givison/src/constants/text_strings.dart';
import 'package:givison/src/features/authentication/controllers/signup_controller.dart';
import 'package:givison/src/features/authentication/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:givison/src/utils/utils.dart';
import 'package:givison/src/features/authentication/screens/dashboard/verify_email.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}):super(key:key);
  
  @override
  State<SignUpScreen> createState()=> _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>{
  bool loading= false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginn(){
    setState((){
                                loading = true;
                              });
                              _auth.createUserWithEmailAndPassword(
                                email:emailController.text.toString(),
                                password:passwordController.text.toString()).then((value){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Verify()));
                                  

                                }).onError((error, stackTrace){
                                  Utils().toastMessage(error.toString());
                                  
                            });
                            }
  


  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(248, 229, 249, 1),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage(tSignupImg), height: size.height*0.37,),
                Text(tSignupTitle, style: Theme.of(context).textTheme.displayMedium,),
                Text(tSignupSubTitle, style: Theme.of(context).textTheme.titleSmall,),

                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: tFormHeight-10),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          labelText: tFullName,
                          hintText: tFullName,
                          border: OutlineInputBorder()
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: tFormHeight-20,),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline_outlined),
                          labelText: tEmail,
                          hintText: tEmail,
                          border: OutlineInputBorder()
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: tFormHeight-20,),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone_callback_outlined),
                          labelText: tPhoneNo,
                          hintText: tPhoneNo,
                          border: OutlineInputBorder()
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Valid Phone Number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: tFormHeight-20,),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          labelText: tPassword,
                          hintText: tPassword,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: tFormHeight-20),
                      
                      SizedBox(
                        width:double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              loginn();
                            }
                          }, 
                          child: Text(tSignup.toUpperCase())
                        ),
                      ),
                      Align(alignment: Alignment.center,child: TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));}, child: Text.rich(TextSpan(
                        text: tAlreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.titleSmall,
                        children: [
                          TextSpan(text:tLogin,style: TextStyle(color:Colors.blue)),
                        ])))),
                    ],),
                  ))
            ]),
          ),
        )),
    );
  }
}