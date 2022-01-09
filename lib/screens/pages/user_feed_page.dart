import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/pages/groupes.dart';
import 'package:flutter_firebase/screens/pages/poubelle.dart';
import 'package:flutter_firebase/screens/pages/tweetHelper.dart';
import 'package:flutter_firebase/screens/pages/tweetItemModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserFeedPage extends StatefulWidget {
  @override
  _UserFeedPageState createState() => _UserFeedPageState();
}

class _UserFeedPageState extends State<UserFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading:
            Icon(Icons.account_circle_rounded, color: Colors.grey, size: 35.0),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, position) {
          TweetItemModel tweet = tweetHelper.getTweet(position);
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.account_circle,
                          color: Colors.black, size: 30.0),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: RichText(
                                      maxLines: 1,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: tweet.username,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "" + tweet.twitterHandle,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${tweet.time}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  flex: 5,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      height: 30.0,
                                      width: 30.0,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PoubellePage()));
                                        },
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.expand_more),
                                      ),
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              tweet.tweet,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.comment,
                                    color: Colors.grey),
                                Icon(FontAwesomeIcons.retweet,
                                    color: Colors.grey),
                                Icon(FontAwesomeIcons.shareAlt,
                                    color: Colors.grey),
                                Icon(FontAwesomeIcons.heart,
                                    color: Colors.grey),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        hoverElevation: 20,
        child: Icon(FontAwesomeIcons.featherAlt),
      ),
    );
  }
}
