import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/authenticate/scrollAuth.dart';
import 'package:flutter_firebase/screens/pages/components/radioButton.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

 
class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final prenomController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateController = TextEditingController();
  //final roleController = TextEditingController();
  bool showSignIn = true;




  final format = DateFormat("yyyy-MM-dd");
  DateTime? value;


  @override
  void dispose() {
    nameController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dateController.dispose();
    //roleController.dispose();
    super.dispose();
  }

  

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      nameController.text = '';
      prenomController.text = '';
      passwordController.text = '';
      dateController.text = '';
      //roleController.text = '';
      showSignIn = !showSignIn;
    });
  }

  TextEditingController? _controller;
  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'redacValue',
      'label': 'Rédacteur',
      'icon': Icon(Icons.pending_actions),
    },
    {
      'value': 'lecteurValue',
      'label': 'Lecteur',
      'icon': Icon(Icons.book),
    },
  ];

  @override
  void initState() {
    super.initState();

    //_initialValue = 'starValue';
    _controller = TextEditingController(text: '2');

    _getValue();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setStateIfMounted(() {
        //_initialValue = 'circleValue';
        _controller?.text = 'lecteurValue';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(

                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff03989E), Color(0xffF9E79F)])),

            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    child: Image.asset(
                      'images/ressources_relationnelles_transparent.png',
                      height: 300,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20,),
                    !showSignIn
                        ? TextFormField(
                            controller: nameController,
                            decoration: textInputDecoration.copyWith(hintText: 'Votre nom'),
                            validator: (value) =>
                                value == null || value.isEmpty ? "Entrez votre nom" : null,
                          )
                        : Container(),
                        SizedBox(height: 20,),
                        !showSignIn
                        ? TextFormField(
                            controller: prenomController,
                            decoration: textInputDecoration.copyWith(hintText: 'Votre prénom'),
                            validator: (value) =>
                                value == null || value.isEmpty ? "Entrez votre prénom" : null,
                          )
                        : Container(),
                        SizedBox(height: 20,),

                    !showSignIn ? SizedBox(height: 20.0) : Container(),
                    TextFormField(
                      controller: emailController,
                      decoration: textInputDecoration.copyWith(hintText: 'Votre adresse email'),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Entrez votre adresse email" : null,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: textInputDecoration.copyWith(hintText: 'Votre mot de passe'),
                      obscureText: true,
                      validator: (value) => value != null && value.length < 6
                          ? "Entrez un mot de passe d'au moins 6 caractères"
                          : null,
                    ),
                    SizedBox(height: 20.0),
                    !showSignIn ?
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: textInputDecoration.copyWith(hintText: 'Confirmez mot de passe'),
                      obscureText: true,
                      validator: (value) => value == passwordController.text
                          ? null
                          : "Les mots de passes ne se correspondent pas !",
                    ):  Container(),
                    SizedBox(height: 10.0),
                    Center(child: 
                    GestureDetector(
                      onTap: () => toggleView(), 
                      child: Text(showSignIn ? 'Créer un compte ?' : 'Déjà un compte ? Connectez vous !', 
                      style: TextStyle(
                        color: Colors.green
                      )
                      ,))),
                      SizedBox(height: 20,),
                    ElevatedButton(
                       style: ElevatedButton.styleFrom(
                            primary: Color(0xff148F77),
                            onPrimary: Colors.white,
                            shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            minimumSize: Size(200, 40),
                        ),
                      child: Text(
                        showSignIn? "Se connecter" : "S\'inscrire",
                      ),
                      onPressed: () async {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() => loading = true);
                                var password = passwordController.value.text;
                                var email = emailController.value.text;
                                var name = nameController.value.text;
                                var prenom = prenomController.value.text;
                                var date = dateController.value.text;

                                dynamic result = showSignIn
                                    ? await _auth.signInWithEmailAndPassword(
                                        email, password)

                                    : await _auth.registerWithEmailAndPassword(
                                        name, prenom, date, email, password);

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Please supply a valid email';
                                  });
                                }
                              }
                            },
                            ),
                          showSignIn
                              ? OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: greenMajor, width: 2),
                                    primary: greenMajor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    dynamic result =
                                        await _auth.signInAnonymously();
                                  },
                                  child: Text('Se connecter en Anonyme'))
                              : Container(),
                          SizedBox(height: 10.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ]));
  }
}


