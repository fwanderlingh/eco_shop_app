import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'models/Record.dart';

import 'helpers/URLLauncher.dart';
import 'helpers/CallsAndMessageServices.dart';

// 1
class DetailPage extends StatelessWidget {
  final Record record;
  DetailPage({this.record});

  //static GetIt locator = GetIt();
//  void setupLocator() {
//    locator.registerSingleton(CallsAndMessagesService());
//  }
//  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  @override
  Widget build(BuildContext context) {
    //setupLocator();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(record.name),
        ),
        body: new ListView(
            children: <Widget>[
              Hero(
                tag: "avatar_" + record.name,
                child: ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 50.0,
                    minWidth: 50.0,
                    maxHeight: 250.0,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: new Image.network(
                        record.photo,
                    ),
                  ),
                ),
              ),
              // 3
              new Container(
                padding: const EdgeInsets.all(32.0),
                child: new Row(
                  children: [
                    // First child in the Row for the name and the
                    // Release date information.
                    new Expanded(
                      // Name and Address are in the same column
                      child: new Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Code to create the view for name.
                          new Container(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: new Text(
                              "Nome: " + record.name,
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // Code to create the view for address.
                          SizedBox(height: 5),
                          new Text(
                            "Indirizzo: " + record.address,
                            style: new TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              URLLauncher().launchURL(record.url);
                            },
                            child: new Text(
                              "Visita il sito web >",
                              style: new TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Icon to indicate the phone number.
                    GestureDetector(
                      child: new Icon(
                        Icons.phone,
                        color: Colors.amber,
                      ),
                      //onTap: () => _service.call(record.contact),
                    ),
                    new Text(' ${record.contact}'),
                  ],
                ),
              ),
            ]
        )
    );
  }
}