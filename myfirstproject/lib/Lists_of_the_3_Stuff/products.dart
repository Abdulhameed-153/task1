import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfirstproject/Classes/Products_class.dart';
import 'package:myfirstproject/Soon_Card/soon.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

// Page that appears when one's navigate to shopping bag icon in the bottom nav bar
class _ProductsPageState extends State<ProductsPage> {
  ScrollController scrollController = ScrollController();
  bool loading;
  bool looding;
  String nextPage;
  List<Products> productslist = [];

  Future getProducts() async {
    try {
      String baseURL = 'http://80.211.24.15/api/';
      setState(() {
        loading = true;
      });
      var response = await Dio().get(baseURL + 'getProductsTemplets/all/id');
      var data = response.data['data'];
      nextPage =
          response.data['next_page_url']; // to be used in getMoreProducts
      var products = data as List;
      productslist = products
          .map<Products>((json) => Products.fromJson(json))
          .toList(); // to be used in item builder
      setState(() {
        loading = false;
      });
    } on DioError catch (error) {
      setState(() {
        loading = false;
      });
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.CANCEL:
          throw error;
          break;
        default:
          throw error;
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      throw error;
    }
  } //Products Function

  Future getMoreProducts() async {
    if (nextPage == null) {
      setState(() {
        loading = false;
        looding = false;
      });
    } else {
      try {
        var response = await Dio().get(nextPage);
        var data = response.data['data'];
        nextPage = response.data['next_page_url'];
        var newProducts = data as List;
        var newProductsList = newProducts
            .map<Products>((json) => Products.fromJson(json))
            .toList();
        productslist += newProductsList;
        setState(() {
          loading = false;
          looding = false;
        });
      } on DioError catch (error) {
        setState(() {
          loading = false;
          looding = false;
        });
        switch (error.type) {
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.CANCEL:
            throw error;
            break;
          default:
            throw error;
        }
      } catch (error) {
        setState(() {
          loading = false;
          looding = false;
        });
        throw error;
      }
    }
  } // Getting more Products Function for pagination

  @override
  void initState() {
    super.initState();
    getProducts();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('getting more products');
        setState(() {
          looding = true;
        });
        getMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  String baseURLImage = 'http://80.211.24.15/storage/';
  String oneproduct;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      loading == true
          ? Center(
              child: SpinKitPouringHourglass(
              duration: Duration(milliseconds: 1100),
              color: Colors.deepOrangeAccent,
              size: 80.0,
            ))
          : Stack(children: [
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: productslist.length,
                  controller: scrollController,
                  padding: EdgeInsets.all(3),
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: InkWell(
                      onTap: () {
                        String oneproduct = productslist[index].name;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ComingSoon(oneproduct: oneproduct),
                        ));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                          height: 150,
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
                                        productslist[index].image,
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
                                    productslist[index].name,
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
            ]),
      looding == true
          ? Positioned(
              child: Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                ),
              ),
            ))
          : Container()
    ]);
  }
}
