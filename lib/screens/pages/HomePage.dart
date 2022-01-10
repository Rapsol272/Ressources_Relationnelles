import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class MyHomePage extends StatefulWidget {
  final String? title = '';
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: Color(0xff03989E),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ExpansionTileCard(
              key: cardA,
              leading: CircleAvatar(child: Text('AB')),
              title: Text(
                'Adrien Berard',
                style: TextStyle(color: Color(0xff03989E)),
              ),
              subtitle: Text(
                'Documentation Flutter',
                style: TextStyle(color: Color(0xff03989E)),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      """An "expansion" on the Flutter SDK's standard ExpansionTile, to create a Google Material Theme inspired raised widget, ExpansionTileCard, instead.
It's more or less a drop-in replacement for ExpansionTile.""",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      style: flatButtonStyle,
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.favorite_border, color: Color(0xff03989E)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.comment_outlined,
                              color: Color(0xff03989E)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      onPressed: () {},
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.ios_share_outlined,
                            color: Color(0xff03989E),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
