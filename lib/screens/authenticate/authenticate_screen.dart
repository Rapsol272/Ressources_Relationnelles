  import 'package:flutter/material.dart';
  import 'package:flutter/painting.dart';
  import 'package:flutter_firebase/common/constants.dart';
  import 'package:flutter_firebase/common/loading.dart';
  import 'package:flutter_firebase/screens/pages/components/radioButton.dart';
  import 'package:flutter_firebase/services/authentication.dart';
  import 'package:intl/intl.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:select_form_field/select_form_field.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:sliver_header_delegate/sliver_header_delegate.dart';

  import 'package:flutter/cupertino.dart';

  import 'package:checkbox_grouped/checkbox_grouped.dart';

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
    final roleController = TextEditingController();
    bool showSignIn = true;
    bool changeT = true;





    @override
    void dispose() {
      nameController.dispose();
      prenomController.dispose();
      emailController.dispose();
      passwordController.dispose();
      roleController.dispose();
      super.dispose();
    }

    void change() {
      setState(() {
        roleController.text = 'Rédacteur';
        TextFormField(
          controller: roleController..text = 'Redacteur', 
          style: TextStyle(
            color: changeT ? greenMajor : Colors.grey
            ),
          enabled: false,
          decoration: textInputDecoration.copyWith(hintText: 'Role'),
          validator: (value) => value == null || value.isEmpty ? "Entrez votre role" : null,
        );
        changeT = !changeT;
      });
    }

    void toggleView() {
      setState(() {
        _formKey.currentState?.reset();
        error = '';
        emailController.text = '';
        nameController.text = '';
        prenomController.text = '';
        passwordController.text = '';
        roleController.text = '';
        showSignIn = !showSignIn;
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
                      SizedBox(height: 30.0),

                      !showSignIn ? 
                      GestureDetector(
                        onTap: () => change(),
                        child: Container(
                          child: TextFormField(
                        controller: roleController..text = changeT ?'lecteur' : 'Redacteur', 
                        style: TextStyle(
                          color: changeT ? greenMajor : Colors.grey
                          ),
                        enabled: false,
                        decoration: textInputDecoration.copyWith(hintText: 'Role'),
                        validator: (value) => value == null || value.isEmpty ? "Entrez votre role" : null,
                      ),
                        )
                      )
                       : Container(),
                      
                        
                      
                      
                      SizedBox(height: 30.0),

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
                                  var role = roleController.value.text;

                                  dynamic result = showSignIn
                                      ? await _auth.signInWithEmailAndPassword(
                                          email, password)

                                      : await _auth.registerWithEmailAndPassword(
                                          name, prenom, email, password, role);

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


