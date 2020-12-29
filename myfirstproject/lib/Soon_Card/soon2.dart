import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComingSoon2 extends StatefulWidget {
  String oneshop;
  ComingSoon2({Key key, @required this.oneshop}) : super(key: key);
  @override
  _ComingSoon2State createState() => _ComingSoon2State(oneshop);
}

// Page that appears when you press in any item in the shops menu
class _ComingSoon2State extends State<ComingSoon2> {
  String oneshop; // name of the item taken from its list

  _ComingSoon2State(this.oneshop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text(
          oneshop,
          style: TextStyle(
              fontFamily: 'Baloo',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Coming Very Soon...',
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
