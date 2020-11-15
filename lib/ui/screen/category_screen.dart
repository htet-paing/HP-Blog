import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/provider/catogory_provider.dart';
import 'package:provider_and_fstore/ui/widget/catogory_item.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catogoryData = Provider.of<CatogoryProvider>(context, listen: false).categoryList;
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10, 
          maxCrossAxisExtent: 200,
        ),
        itemCount: catogoryData.length,
        itemBuilder: (context, index) {
          return CatogoryItem(catogoryData[index]);
        }                 
      ),
    );
  }
}