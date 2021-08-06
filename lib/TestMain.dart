import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Crm';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
                              Container(
                                padding: EdgeInsets.all(20.0),
                                child: MyStatefulWidget(),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed))
                                        return 16;
                                      return 0;
                                    }),
                                ),
                                onPressed: () { },
                                child: Text('Add'),
                              ),
                          ]
            ),
            Container(
            padding: EdgeInsets.all(20.0),
            child: Container(
                child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: EdgeInsets.symmetric(vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quote for 12 Tables', style: TextStyle(color: Colors.black, fontSize: 20)),
                          
                          Text('\$ 40,000.00'),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                RatingBar.builder(
                                  itemSize: 25,
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizedBox(width: 50),
                                Row(
                                  children: [
                                    Text('4.0', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                                    Text('/ 5.0', style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text('Text...'),
                          Row(
                            children: [
                              Icon(Icons.person),
                              Text('Name')
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'New';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['New', 'Won', 'Proposition', 'Qualified']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
