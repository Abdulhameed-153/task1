import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComingSoon1 extends StatefulWidget {
  String onecategor;
  ComingSoon1({Key key, @required this.onecategor}) : super(key: key);
  @override
  _ComingSoon1State createState() => _ComingSoon1State(onecategor);
}

// Page that appears when you press in any item in the categories menu
class _ComingSoon1State extends State<ComingSoon1> {
  String onecategor; // name of the item taken from its list

  _ComingSoon1State(this.onecategor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text(
          onecategor,
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
          'Coming Soon...',
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
