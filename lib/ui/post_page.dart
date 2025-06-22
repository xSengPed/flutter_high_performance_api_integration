

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolation_test/models/post.dart';

import '../bloc/posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts from Isolate'),
      ),
      body: Center(
        // BlocBuilder handles rebuilding the UI in response to state changes.
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoadInProgress) {
              return const CircularProgressIndicator();
            } else if (state is PostsLoadSuccess) {
              return PostsList(posts: state.posts);
            } else if (state is PostsLoadFailure) {
              return Text(
                'Failed to load posts:\n${state.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              );
            }
            // Initial state
            return const Text('Press a button to fetch posts.');
          },
        ),
      ),
    );
  }
}

class PostsList extends StatelessWidget {
  final List<Post> posts;

  const PostsList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    // ListView.builder is highly performant for long lists.
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        // Using RepaintBoundary to isolate each list item's paint area.
        // This prevents other items from repainting if one item changes.
        // It's especially useful for complex list items with their own animations
        // or frequent updates, ensuring the rest of the list remains static.
        return RepaintBoundary(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(child: Text(post.id.toString())),
              title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(post.body),
              ),
              isThreeLine: true,
            ),
          ),
        );
      },
    );
  }
}
