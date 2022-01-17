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

  import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
  import 'package:flutter/cupertino.dart';

  enum SingingCharacter { lafayette, jefferson }
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
    bool showSignIn = true;




    final format = DateFormat("yyyy-MM-dd");
    DateTime? value;


    @override
    void dispose() {
      nameController.dispose();
      prenomController.dispose();
      emailController.dispose();
      passwordController.dispose();
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
        //roleController.text = '';
        showSignIn = !showSignIn;
      });
    }

    bool majorCheck = false;

    static final Map<String, String> genderMap = {
    'lecteur': 'Lecteur',
    'redacteur': 'Rédacteur',
  };

  String _selectedGender = genderMap.keys.first;

  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }
  SingingCharacter? _character = SingingCharacter.lafayette;

    @override
    Widget build(BuildContext context) {

      //Color for checkbox
      Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return greenMajor;
      }
      return greenMajor;
    }

    

      return loading
          ? Loading()
          : SingleChildScrollView(
                    child: 
                      Column(
                        children: [
                    Text(showSignIn ? 'Se connecter' : 'S\'inscrire',  style: TextStyle(color: greenMajor, fontSize: 25, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
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

                      !showSignIn ? 
                      SizedBox(height: 20.0) : Container(),
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
                      SizedBox(height: 20.0),
                      
                      !showSignIn ?
                        Row(
                          children: [
                            Container(
                              child:
                              Row(
                                children: [
                                  Text('Lecteur'),
                                  Radio<SingingCharacter>(
                                    activeColor: greenMajor,
                                    value: SingingCharacter.lafayette,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                        print(value);
                                      }
                                     );
                                    },
                                  ) ,
                                ],
                              )
                              ),
                              Container(
                              child:
                              Row(
                                children: [
                                  Text('Rédacteur'),
                                  Radio<SingingCharacter>(
                                    value: SingingCharacter.jefferson,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                        print(value);
                                      }
                                     );
                                    },
                                  ) ,
                                ],
                              )
                              )
                  
                          ],
                        )
                     /*Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text('Sélectionnez votre rôle :',
                            style: TextStyle(
                              color: greenMajor,
                              fontSize: 15.0,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                        ),
                        CupertinoRadioChoice(
                          selectedColor: greenMajor,
                            choices: genderMap,
                            onChange: onGenderSelected,
                            initialKeyValue: _selectedGender)
                      ],
                    )*/
                     : Container(),
                      /*Row(
                        children: [
                          Text('Cochez la case si vous êtes majeur :'),
                          Checkbox(
                            value: majorCheck, 
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            onChanged: (bool? value) {
                              print(value);
                              setState(() {
                                   majorCheck = value!;
                                   });
                            }
                            ),
                        ],
                      ) : Container(),*/

                      Center(child: 
                      GestureDetector(
                        onTap: () => toggleView(), 
                        child: Text(showSignIn ? 'Créer un compte ?' : 'Déjà un compte ? Connectez vous !', 
                        style: TextStyle(
                          color: greenMajor
                        )
                        ,))),
                        SizedBox(height: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                              primary: greenMajor,
                              onPrimary: Colors.white,
                              shadowColor: or,
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

                                  dynamic result = showSignIn
                                      ? await _auth.signInWithEmailAndPassword(
                                          email, password)

                                      : await _auth.registerWithEmailAndPassword(
                                          name, prenom, email, password);

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
        ],
      )
                    );
    }
  }


