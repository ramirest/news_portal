import 'package:flutter/material.dart';
import 'timeline.dart';
import 'services.dart';

class Datatable extends StatefulWidget {
  Datatable(): super();
  final String title = 'News portal data table';
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

class DatatableState extends State<Datatable>{
  List<Timeline> _timeline;
  GlobalKey<ScaffoldState> _scaffoldKey;
  Timeline _selectedNews;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _news = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(context: Text(message),),);
  }

  _getNews(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getNews();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        )
      )
    );
  }
}