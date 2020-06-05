import 'package:flutter/material.dart';

class SettingsTabView extends StatefulWidget {
  @override
  _SettingsTabViewState createState() {
    return _SettingsTabViewState();
  }
}

class _SettingsTabViewState extends State<SettingsTabView> {

  static final List<String> entries = <String>['Profilo', 'Assistenza', 'Licenze'];
  static final List<IconData> entriesIcons = <IconData>[Icons.face, Icons.announcement, Icons.info];

  static const TextStyle optionStyle = TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Altro'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 40,
//color: Colors.amber[colorCodes[index]],
            child: GestureDetector(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(entriesIcons[index]),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${entries[index]}',
                          style: optionStyle,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}