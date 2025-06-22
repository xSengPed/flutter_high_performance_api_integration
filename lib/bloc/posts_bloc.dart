

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post.dart';
import '../repository/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;

  PostsBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostsInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoadInProgress());
    try {
      final posts = await _postRepository.fetchPosts();
      emit(PostsLoadSuccess(posts));
    } catch (e) {
      emit(PostsLoadFailure(e.toString()));
    }
  }
}
