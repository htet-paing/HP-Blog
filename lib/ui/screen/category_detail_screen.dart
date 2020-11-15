import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/provider/post_provider.dart';
import 'package:provider_and_fstore/ui/widget/post_item.dart';

class CategoryDetailScreen extends StatelessWidget {
    static const routeName = '/catDetail';
  @override
  Widget build(BuildContext context) {
    final routArg =
      ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final catTitle = routArg['title'];
    final catSymbol = routArg['symbol'];
    final loadedPost = Provider.of<PostProvider>(context, listen: false).findPostwithSymbol(catSymbol);
    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: loadedPost.length,
          itemBuilder: (ctx, i) {
            return PostItem(loadedPost[i]);
          }
        ),
      ),
    );
  }
}