import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/model/catogory.dart';
import 'package:provider_and_fstore/provider/catogory_provider.dart';

class CategoryChoice extends StatefulWidget {
  final Catogory cat;
  final List<dynamic> postCategory;
  CategoryChoice({this.cat, this.postCategory});
  @override
  _CategoryChoiceState createState() => _CategoryChoiceState();
}

class _CategoryChoiceState extends State<CategoryChoice> {

    bool _isSelected = false;
    bool _isInit = true;

    @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.postCategory != null) {
        _isSelected = widget.postCategory.contains(widget.cat.symbol);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Consumer<CatogoryProvider>(
          builder:(context, cat, _) =>  CheckboxListTile(
            title: Text(widget.cat.title,
          ),
          value: _isSelected, 
          onChanged: (value) {
            if (!_isSelected) {
              cat.addSymbol(widget.cat.symbol);
            }else {
              cat.removeSymbol(widget.cat.symbol);
            }
            setState(() {
              _isSelected = !_isSelected;
            });
          }
        ),
      ),
    );
  }
}