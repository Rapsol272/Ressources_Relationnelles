class PostItemModel {
  String title = '';
  List tags = [];
  String content = '';
  String image = '';
  String author = '';
  String date = '';

  PostItemModel(
      this.title, this.tags, this.content, this.image, this.author, this.date);

  @override
  String toTags() {
    String msg = '';
    for (var i = 0; i < tags.length; i++) {
      msg += this.tags[i] + ", ";
    }
    return msg;
  }
}
