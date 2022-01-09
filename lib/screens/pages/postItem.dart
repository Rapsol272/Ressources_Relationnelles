class PostItemModel {
  String title = '';
  List tags = [];
  String content = '';
  String image = '';

  PostItemModel(this.title, this.tags, this.content, this.image);

  @override
  String toString() {
    String msg = '';
    for (var i = 0; i < tags.length; i++) {
      msg += this.tags[i] + ", ";
    }
    return msg;
  }
}
