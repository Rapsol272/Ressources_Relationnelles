import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategSection extends StatefulWidget {
  CategSection({Key? key}) : super(key: key);

  @override
  _CategSectionState createState() => _CategSectionState();
}

class _CategSectionState extends State<CategSection> {
  final List categoSect = [];
  var boxColor = Colors.white;

  // Récupère l'ensemble des catégories dans la collection catégorie
  getCategFirestore() async {
    categoSect.clear();
    await FirebaseFirestore.instance.collection('categorie').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {categoSect.add(doc.id)},
            ),
          },
        );
  }

  // Construit la barre de sélection des catégories
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategFirestore(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.all(7),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: greenMajor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  spreadRadius: 1.5,
                  blurRadius: 7,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categoSect.map((element) {
                      var index = categoSect.indexOf(element);
                      return Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        child: Column(
                          children: [
                            Ink(
                              child: InkWell(
                                child: Container(
                                  width: 65,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: boxColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                        offset: Offset(
                                          0,
                                          1,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: IconButton(
                                    onPressed: () {
                                      boxColor = greenMajor;
                                    },
                                    // Renvoie la bonne image en fonction de la categorie
                                    icon: getImage(categoSect[index]),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                categoSect[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Afficher la bonne image sur le bouton associé
Image getImage(String categorieName) {
  if (categorieName == 'Code')
    return Image.asset('images/code.png');
  else if (categorieName == 'Gastronomie')
    return Image.asset('images/gastronomie.jpeg');
  else if (categorieName == 'Sciences')
    return Image.asset('images/sciences.jpeg');
  else if (categorieName == 'Gaming')
    return Image.asset('images/gaming.jpeg');
  else if (categorieName == 'Sport')
    return Image.asset('images/sport.png');
  else if (categorieName == 'Film')
    return Image.asset('images/film.jpeg');
  else if (categorieName == 'Technologies')
    return Image.asset('images/robot.png');
  else
    return Image.asset('images/pokemon.png');
}
