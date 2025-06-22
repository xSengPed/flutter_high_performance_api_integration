

// This function will be executed in a separate isolate.
// It must be a top-level function or a static method.
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:isolation_test/models/post.dart';

Future<List<dynamic>> _fetchPostsIsolate(String url) async {
  final dio = Dio();
  try {
    final response = await dio.get(url);
    // We return the raw list of dynamic data.
    // The main isolate will handle the final parsing into Post objects.
    return response.data as List<dynamic>;
  } on DioException catch (e) {
    // It's important to handle errors within the isolate and propagate them.
    // 'compute' will rethrow this exception on the main isolate.
    throw Exception('Failed to load posts: ${e.message}');
  }
}


abstract class PostRepository {
  Future<List<Post>> fetchPosts();
}

class PostRepositoryImpl implements PostRepository {
  final Dio dio;
  final String _url = 'https://jsonplaceholder.typicode.com/posts';

  PostRepositoryImpl({required this.dio});

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      // Use Flutter's `compute` function to run _fetchPostsIsolate in a background isolate.
      // This keeps the UI thread free from any networking and parsing workload.
      final responseData = await compute(_fetchPostsIsolate, _url);

      // Parsing happens here in the main isolate, but it's very fast.
      // The heavy lifting (I/O) was done in the background.
      return responseData.map((json) => Post.fromJson(json)).toList();

    } catch (e) {
      // Catch exceptions from the isolate or parsing and rethrow.
      throw Exception('Error processing posts: $e');
    }
  }
}
