import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:isolation_test/models/post.dart';
import 'package:lottie/lottie.dart';

import '../bloc/posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts from Isolate')),
      body: Column(
        children: [
          //
          ElevatedButton(
            onPressed: () async {
              EasyLoading.show();
              await Future.delayed(Duration(seconds: 5));
              EasyLoading.dismiss();
            },
            child: Text("TEST"),
          ),
        ],
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
              title: Text(
                post.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
