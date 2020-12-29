import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myfirstproject/Classes/Categories_class.dart';
import 'package:myfirstproject/Soon_Card/soon1.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

// Page that appears when one's navigate to categories icon in the bottom nav bar
// it means categories whenever you see the word (details) here in this app
class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      child: FutureBuilder(
          future: getCategories(),
          builder: (context, productSnap) {
            if (productSnap.connectionState == ConnectionState.done) {
              return Container(
                height: 1000,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: productSnap.data.length,
                    padding: EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      Categories product =
                          Categories.fromJson(productSnap.data[index]);
                      return GridTile(
                          child: InkWell(
                        onTap: () {
                          String onecategor = product.name.toString();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ComingSoon1(onecategor: onecategor),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200].withOpacity(0.5),
                                    spreadRadius: 5,
                                    offset: Offset(2, 5),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 90,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.contain,
                                      imageUrl: baseURLImage +
                                          product.image.toString(),
                                      placeholder: (context, url) =>
                                          SpinKitChasingDots(
                                        color: Colors.deepOrangeAccent,
                                        size: 80.0,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          SpinKitChasingDots(
                                        color: Colors.deepOrangeAccent,
                                        size: 80.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      product.name.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ));
                    }),
              );
            } else {
              return Center(
                child: SpinKitPouringHourglass(
                  duration: Duration(milliseconds: 1100),
                  color: Colors.deepOrangeAccent,
                  size: 80.0,
                ),
              );
            }
          }),
    );
  }
}
