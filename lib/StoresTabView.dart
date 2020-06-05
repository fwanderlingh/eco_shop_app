import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'models/Record.dart';
import 'models/RecordList.dart';
import 'models/RecordService.dart';
import 'DetailsPage.dart';

class StoreTabView extends StatefulWidget {

  @override
  _StoreTabViewState createState() {
    return _StoreTabViewState();
  }
}

class _StoreTabViewState extends State<StoreTabView> {

  static const appTitle = "Negozi";
  Widget _appBarTitle = new Text(appTitle);

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  RecordList _records = new RecordList();
  RecordList _filteredRecords = new RecordList();

  Icon _searchIcon = new Icon(Icons.search);


  @override
  void initState() {
    super.initState();

    _records.records = new List();
    _filteredRecords.records = new List();

    _getRecords();
  }

  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    setState(() {
      for (Record record in records.records) {
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        //elevation: 0.1,
        //centerTitle: true,
        title: _appBarTitle,
        actions: [ new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed
        )],
    );
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      _filteredRecords.records = new List();
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].name.toLowerCase().contains(_searchText.toLowerCase())
            || _records.records[i].address.toLowerCase().contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this._filteredRecords.records.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Record record) {

    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
//        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 10.0),
//              decoration: new BoxDecoration(
//                  border: new Border(
//                      right: new BorderSide(width: 1.0, color: Colors.grey[400]))),
              child: Hero(
                  tag: "avatar_" + record.name,
                  child: CircularProfileAvatar(
                    record.photo,
                    radius: 28,
                    //backgroundColor: Colors.transparent,
                    borderWidth: 0.0,  // sets border, default 0.0
                    initialsText: Text(
                      record.name[0].toUpperCase(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),  // sets initials text, set your own style, default Text('')
                    borderColor: Colors.amber, // sets border color, default Colors.white
                    elevation: 5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                    //foregroundColor: Colors.brown.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                    cacheImage: true, // allow widget to cache image against provided url
                    showInitialTextAbovePicture: false, // setting it true will show initials text above profile picture, default false
                  )
              )
          ),
          title: Text(
            record.name,
            style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: record.address,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          maxLines: 3,
                          softWrap: true,
                        )
                      ]))
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => new DetailPage(record: record)));
          },
        ),
      ),
    );
  }

  _StoreTabViewState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _resetRecords() {
    this._filteredRecords.records = new List();
    for (Record record in _records.records) {
      this._filteredRecords.records.add(record);
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          autofocus: true,
          controller: _filter,
          style: new TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.white),
            fillColor: Colors.white,
            hintText: 'Search by name',
            hintStyle: TextStyle(color: Colors.white),
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(appTitle);
        _filter.clear();
      }
    });
  }

}


