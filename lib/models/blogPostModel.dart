class BlogPost {
  final int id;
  final String title;
  final String content;
  final String photoUrl;
  final String createdAt;
  final String description;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.photoUrl,
    required this.createdAt,
    required this.description,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content_text'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
