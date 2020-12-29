import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfirstproject/Classes/Shops_class.dart';
import 'package:myfirstproject/Soon_Card/soon2.dart';
import 'package:easy_localization/easy_localization.dart';

class ShopsItems extends StatefulWidget {
  @override
  _ShopsItemsState createState() => _ShopsItemsState();
}

// Page that appears when one's Press "Show All" button in shops, Containing All item of the specific class
class _ShopsItemsState extends State<ShopsItems> {
  ScrollController scrollController = ScrollController();
  bool loading;
  bool looding;
  String nextPage;
  List<Shops> shopslist = [];

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
        looding = false;
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
  } // Getting more Shops Function for pagination

  @override
  void initState() {
    super.initState();
    getShops();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('getting more shops');
        setState(() {
          looding = true;
        });
        getMoreShops();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  String baseURLImage = 'http://80.211.24.15/storage/';
  String oneshop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: Text(
          'shops',
          style: TextStyle(
              fontFamily: 'Baloo',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 26),
        ).tr(),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Stack(children: [
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
                    itemCount: shopslist.length,
                    controller: scrollController,
                    padding: EdgeInsets.all(3),
                    itemBuilder: (context, index) {
                      return GridTile(
                          child: InkWell(
                        onTap: () {
                          String oneshop = shopslist[index].name;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ComingSoon2(oneshop: oneshop),
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
                                      imageUrl:
                                          baseURLImage + shopslist[index].image,
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
                                      shopslist[index].name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
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
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                  ),
                ),
              ))
            : Container()
      ]),
    );
  }
}
