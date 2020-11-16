import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/provider/catogory_provider.dart';
import 'package:provider_and_fstore/provider/post_provider.dart';
import 'package:provider_and_fstore/ui/screen/post_form_screen.dart';
import 'package:provider_and_fstore/ui/widget/post_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _isInit = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
       Provider.of<PostProvider>(context).getPosts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  
  @override
  Widget build(BuildContext context) {
    final postData = Provider.of<PostProvider>(context);
    return Scaffold(  
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter Blog App',style: GoogleFonts.playfairDisplay(
          fontWeight: FontWeight.bold
        )),
        leading: Icon(Icons.home_outlined),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){
              //To clear the list of symbol
              Provider.of<CatogoryProvider>(context, listen: false).emptyMyselectedCat();
              postData.currentPost = null;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PostFormScreen(
                      isUpdating: false,
                    );
                  }
                )
              );
            }
          )
        ],       
      ),
      body: _isLoading ? 
      Center(child: CircularProgressIndicator())
      : Center(
        child: ListView.builder(
          itemCount: postData.postList.length,
          itemBuilder: (ctx, i) {
            return PostItem(postData.postList[i]);
          }
        )
      )
    );
  }
}