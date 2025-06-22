// To generate mocks, run:
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isolation_test/bloc/posts_bloc.dart';
import 'package:isolation_test/models/post.dart';
import 'package:isolation_test/repository/post_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'posts_test.mocks.dart';



// Annotation to generate a mock class for PostRepository.
@GenerateMocks([PostRepository])
void main() {
  // Use late to initialize variables in setUp
  late MockPostRepository mockPostRepository;
  late PostsBloc postsBloc;

  // Mock data for testing
  final tPosts = [
    const Post(id: 1, title: 'Test Title 1', body: 'Test Body 1'),
    const Post(id: 2, title: 'Test Title 2', body: 'Test Body 2'),
  ];

  setUp(() {
    mockPostRepository = MockPostRepository();
    postsBloc = PostsBloc(postRepository: mockPostRepository);
  });

  tearDown(() {
    postsBloc.close();
  });

  group('PostsBloc', () {
    test('initial state should be PostsInitial', () {
      expect(postsBloc.state, PostsInitial());
    });

    blocTest<PostsBloc, PostsState>(
      'emits [PostsLoadInProgress, PostsLoadSuccess] when FetchPosts is added and repository call is successful.',
      build: () {
        // Stub the repository method to return a successful result.
        when(mockPostRepository.fetchPosts()).thenAnswer((_) async => tPosts);
        return postsBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => <PostsState>[
        PostsLoadInProgress(),
        PostsLoadSuccess(tPosts),
      ],
      verify: (_) {
        // Verify that the fetchPosts method was called exactly once.
        verify(mockPostRepository.fetchPosts()).called(1);
      },
    );

    blocTest<PostsBloc, PostsState>(
      'emits [PostsLoadInProgress, PostsLoadFailure] when FetchPosts is added and repository throws an error.',
      build: () {
        // Stub the repository method to throw an exception.
        when(mockPostRepository.fetchPosts()).thenThrow(Exception('API Error'));
        return postsBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => <PostsState>[
        PostsLoadInProgress(),
        const PostsLoadFailure('Exception: API Error'),
      ],
      verify: (_) {
        verify(mockPostRepository.fetchPosts()).called(1);
      },
    );
  });
}
