import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:provider_and_fstore/model/catogory.dart';

class CatogoryProvider with ChangeNotifier {
  
  List<Catogory> _categoryList = [
    Catogory(
      id: 'c1',
      title: 'Political',
      symbol: 'political',
      imageUrl: 'https://thumbs.dreamstime.com/b/campaign-political-politics-vote-abstract-circle-background-flat-color-icon-campaign-political-politics-vote-abstract-circle-148690979.jpg',
    ),
    Catogory(
      id: 'c2',
      title: 'Science',
      symbol: 'science',
      imageUrl: 'https://cdn.iconscout.com/icon/premium/png-256-thumb/science-224-904154.png',
    ),
    Catogory(
      id: 'c3',
      title: 'Technology',
      symbol: 'technology',
      imageUrl: 'https://cdn5.vectorstock.com/i/1000x1000/81/39/technology-icon-gear-and-electronic-digital-vector-19038139.jpg',
    ),
    Catogory(
      id: 'c4',
      title: 'Programming',
      symbol: 'programming',
      imageUrl: 'https://thumbs.dreamstime.com/b/campaign-political-politics-vote-abstract-circle-background-flat-color-icon-campaign-political-politics-vote-abstract-circle-148690979.jpg',
    ),
  ];
  UnmodifiableListView<Catogory> get categoryList => UnmodifiableListView(_categoryList);

  ///////////////////////////////////////////////////////////////////////////////
  
  List<dynamic> _mySelectedCat = [];
  UnmodifiableListView<dynamic> get mySelectedCat => UnmodifiableListView(_mySelectedCat);

  void addSymbol(dynamic symbol) {
     _mySelectedCat.add(symbol);
     notifyListeners();
   }

   void removeSymbol(dynamic symbol) {
     _mySelectedCat.remove(symbol);
     notifyListeners();
   }

   void addSymbolList(List<dynamic> symbolList) {
     _mySelectedCat = symbolList;
     notifyListeners();
   }

   void emptyMyselectedCat() {
     _mySelectedCat.clear();
     notifyListeners();
   }


}