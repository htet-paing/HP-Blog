import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/model/post.dart';
import 'package:provider_and_fstore/provider/catogory_provider.dart';
import 'package:provider_and_fstore/provider/post_provider.dart';
import 'category_choice.dart';

class PostFormScreen extends StatefulWidget {
  final bool isUpdating;
  PostFormScreen({this.isUpdating});
  
  @override
  _PostFormScreenState createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();
  var _currentPost = Post();
  String _imageUrl;
  File _imageFile;

  bool _isInit = true;



  @override
  void didChangeDependencies() {
    if (_isInit) {
      PostProvider postProvider = Provider.of<PostProvider>(context, listen: false);
      if (postProvider.currentPost != null) {
        _currentPost = postProvider.currentPost;
      }else {
        _currentPost = new Post();
      }
      _imageUrl = _currentPost.image;
      // Provider.of<CatogoryProvider>(context, listen: false).addSymbolList(_currentPost.category);

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget _showImage() {
    if (_imageUrl == null && _imageFile == null) {
      return Center(
        child: Text("Image Place Holder"),
      );
    }else if (_imageFile != null) {
      print('Showing image from Local File');
      return Center(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.file(
              _imageFile,
              fit: BoxFit.cover,
            ),
            FlatButton(
              padding: EdgeInsets.all(16),
              color: Colors.black45,
              onPressed: () => _getLocalImage(),
              child: Text('Change Image', style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600
              ),)
            )
          ],
        ),
      );
    }else if (_imageUrl != null) {
      print('Showing image from URL');
      return Center(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.network(
              _imageUrl,
              fit: BoxFit.cover,
            ),
            FlatButton(
              padding: EdgeInsets.all(16),
              color: Colors.black45,
              onPressed: () => _getLocalImage(),
              child: Text('Change Image', style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600
              ),)
            )
          ],
        ),
      );
    }
    return Container();
  }

  Future<void> _getLocalImage() async{
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (imageFile != null) {
        _imageFile = File(imageFile.path);
      }else {
        print('No image selected');
      }
    });
  }

  void _saveForm() {
    if (!_formKey.currentState.validate()) {
        return ;
    }
      _formKey.currentState.save();
      _currentPost.catogory = Provider.of<CatogoryProvider>(context, listen: false).mySelectedCat;
    Provider.of<PostProvider>(context, listen: false).uploadPostAndImage(_currentPost, _imageFile, widget.isUpdating);
    
  }


  @override
  Widget build(BuildContext context) {
    final myCurrentCat = Provider.of<CatogoryProvider>(context).categoryList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post',style: GoogleFonts.playfairDisplay(
          fontWeight: FontWeight.bold
        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [  
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Theme.of(context).primaryColor, width: 0.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 7),
                          blurRadius: 7)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: TextFormField(
                      initialValue: _currentPost.title,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocusNode);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,                       
                        hintText: "Title",
                        hintStyle: TextStyle(
                        color: Colors.grey, fontSize: 18)
                      ),
                      onSaved: (value) {
                        _currentPost.title = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter provid value';
                        }
                        return null;
                      }
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 7),
                        blurRadius: 7)
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: TextFormField(
                      initialValue: _currentPost.description,
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,                       
                        hintText: "Description",
                        hintStyle: TextStyle(
                        color: Colors.grey, fontSize: 18)
                      ),
                      onSaved: (value) {
                        _currentPost.description = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter provid value';
                        }
                        return null;
                      }
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Category List : ${Provider.of<CatogoryProvider>(context, listen: false).mySelectedCat}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),              
                SizedBox( height: 10,),
                Container(
                  height: 120.0,
                  decoration: BoxDecoration(                   
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 7),
                        blurRadius: 7)
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child:ListView.builder(
                      itemCount: myCurrentCat.length,
                      itemBuilder: (ctx, i) {
                        return CategoryChoice(
                          cat: myCurrentCat[i],
                          postCategory: _currentPost.id != null ? _currentPost.catogory : null
                        );
                        
                      }
                  ),
                  ),
                ),
                SizedBox(height: 10),
                
                Container(
                  height: 170.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 7),
                        blurRadius: 7
                      )
                    ]
                  ),
                  child: _showImage(),
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _imageFile == null && _imageUrl == null ?
                    RaisedButton(
                      color: Colors.blue,
                      child: Text('Upload Image'),
                      onPressed: () => _getLocalImage()
                    ) : SizedBox(height: 0,),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text('Publish'),
                      onPressed: _saveForm
                    )
                  ],
                )
              ],
            ),
          ),
        )
      )
    );
  }
}