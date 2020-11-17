import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/provider/post_provider.dart';

import 'post_form_screen.dart';

enum Options{
  Delete,
  Update,
}

class DetailScreen extends StatefulWidget {
  
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final postData = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail',style: GoogleFonts.playfairDisplay(
          fontWeight: FontWeight.bold
          )
        ),
        actions: [
          PopupMenuButton(
            onSelected: (Options selectedValue) {
              setState(() {
                if (selectedValue == Options.Update) {
                  print("Updated Post");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PostFormScreen(
                          isUpdating: true,
                        );
                      }
                    )
                  );
                }else {
                  print("Deleted Post");
                  Provider.of<PostProvider>(context, listen: false).deletePost(postData.currentPost).then((_) {
                    Navigator.pop(context);
                  });
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Update'), value: Options.Update,),
              PopupMenuItem(child: Text('Delete'), value: Options.Delete,),
            ]
          ),
          IconButton(
            icon: Icon(
              postData.bookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: postData.bookmarked 
                  ? Colors.red
                  : Colors.white
            ), 
            onPressed: () async{
              if (postData.bookmarked) {
                postData.removeBookmark();
              }else {
                postData.addBookmark();
              }
            }
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(postData.currentPost.image != null ? 
            postData.currentPost.image : 'https://i1.wp.com/www.dailyustimes.com/wp-content/uploads/2020/07/Major-US-figures-Twitter-accounts-hacked-in-Bitcoin-scam.jpg' , fit: BoxFit.cover)
          ],
        )
      ),
    );
  }
}