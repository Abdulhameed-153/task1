import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myfirstproject/Classes/Categories_class.dart';
import 'package:myfirstproject/Soon_Card/soon1.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailsItems extends StatefulWidget {
  @override
  _DetailsItemsState createState() => _DetailsItemsState();
}

// Page that appears when one's Press "Show All" button in categories, Containing All item of the specific class
class _DetailsItemsState extends State<DetailsItems> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(
          'categories',
          style: TextStyle(
              fontFamily: 'Baloo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 26),
        ).tr(),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
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
      ),
    );
  }
}
