import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:search_app_bar_page/search_app_bar_page.dart';

class ConfirmationInscription extends StatefulWidget {
  ConfirmationInscription({Key? key}) : super(key: key);

  @override
  _ConfirmationInscriptionState createState() => _ConfirmationInscriptionState();
}

class _ConfirmationInscriptionState extends State<ConfirmationInscription> {
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
            children: [
              Text('Presentez-vous en quelques mots !'),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(height: 30,),

              Text('Vos premiers groupes !'),

              SizedBox(height: 20,),

              
                  ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Container(
                child: Text('Amis', textAlign: TextAlign.center,),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: true,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Ajoutez vos premiers amis !",
                    )),
                collapsed: Text(
                  'Recherchez vos amis ici !',
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(5))
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'fjezifiezhfezhfhezifhezfiuezhfuhezfuiezhfiezfezhfiueheziuhfiuezhfuiezhfiezhfiooiheziofheziofhiezhfiezhfiezhfioezhfizehfihezfiezhfiuhezoifhezoifhoiezhfioezhfoiezhfoiezhfoiezhfoiezhfoizfhoize',
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),),),
                  

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
                child:


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
      ),);
                });
                },
                child: Container(
                width: double.infinity,
                height: 100,
                decoration :BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                    ),
                child: Row(children: [
                  Text('Famille'),
                 
                ],),
              ),
              ),

              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {},
                child: Container(
                width: double.infinity,
                height: 100,
                decoration :BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.yellow,
                    ),
                child: Row(children: [
                  Text('Collègues')
                ],),
              ),
              )
            ],
          ),
        ),
        )
        ),
    );
  }
}
