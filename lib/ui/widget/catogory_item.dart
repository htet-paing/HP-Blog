import 'package:flutter/material.dart';
import 'package:provider_and_fstore/model/catogory.dart';
import 'package:provider_and_fstore/ui/screen/category_detail_screen.dart';

class CatogoryItem extends StatelessWidget {
  final Catogory catogory;
  CatogoryItem(this.catogory);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(      
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(
              CategoryDetailScreen.routeName,
              arguments: {
                'symbol': catogory.symbol,
                'title': catogory.title,
              }
            );
          },
          child: Image.network(catogory.imageUrl,fit: BoxFit.cover)
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(catogory.title,textAlign: TextAlign.center,),  
        ),
      ),
    );
  }
}