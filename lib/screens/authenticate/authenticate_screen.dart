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


  int _activeStepIndex = 0;
  TextEditingController bio = TextEditingController();
  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Informations Personnelles'),
          content: Container(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Votre nom')
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: prenomController,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Votre Prénom')
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: emailController,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Votre adresse mail')
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(children: <Widget>[
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
                                ]),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Votre mot de passe')
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Confirmez votre mot de passe')
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Mon Compte'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: bio,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Biographie',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pin Code',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirmation d\'inscription'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Nom : ${nameController.text}'),
                Text('Prénom : ${prenomController.text}'),
                Text('Date de naissance : ${dateController.text}'),
                Text('Adresse mail : ${emailController.text}'),
                Text('Biograhie : ${bio.text}'),
              ],
            )))
      ];


  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
                backgroundColor: greenMajor,
                body: SingleChildScrollView(
                  child:
                  Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff03989E ), Color(0xffF9E79F)])),
      child: Column(
                      children: [
                  Container(
                    child: Image.asset(
                      'images/ressources_relationnelles_transparent.png',
                      height: 300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          showSignIn ? 
                          TextFormField(
                            controller: emailController,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Votre adresse email'),
                            validator: (value) => value == null || value.isEmpty
                                ? "Entrez votre adresse email"
                                : null,
                          ) : Container(),
                          const SizedBox(height: 20,),
                          showSignIn ?
                          TextFormField(
                            controller: passwordController,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Votre mot de passe'),
                            obscureText: true,
                            validator: (value) => value != null &&
                                    value.length < 6
                                ? "Entrez un mot de passe d'au moins 6 caractères"
                                : null,
                          ) : Container(),
                          SizedBox(height: 10.0),
                          !showSignIn ? 
                          Stepper(
                            type: StepperType.vertical,
                            currentStep: _activeStepIndex,
                            steps: stepList(),
                            onStepContinue: () {
                              if (_activeStepIndex < (stepList().length - 1)) {
                                setState(() {
                                  _activeStepIndex += 1;
                                });
                              } else {
                                var password = passwordController.value.text;
                                var email = emailController.value.text;
                                var date = dateController.value.text;
                                var name = nameController.value.text;
                                var prenom = prenomController.value.text;
                                _auth.registerWithEmailAndPassword(password, email, prenom, name, date );
                              }
                            },
                            onStepCancel: () {
                              if (_activeStepIndex == 0) {
                                return;
                              }
                              setState(() {
                                _activeStepIndex -= 1;
                              });
                            },
                            onStepTapped: (int index) {
                              setState(() {
                                _activeStepIndex = index;
                              });
                            },
                            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                              final isLastStep = _activeStepIndex == stepList().length - 1;
                              return Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: onStepContinue,
                                        child: (isLastStep)
                                            ? const Text('S\'inscrire')
                                            : const Text('Suivant'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    if (_activeStepIndex > 0)
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: onStepCancel,
                                          child: 
                                            const Text('Retour'),
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          ) : Container(),
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
                              "Se connecter",
                            ),
                            onPressed: () async {
                              if (_formKey.currentState?.validate() == true) {
                                setState(() => loading = true);
                                var password = passwordController.value.text;
                                var email = emailController.value.text;

                                     await _auth.signInWithEmailAndPassword(
                                        email, password); 
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


