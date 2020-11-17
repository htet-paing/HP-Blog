import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/model/post.dart';
import 'package:provider_and_fstore/provider/post_provider.dart';
import 'package:provider_and_fstore/ui/screen/detail_screen.dart';

class PostItem extends StatelessWidget {
  final Post post;
  PostItem(this.post);
  @override
  Widget build(BuildContext context) {
    final postData = Provider.of<PostProvider>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      elevation: 3,
      margin: EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              postData.currentPost = post;
              Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DetailScreen();
                }
              )
            );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              ),
              child: Container(
                height: 170.0,
                width: double.infinity,
                child: Image.network(post.image != null ? post.image : 'https://i1.wp.com/www.dailyustimes.com/wp-content/uploads/2020/07/Major-US-figures-Twitter-accounts-hacked-in-Bitcoin-scam.jpg', fit: BoxFit.cover,)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title, style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700
                  ),),
                  SizedBox(
                    height: 5,
                  ),
                  Text(post.description, style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey[500]
                  ),),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text('Category : ',
                        style: TextStyle(
                          fontSize: 13,
                        color: Colors.grey
                        )),
                      Container(
                        height: 17,
                        width: 225,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: post.catogory.length,
                          itemBuilder: (ctx, i) =>
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text( post.catogory[i],style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 13,
                            ),),
                          )
                        ),
                      ),

                    ],
                  ),  
                ],
              ),
              
            ],
            ),
          )
        ],
      )
    );
  }
}