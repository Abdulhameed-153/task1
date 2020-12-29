import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myfirstproject/Classes/Categories_class.dart';
import 'package:myfirstproject/Classes/Products_class.dart';
import 'package:myfirstproject/Classes/Shops_class.dart';
import 'package:myfirstproject/Items_ViewAll/detail_items.dart';
import 'package:myfirstproject/Items_ViewAll/product_items.dart';
import 'package:myfirstproject/Items_ViewAll/shops_items.dart';
import 'package:myfirstproject/Soon_Card/soon.dart';
import 'package:myfirstproject/Soon_Card/soon1.dart';
import 'package:myfirstproject/Soon_Card/soon2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class Mylast extends StatefulWidget {
  @override
  _MylastState createState() => _MylastState();
}

// the Home Page body (represented in Home icon in the bottom nav bar)
class _MylastState extends State<Mylast> {
  ScrollController _scrollController =
      ScrollController(); //to be used in shops menu
  ScrollController scrollController =
      ScrollController(); //to be used in products menu

  bool loading;
  bool looding;
  bool looding2;
  String nextPage;
  String nextProduct;
  List<Products> productslist = [];
  List<Shops> shopslist = [];
  List<Categories> categorlist = [];
  ScrollController scrollController2 =
      ScrollController(); //to be used in categories menu

