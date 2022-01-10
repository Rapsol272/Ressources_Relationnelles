import 'postItem.dart';

class PostHelper {
  static var posts = [
    PostItemModel(
      "Le basket de nos jours",
      ["basket", "sport", "nba"],
      "Depuis que Michael Jordan ne joue à la NBA, les chicagos bulls sont revenus en force. La suite du texte je ne e la connais. On va dead ce putain de projet bande de bogoss.",
      "images/test1.jpeg",
    ),
    PostItemModel(
      "Le basket de nos jours",
      ["basket", "sport", "nba"],
      "Depuis que Michael Jordan ne joue à la NBA, les chicagos bulls sont revenus en force.",
      "images/test1.jpeg",
    ),
    PostItemModel(
      "Le basket de nos jours",
      ["basket", "sport", "nba"],
      "Depuis que Michael Jordan ne joue à la NBA, les chicagos bulls sont revenus en force.",
      "images/test1.jpeg",
    )
  ];

  static PostItemModel getPost(int position) {
    return posts[position];
  }
}
