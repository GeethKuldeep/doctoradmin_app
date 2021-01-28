import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctoradmin_app/common_widgets/form_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doctoradmin_app/services/auth.dart';
import 'package:provider/provider.dart';



enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {



  var _formkey =GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _UsernameController = TextEditingController();
  final FocusNode _UsernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _password1FocusNode = FocusNode();
  String get _Username => _UsernameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  User authResult;
  bool _passwordVisible;
  final snackBar = SnackBar(content: Text('Email is already registered'));
  String hello;
  int please;

// Find the Scaffold in the widget tree and use it to show a SnackBar.



  void _submit() async {
    try {
      final auth = Provider.of<AuthBase>(context);
      if (_formType == EmailSignInFormType.signIn) {
        authResult = await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(_email, _password);
        await Firestore.instance.collection('users').document(authResult.uid).setData({
          'username': _Username,
          'email': _email,
        });
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      if(e is PlatformException) {
        if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          hello =e.code;
          print(hello);
          ///ScaffoldMessenger.of(context).showSnackBar(
            ///SnackBar(
           ///   content: const Text('This Email is already registered \n Please go back '),
           /// ),
          ///);
        }
        if(e.code == 'ERROR_WRONG_PASSWORD') {
          ///ScaffoldMessenger.of(context).showSnackBar(
           /// SnackBar(
           ////   content: const Text('Wrong password'),
           /// ),
          ///);
        }
        if(e.code == 'ERROR_WRONG_PASSWORD') {
          ///ScaffoldMessenger.of(context).showSnackBar(
          /// SnackBar(
            ///  content: const Text('Wrong password!!!'),
           /// ),
          ///);
        }
        if(e.code == 'ERROR_USER_NOT_FOUND') {
         /// ScaffoldMessenger.of(context).showSnackBar(
           /// SnackBar(
           ///   content: const Text('No user found!!!'),
          ///  ),
        ///  );
        }

      }
    }
  }


  @override
  void initState() {
    _passwordVisible = false;
  }

  void _UsernameEditingComplete() {
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }
  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_password1FocusNode);
  }




  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn ?
      EmailSignInFormType.register : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }


  @override
  Widget build(BuildContext context) {

    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'SIGN IN'
        : 'SIGN UP';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? \n         Sign up'
        : 'Have an account? \n         Sign in';
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if(_formType == EmailSignInFormType.register)
                TextFormField(
                  style:TextStyle(color:Colors.teal),
                  cursorColor: Colors.teal,
                  key: ValueKey("UserName"),
                  validator: (value){
                    if (value.isEmpty){
                      return 'Enter your Name';
                    }
                    return null;
                  },
                  controller: _UsernameController,
                  focusNode: _UsernameFocusNode,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                    contentPadding: const EdgeInsets.all(8.0),
                    errorBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal,
                        width: 2.0,),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'UserName',
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),

                  ),
                  autocorrect: false,

                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: _UsernameEditingComplete,
                ),

              SizedBox(height: MediaQuery.of(context).size.height *0.030,),


              TextFormField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.teal,
                key: ValueKey("email"),
                validator: (value){
                  if (value.isEmpty || !value.contains('@')){
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black,fontSize: 13),
                  contentPadding: const EdgeInsets.all(8.0),
                  errorBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal,
                      width: 2.0,),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: 'Email ID',
                  errorStyle: TextStyle(
                    color:  Colors.red,
                  ),

                ),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,

                textInputAction: TextInputAction.next,
                onEditingComplete: _emailEditingComplete,
              ),


              SizedBox(height: MediaQuery.of(context).size.height*0.030,),

              TextFormField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.teal,

                key: ValueKey("password1"),
                validator: (value){
                  if (value.isEmpty || value.length<7){
                    return 'Please enter atleast 7 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  errorBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal,
                      width: 2.0,),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelStyle: TextStyle(color: Colors.teal,fontSize: 13),
                  contentPadding: const EdgeInsets.all(8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: 'Password',
                  errorStyle: TextStyle(
                    color:  Colors.red,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                controller: _passwordController,
                focusNode: _password1FocusNode,
                textInputAction: TextInputAction.done,

                onEditingComplete: _submit,
                obscureText: !_passwordVisible,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              FormSubmitButton(
                  text: primaryText,

                  onPressed:(){
                    if (_formkey.currentState.validate() == true) {
                      _submit();
                    }
                  }

              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),

              FlatButton(
                child: Text(secondaryText,style: TextStyle(color: Colors.teal),),
                onPressed: _toggleFormType,
              ),
            ],
          ),
        ),
      ),
    );

  }
}