  Future getProducts() async {
    try {
      String baseURL = 'http://80.211.24.15/api/';
      setState(() {
        loading = true;
      });
      var response = await Dio().get(baseURL + 'getProductsTemplets/all/id');
      var data = response.data['data'];
      nextProduct =
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
  } // Products Function

  Future getMoreProducts() async {
    if (nextPage == null) {
      setState(() {
        loading = false;
        looding = false;
      });
    } else {
      try {
        var response = await Dio().get(nextProduct);
        var data = response.data['data'];
        nextProduct = response.data['next_page_url'];
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
  } //Getting More Products Function

  Future getCategories() async {
    try {
      String baseURL = 'http://80.211.24.15/api/';
      setState(() {
        loading = true;
      });
      var responseCategor = await Dio().get(baseURL + 'getCategories');
      var dataCategor = responseCategor.data;
      var categor = dataCategor as List;
      categorlist = categor
          .map<Categories>((json) => Categories.fromJson(json))
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
  } // Categories Function

  Future getShops() async {
    try {
      String baseURL = 'http://80.211.24.15/api/';
      setState(() {
        loading = true;
      });
      var response = await Dio()
          .get(baseURL + 'getShops/Lat1=0&Lon1=0&OrderBy=id&regionId=3');
      var data = response.data['data'];
      nextPage = response.data['next_page_url']; // to be used in getMoreShops
      var shops = data as List;
      shopslist = shops
          .map<Shops>((json) => Shops.fromJson(json))
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
  } // Shops Function

  Future getMoreShops() async {
    if (nextPage == null) {
      setState(() {
        loading = false;
        looding2 = false;
      });
    } else {
      try {
        var response = await Dio().get(nextPage);
        var data = response.data['data'];
        nextPage = response.data['next_page_url'];
        var newShops = data as List;
        var newshopsList =
            newShops.map<Shops>((json) => Shops.fromJson(json)).toList();
        shopslist += newshopsList;
        setState(() {
          loading = false;
          looding2 = false;
        });
      } on DioError catch (error) {
        setState(() {
          loading = false;
          looding2 = false;
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
          looding2 = false;
        });
        throw error;
      }
    }
  } //Getting more shops function

  String baseURLImage = 'http://80.211.24.15/storage/';

  @override
  void initState() {
    getCategories();
    getShops();
    getProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('getting more shops');
        setState(() {
          looding2 = true;
        });
        getMoreShops();
      }
    });
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

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    scrollController.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context);
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.63;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.size.width;
    mediaQueryData.size.height; //to be used in SizedBox
    return ResponsiveWidgets.builder(
      child: Stack(children: [
        ListView(children: <Widget>[
          Container(
            height: 230,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                Card(
                  elevation: 1,
                  child: Container(
                    height: 180,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('asset/mm.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Card(
                  elevation: 1,
                  child: Container(
                    height: 180,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('asset/ll.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
            ),
          ),

          // Carosuel Slider code end here

          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              width: 10,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.language_rounded,
                      color: Colors.grey[800],
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        context.locale = Locale('ar', 'SA');
                        context.locale = Locale('en', 'US');
                      });
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        context.locale = Locale('ar', 'SA');
                        context.locale = Locale('en', 'US');
                      });
                    },
                    child: Text(
                      'changeLanguage',
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        color: Colors.grey[800],
                        fontSize: 17,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
          ),

          //Change language Container end

          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'categories',
                        style: TextStyle(
                            fontFamily: 'Baloo',
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ).tr(),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsItems(),
                      ));
                    },
                    child: Text(
                      'buttonText',
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        color: Colors.grey[600],
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: loading == true
                ? Center(
                    child: SpinKitPouringHourglass(
                    duration: Duration(milliseconds: 1100),
                    color: Colors.deepOrangeAccent,
                    size: 50.0,
                  ))
                : ListView.builder(
                    itemCount: categorlist.length,
                    scrollDirection: Axis.horizontal,
                    controller: scrollController2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          String onecategor = categorlist[index].name;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ComingSoon1(onecategor: onecategor),
                          ));
                        },
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    margin: EdgeInsets.only(right: 3, left: 3),
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              height: 120,
                                              width: 160,
                                              imageUrl: baseURLImage +
                                                  categorlist[index].image,
                                              placeholder: (context, url) =>
                                                  SpinKitChasingDots(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    size: 80.0,
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error)),
                                          SizedBox(height: 10),
                                          Text(
                                            categorlist[index].name,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ),

          // Categories Menu Code end

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "shops",
                        style: TextStyle(
                            fontFamily: 'Baloo',
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ).tr(),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShopsItems(),
                      ));
                    },
                    child: Text(
                      'buttonText',
                      style: TextStyle(
                        fontFamily: 'Baloo',
                        color: Colors.grey[600],
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: loading == true
                ? Center(
                    child: SpinKitPouringHourglass(
                    duration: Duration(milliseconds: 1100),
                    color: Colors.deepOrangeAccent,
                    size: 50.0,
                  ))
                : Stack(children: [
                    ListView.builder(
                        itemCount: shopslist.length,
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              String oneshop = shopslist[index].name;
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ComingSoon2(oneshop: oneshop),
                              ));
                            },
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        margin:
                                            EdgeInsets.only(right: 3, left: 3),
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  height: 120,
                                                  width: 160,
                                                  imageUrl: baseURLImage +
                                                      shopslist[index].image,
                                                  placeholder: (context, url) =>
                                                      SpinKitChasingDots(
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                        size: 80.0,
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error)),
                                              SizedBox(height: 10),
                                              Text(
                                                shopslist[index].name,
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    looding2 == true
                        ? Positioned(
                            child: Center(
                              child: SizedBox(
                                height: 55,
                                width: 55,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.deepOrangeAccent),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ]),
          ),

          // Shops Menu Code end

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'products',
                          style: TextStyle(
                              fontFamily: 'Baloo',
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductsItem(),
                          ));
                        },
                        child: Text(
                          'buttonText',
                          style: TextStyle(
                            fontFamily: 'Baloo',
                            color: Colors.grey[600],
                          ),
                        ).tr(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: categoryHeight,
                child: Stack(children: [
                  loading == true
                      ? Center(
                          child: SpinKitPouringHourglass(
                          duration: Duration(milliseconds: 1100),
                          color: Colors.deepOrangeAccent,
                          size: 50.0,
                        ))
                      : Stack(children: [
                          GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: productslist.length,
                              controller: scrollController,
                              padding: EdgeInsets.all(1),
                              itemBuilder: (context, index) {
                                return GridTile(
                                    child: InkWell(
                                  onTap: () {
                                    String oneproduct =
                                        productslist[index].name;
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ComingSoon(oneproduct: oneproduct),
                                    ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[200]
                                                  .withOpacity(0.5),
                                              spreadRadius: 3,
                                              offset: Offset(0, 3),
                                            )
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 70,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.contain,
                                                imageUrl: baseURLImage +
                                                    productslist[index].image,
                                                placeholder: (context, url) =>
                                                    SpinKitChasingDots(
                                                  color:
                                                      Colors.deepOrangeAccent,
                                                  size: 40.0,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        SpinKitChasingDots(
                                                  color:
                                                      Colors.deepOrangeAccent,
                                                  size: 40.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                productslist[index].name,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
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
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.deepOrangeAccent),
                            ),
                          ),
                        ))
                      : Container(),
                ]),
              )
            ],
          ),
        ]),
      ]),
    );
  }
} // Products Menu Code
