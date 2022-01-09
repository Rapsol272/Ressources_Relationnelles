import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_firebase/screens/pages/postHelper.dart';
import 'package:flutter_firebase/screens/pages/postItem.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class PoubellePage extends StatelessWidget {
  const PoubellePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new cards(),
    );
  }
}

class cards extends StatefulWidget {
  cards({Key? key}) : super(key: key);

  @override
  _cardsState createState() => _cardsState();
}

class _cardsState extends State<cards> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              PostItemModel posts = PostHelper.getPost(index);
              return Container(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 15,
                  margin: EdgeInsets.all(5),
                  shadowColor: Color(0xff03989E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.portrait, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Color(0xff03989E), // <-- Button color
                            onPrimary: Colors.red, // <-- Splash color
                          ),
                        ),
                        title: Text(
                          posts.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          posts.toString(),
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Image.asset(posts.image),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ExpansionTile(
                          title: Text(
                            posts.content,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              margin: const EdgeInsets.all(10),
                              child: Text(posts.content),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.comment),
                            color: Colors.grey,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.retweet,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.plusSquare,
                              color: Colors.grey,
                            ),
                          ),
                          FavoriteButton(
                            iconSize: 50,
                            iconColor: Colors.red,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite $_isFavorite)');
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
