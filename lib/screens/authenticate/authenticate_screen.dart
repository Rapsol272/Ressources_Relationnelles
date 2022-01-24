  import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
  import 'package:flutter/painting.dart';
  import 'package:flutter_firebase/common/constants.dart';
  import 'package:flutter_firebase/common/loading.dart';
  import 'package:flutter_firebase/services/authentication.dart';
  import 'package:intl/intl.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:select_form_field/select_form_field.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:sliver_header_delegate/sliver_header_delegate.dart';

  import 'package:flutter/cupertino.dart';
  import 'dart:io';
  import 'package:image_picker/image_picker.dart';
  import 'package:firebase_storage/firebase_storage.dart';

  enum SingingCharacter { lecteur, redacteur }
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
    final bioController = TextEditingController();
    
    bool showSignIn = true;
    bool changeT = true;
    bool obscureText = true;


    @override
    void dispose() {
      nameController.dispose();
      prenomController.dispose();
      emailController.dispose();
      passwordController.dispose();
      roleController.dispose();
      bioController.dispose();
      super.dispose();
    }

    void change() {
      setState(() {
        roleController.text = 'Rédacteur';
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
        bioController.text = '';
        showSignIn = !showSignIn;
      });
    }

  SingingCharacter? _character = SingingCharacter.lecteur;

  final ImagePicker _picker = ImagePicker();

  XFile? profilImage;

void filePicker() async {
    final XFile? selectImage = await _picker.pickImage(source:ImageSource.camera);

    FirebaseStorage fs = FirebaseStorage.instance;
    Reference rootReference = fs.ref();
    Reference pictureFolderRef = rootReference.child("pictures").child("image");

    /*pictureFolderRef.putFile(profilImage).onComplete.then((storageTask) async{
      String link = await storageTask.ref.getDownloadURL();
      setState(() {

      });
    });
    setState(() {
      profilImage = selectImage;
    });*/
  }
  
  

  var storage = FirebaseStorage.instance;

    @override
    Widget build(BuildContext context) {
      String imageLink;
      File _image;
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
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Votre mot de passe',
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                              color: greenMajor,
                              ),
                            onPressed: () {
                              setState(() {
                                  obscureText = !obscureText;
                              });
                            },
                            ),),
                        obscureText: !obscureText,
                        validator: (value) => value != null && value.length < 6
                            ? "Entrez un mot de passe d'au moins 6 caractères"
                            : null,
                      ),
                      SizedBox(height: 20.0),

                      !showSignIn ? 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Votre rôle est :', style: TextStyle(
                            fontSize: 15
                          ),),
                           GestureDetector(
                        onTap: () => change(),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                        controller: roleController..text = changeT ? 'Lecteur' : 'Rédacteur', 
                        style: TextStyle(
                          color: greenMajor
                          ),
                        enabled: false,
                        decoration: textInputDecoration.copyWith(
                          prefixIcon: Icon(
                                Icons.swap_vert,
                                color: greenMajor
                      ),),
                        ),
                      ),
                        ],
                      )
                       : Container(),
                      
                      SizedBox(height: 30.0),

                     !showSignIn ?
                      Center(
                        child: profilImage == null ? 
                        Text('Pas d\'image de profil sélectionnée !')
                        : ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(48),
                              child: Image.file(File(profilImage!.path), fit: BoxFit.cover),
                            ),
                          )) :Container(),

                          SizedBox(height: 30,),

                      !showSignIn ? 
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: greenMajor,
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: greenMajor, width: 1),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {filePicker();}, 
                        child: Text('Ajouter une image'))
                      : Container(),

                      

                      SizedBox(height:20),

                      !showSignIn ?
                      TextFormField(
                        controller: bioController,
                        maxLines: 4,
                        decoration: textOutlineDecoration.copyWith(hintText: 'Votre Biographie') 
                            
                      )
                       :Container(),
                       SizedBox(height: 30,),

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
                                  var bio = bioController.value.text;

                                  dynamic result = showSignIn
                                      ? await _auth.signInWithEmailAndPassword(
                                          email, password)

                                      : await _auth.registerWithEmailAndPassword(
                                          name, prenom, email, password, role, bio);

                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = "Il y une erreur dans votre inscription";
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


