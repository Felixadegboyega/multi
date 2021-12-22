class Quote {
  String? author;
  String text;

  Quote({required this.author, required this.text});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(author: json['author'], text: json['text']);
  }
}
