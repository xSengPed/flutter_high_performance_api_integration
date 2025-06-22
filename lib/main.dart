

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolation_test/ui/post_page.dart';
import 'package:isolation_test/repository/post_repository.dart';

import 'bloc/posts_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the repository and BLoC to the widget tree.
    return MaterialApp(
      title: 'High-Performance Fetch',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PostsBloc(
          // Inject the repository implementation.
          postRepository: PostRepositoryImpl(dio: Dio()),
        )..add(FetchPosts()), // Trigger the initial fetch event.
        child: const PostsPage(),
      ),
    );
  }
}
