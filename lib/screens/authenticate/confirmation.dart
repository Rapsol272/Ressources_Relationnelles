import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_firebase/common/constants.dart';

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class ConfirmationInscription extends StatefulWidget {
  ConfirmationInscription({Key? key}) : super(key: key);

  @override
  _ConfirmationInscriptionState createState() => _ConfirmationInscriptionState();
}

class _ConfirmationInscriptionState extends State<ConfirmationInscription> {

  bool isReplay = false;

  

List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff03989E ), Color(0xffF9E79F)])),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Presentez-vous en quelques mots !'),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(height: 30,),

              Text('Vos premiers groupes !'),

              SizedBox(height: 20,),
  
               Container(
                width: double.infinity,
                height: 100,
                decoration :BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Amis'),
                ],),
              ),

              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Login'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    child: Text('Save'),
                                    onPressed: _saveForm,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(_myActivitiesResult),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                  });
                },
                child: Container(
                width: double.infinity,
                height: 100,
                decoration :BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Famille'),
                ],),
              ),
              ),

              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Login'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(16),
                                
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    child: Text('Save'),
                                    onPressed: _saveForm,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(_myActivitiesResult),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                  });
                },
                child: Container(
                width: double.infinity,
                height: 100,
                decoration :BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.yellow,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Collègues'),
                ],),
              ),
              ),
              SizedBox(height: 30,),

              ElevatedButton(
                onPressed: () {}, 
                child: Text('S\'inscrire'))
            ],
          ),
        ),
        )
        ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
