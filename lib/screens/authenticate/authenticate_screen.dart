import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
  import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
  import 'package:flutter_firebase/common/constants.dart';
  import 'package:flutter_firebase/common/loading.dart';
  import 'package:flutter_firebase/services/authentication.dart';
  import 'package:flutter/cupertino.dart';
  import 'dart:io';
  import 'package:image_picker/image_picker.dart';
  import 'package:file_picker/file_picker.dart';
  import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';


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
    bool obscureText = false;

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
  }SingingCharacter? _character = SingingCharacter.lecteur;

  final ImagePicker _picker = ImagePicker();

  XFile? profilImage;
  
  

  var storage = FirebaseStorage.instance;

    @override

  
   @override
    Widget build(BuildContext context) {

      var hasWidthPage = MediaQuery.of(context).size.width;

      var _path;
      var _fileName;
      final Storage storage = Storage();

      return loading
          ? Loading()
          : 
          SingleChildScrollView(
                    child:
                      Column(
                        children: [
                    hasWidthPage > 600 ?  ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(hasWidthPage * 0.1),
                              child: Image.asset('images/ressources_relationnelles.png', fit: BoxFit.cover),
                            ),
                          ) : Container(),
                    Text(showSignIn ? 'Se connecter' : 'S\'inscrire',  style: TextStyle(color: greenMajor, fontSize: 25, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: hasWidthPage < 600 ? EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0)
                      :EdgeInsets.symmetric(vertical: 0.0, horizontal: 400.0),
                      child: Form(
                  key: _formKey,
                  child: Container(
                    margin: hasWidthPage > 600 ? EdgeInsets.only(bottom: 50, top: 10) : EdgeInsets.symmetric(),
                    padding: hasWidthPage > 600 ? EdgeInsets.symmetric(vertical: 00, horizontal: 20) : EdgeInsets.symmetric(),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: hasWidthPage > 600 ? Colors.grey[100] : Colors.transparent,
                      ),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: textInputDecoration.copyWith(hintText: 'Votre adresse email',),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      
                      !showSignIn ? SizedBox(height: 30,) : Container(),

                     !showSignIn ?
                      Center(
                        child: _path == null
                            ? Container()
                            : Image.asset(
                                'images/film.jpeg',
                                fit: BoxFit.cover,
                                width: hasWidthPage * 0.3
                              ),
                      ) : Container(),

                      !showSignIn ? SizedBox(height: 30,) : Container(),

                      !showSignIn ? 
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: greenMajor,
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: greenMajor, width: 1),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () async {
                          final results = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['png', 'jpg'],
                          );

                          if (results == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No file'),
                              ),
                            );
                            return null;
                          }

                          final path = results.files.single.path!;
                          _path = path;
                          final fileName = results.files.single.name;
                          _fileName = fileName;
                          setState(() {});
                        }, 
                        child: Text('Ajouter une image'))
                      : Container(),

                      

                      !showSignIn ? SizedBox(height: 30,) : Container(),

                      !showSignIn ?
                      TextFormField(
                        controller: bioController,
                        maxLines: 4,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        decoration: textOutlineDecoration.copyWith(hintText: 'Votre Biographie') 
                            
                      )
                       :Container(),
                       
                       !showSignIn ? SizedBox(height: 30,) : Container(),

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
                            var modo = false;
                            var admin = false;

                            dynamic result = showSignIn
                                ? await _auth.signInWithEmailAndPassword(
                                    email, password)
                                : await _auth.registerWithEmailAndPassword(
                                    name, prenom, email, password, role, bio, modo, admin);

                                  if (result == null) {
                                    setState(() {
                                      loading = false;
                                      error = "Il y une erreur dans votre inscription";
                                    });
                                  }
                                }
                              },
                              ),
                              SizedBox(height: 10,),
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
                  )
                      ),
                    ),
        ],
      )
                    );
          
    }
    
  }
