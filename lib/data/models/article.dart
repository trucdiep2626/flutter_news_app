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
      {this.title,
      this.pubDate,
      this.link,
      this.guid,
      this.author,
      this.thumbnail,
      this.description,
      this.content,
      this.enclosure,
      this.categories});

  factory Article.fromJson(Map<String,dynamic> json)
  => Article(
    title: json['title'],
    guid: json['guid'],
    categories: json['categories']??null,
    author: json['author'],
    description: json['description'],
    link: json['link'],
    pubDate: DateTime.parse(json['pubDate']).toString(),
    content: json['content'],
    enclosure: json['enclosure']??null,
    thumbnail: json['thumbnail'],
  );
}


