part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

// Event to trigger the fetching of posts.
class FetchPosts extends PostsEvent {}
