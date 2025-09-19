class Book {
  final String title;
  final int downloadCount;

  Book({
    required this.title, 
    required this.downloadCount});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      downloadCount: json['download_count'] as int
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': title,
  //     'author': author,
  //     'languages': languages,
  //     'download_count': downloadCount
  //   };
  // }

}
