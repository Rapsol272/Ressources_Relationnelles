import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';

class FavoriteSection extends StatelessWidget {
  FavoriteSection({Key? key}) : super(key: key);
  final List favoriteContact = [
    {
      "name": "Famille",
    },
    {
      "name": "Potes",
    },
    {
      "name": "LesBests",
    },
    {
      "name": "EquipeFoot",
    },
    {
      "name": "LesCracks2022",
    },
    {
      "name": "ClubLecture",
    },
  ];

  var boxColor = Colors.white;

  @override
  Widget build(BuildContext context) {
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
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: favoriteContact.map((favorite) {
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
                              width: 75,
                              height: 70,
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
                                icon: Image.asset('images/pokemon.png'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            favorite['name'],
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
  }
}




/* Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 35,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 1.5,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  )
                ],
              ),
            ), */
