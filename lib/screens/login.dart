import 'dart:ui';

import 'package:barber_application/services/auth_service.dart';
import 'package:barber_application/user_controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool tryLogin = false;

  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Theme.of(context).primaryColor;
    }
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);

    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).colorScheme.surface,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/barber-shop.png'),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Text('My Barber Shop', style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Barber shop management system. Track your shop progress daily',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Login', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  )),
                ),
                Text('Create an account to start manage your barber shop',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColorDark
                  ),
                ),
                InkWell(
                  onTap: (){
                    print('button google tapped');
                  },
                  splashColor: Theme.of(context).primaryColor.withAlpha(40),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/google-icon.png'),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Sign in with Google',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 10,
                        indent: 10,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    Text('or Sign in with Email'),
                    Expanded(
                      child: Divider(
                        endIndent: 10,
                        indent: 10,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Email',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2
                    )
                  ),
                  child: TextFormField(
                    controller: _email,
                    validator: (value) => value!.isEmpty
                        ? 'Email Empty'
                        : null,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'mail@website.com',
                      border: OutlineInputBorder(),
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.grey,
                          width: 2
                      )
                  ),
                  child: TextFormField(
                    controller: _password,
                    validator: (value) => value!.length < 6
                        ? 'Password Error'
                        : null,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'min.8 character',
                        border: OutlineInputBorder(),
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value){
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text('Remember me',
                        style: TextStyle(
                          fontWeight: FontWeight.w700
                        )
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                        },
                        child: Text('Forget Password?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            FocusScope.of(context).unfocus();
                            bool status = await authProvider.signInWithEmailAndPassword(_email.text, _password.text);
                            if(!status){
                              _scaffoldKey.currentState!.showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 5),
                                    content: Text("please enter correct UserID and Password"),
                                    backgroundColor: Colors.red,
                                  )
                              );
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> UserController()));
                            }
                          }

                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.only(
                            top:10,
                            bottom: 10,
                          ),
                          elevation: 5,
                          textStyle: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor
                        ),
                          child: Text('Login')),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                        },
                        child: Text('Create An Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

}
