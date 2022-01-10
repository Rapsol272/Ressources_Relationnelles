import 'tweetItemModel.dart';

class tweetHelper {
  static var tweets = [
    TweetItemModel(
        "Devinez qui fait des blaques pourie... ta mère, et en plus elles ne sont m^me pas drôle, ahcaecaa,cafjeafed ad az df f ef  ",
        "loic ",
        "13:45",
        "@wsssh"),
    TweetItemModel(
        "Devinez qui fait des blaques pourie... ta mère, et en plus elles ne sont m^me pas drôle ",
        "cass ",
        "16:45",
        "@mastu"),
    TweetItemModel(
        "Devinez qui fait des blaques pourie... ta mère, et en plus elles ne sont m^me pas drôle ",
        "yann ",
        "18:45",
        "@tag")
  ];

  static TweetItemModel getTweet(int position) {
    return tweets[position];
  }
}
