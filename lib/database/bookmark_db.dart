import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class BookmarkDB {
  getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/bookmarks.db';
    return path;
  }
  //Insertion
  add(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    db.insert(item);
    db.tidy();
    await db.close();
  }

  Future<int> remove(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    int val = await db.remove(item);
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> listAll() async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find({});
    val.forEach((element) {print(element.toString());});
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> check(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find({'id': item['id']});
    db.tidy();
    await db.close();
    return val;
  }

}