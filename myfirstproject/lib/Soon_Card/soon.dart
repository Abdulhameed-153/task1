import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComingSoon extends StatefulWidget {
  String oneproduct;
  ComingSoon({Key key, @required this.oneproduct}) : super(key: key);
  @override
  _ComingSoonState createState() => _ComingSoonState(oneproduct);
}

// Page that appears when you press in any item in the products menu
class _ComingSoonState extends State<ComingSoon> {
  String oneproduct; // name of the item taken from its list

  _ComingSoonState(this.oneproduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text(
          oneproduct,
          style: TextStyle(
              fontFamily: 'Baloo',
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.white),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Coming Very Very Soon...',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 30,
            fontFamily: 'Baloo',
          ),
        ),
      ),
    );
  }
}
