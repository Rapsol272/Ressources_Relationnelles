import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/authenticate/confirmation.dart';
import 'package:flutter_firebase/screens/pages/components/radioButton.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:select_form_field/select_form_field.dart';


enum BestTutorSite { javatpoint, w3schools, tutorialandexample } 
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

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [greenMajor, or])),
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
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          !showSignIn
                              ? TextFormField(
                                  controller: nameController,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Votre nom'),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? "Entrez votre nom"
                                          : null,
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          !showSignIn
                              ? TextFormField(
                                  controller: prenomController,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Votre prénom'),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? "Entrez votre prénom"
                                          : null,
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          !showSignIn
                              ? Column(children: <Widget>[
                                  DateTimeField(
                                    controller: dateController,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Votre date de naissance'),
                                    format: format,
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate:
                                              currentValue ?? DateTime(2000),
                                          lastDate: DateTime.now());
                                    },
                                  ),
                                ])
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          !showSignIn
                              ? Column(
                                  children: <Widget>[
                                    SelectFormField(
                                      decoration: textInputDecoration,
                                      type: SelectFormFieldType.dialog,
                                      controller: _controller,
                                      icon: Icon(Icons.collections_bookmark),
                                      labelText: 'Choisir votre rôle',
                                      changeIcon: true,
                                      dialogTitle: 'Choisissez votre rôle',
                                      dialogCancelBtn: 'Fermer',
                                      items: _items,
                                      onChanged: (val) =>
                                          setState(() => _valueChanged = val),
                                      validator: (val) {
                                        setState(
                                            () => _valueToValidate = val ?? '');
                                        return null;
                                      },
                                      onSaved: (val) => setState(
                                          () => _valueSaved = val ?? ''),
                                    ),
                                  ],
                                )
                              : Container(),
                          !showSignIn ? SizedBox(height: 20.0) : Container(),
                          TextFormField(
                            controller: emailController,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Votre adresse email'),
                            validator: (value) => value == null || value.isEmpty
                                ? "Entrez votre adresse email"
                                : null,
                          ),
                          /*!showSignIn ? 
                          Row(
                            children: [
                                Container(
                              child: CustomRadioButton('test1', 1)
                            ),
                            Container(
                            child: CustomRadioButton('test2', 2)
                          )
                            ],
                          )
                           : Container(),*/

  
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: passwordController,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Votre mot de passe'),
                            obscureText: true,
                            validator: (value) => value != null &&
                                    value.length < 6
                                ? "Entrez un mot de passe d'au moins 6 caractères"
                                : null,
                          ),
                          SizedBox(height: 20.0),
                          !showSignIn
                              ? TextFormField(
                                  controller: confirmPasswordController,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Confirmez mot de passe'),
                                  obscureText: true,
                                  validator: (value) => value ==
                                          passwordController.text
                                      ? null
                                      : "Les mots de passes ne se correspondent pas !",
                                )
                              : Container(),
                          SizedBox(height: 10.0),
                          Center(
                              child: GestureDetector(
                                  onTap: () => toggleView(),
                                  child: Text(
                                    showSignIn
                                        ? 'Créer un compte ?'
                                        : 'Déjà un compte ? Connectez vous !',
                                    style: TextStyle(color: greenMajor),
                                  ))),
                          SizedBox(
                            height: 10,
                          ),
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
                              showSignIn ? "Se connecter" : "Suivant",
                            ),
                            onPressed: () async {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() => loading = true);
                                var password = passwordController.value.text;
                                var email = emailController.value.text;
                                var name = nameController.value.text;
                                var prenom = prenomController.value.text;
                                var date = dateController.value.text;
                                //var role = roleController.value.text;
                                //var bio = bioController.value.text;

                                dynamic result = showSignIn
                                    ? await _auth.signInWithEmailAndPassword(
                                        email, password)
                                    : //Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmationInscription()),);
                                    await _auth.registerWithEmailAndPassword(name, prenom, date, email, password);
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
                ]))));
  }
}


