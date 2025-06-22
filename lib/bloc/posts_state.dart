part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

// Initial state before any action is taken.
class PostsInitial extends PostsState {}

// State when posts are being loaded.
class PostsLoadInProgress extends PostsState {}

// State when posts are successfully loaded.
class PostsLoadSuccess extends PostsState {
  final List<Post> posts;

  const PostsLoadSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

// State when an error occurs during loading.
class PostsLoadFailure extends PostsState {
  final String error;

  const PostsLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
