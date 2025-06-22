import 'package:equatable/equatable.dart';

// Using Equatable to simplify value comparisons in BLoC and tests.
class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  // Factory constructor to create a Post from a JSON map.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  @override
  List<Object?> get props => [id, title, body];
}
