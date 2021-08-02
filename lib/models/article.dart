class Article {
  String? title;
  String? pubDate;
  String? link;
  String? guid;
  String? author;
  String? thumbnail;
  String? description;
  String? content;
  Map? enclosure;
  List? categories;

  Article(
      {  this.title,
        this.pubDate,
        this.link,
        this.guid,
        this.author,
        this.thumbnail,
        this.description,
        this.content,
        this.enclosure,
        this.categories});
}

// class Enclosure {
//   Enclosure();
// }
