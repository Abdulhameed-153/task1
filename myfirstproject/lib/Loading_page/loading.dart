import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';
import 'package:myfirstproject/Classes/Products_class.dart';
import 'package:myfirstproject/Classes/Shops_class.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}
// this is the Splash Screen

class _LoadingState extends State<Loading> {
  bool loading;
  String nextPage;
  List<Products> productslist = [];
  List<Shops> shopslist = [];

// Catogries Function

  Future getCategories() async {
    try {
      String baseURL = 'http://80.211.24.15/api/';
      var responseCategor = await Dio().get(baseURL + 'getCategories');
      var dataCategor = responseCategor.data;
      var categor = dataCategor;
      return categor;
    } catch (e) {
      print(e);
    }
  }

// Products Function

  Future getProducts() async {
    try {
      String baseURL = 'http://80.211.24.15/api/';
      setState(() {
        loading = true;
      });
      var response = await Dio().get(baseURL + 'getProductsTemplets/all/id');
      var data = response.data['data'];
      nextPage = response.data['next_page_url']; // to be used in getMoreShops
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
  }

// Shops Function

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
  }

//Navigating to Home Page after fetching data from API

  allData() async {
    await getCategories();
    await getProducts();
    await getShops();
    Navigator.of(context)
        .pushReplacementNamed('/home'); //Home_Page (TheMain Page)
  }

  @override
  void initState() {
    super.initState();
    allData();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.size.width;
    mediaQueryData.size.height; //to be used in padding
    ResponsiveWidgets.init(context);
    return ResponsiveWidgets.builder(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        mediaQueryData.size.width * 0.03,
                        mediaQueryData.size.height * 0.35,
                        mediaQueryData.size.width * 0.03,
                        0,
                      ),
                      child: Card(
                        elevation: 0,
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage('asset/gg.jpg'),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SpinKitRipple(
                    color: Colors.grey[800],
                    size: 100.0,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
