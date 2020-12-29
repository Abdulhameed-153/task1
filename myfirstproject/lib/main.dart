import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:myfirstproject/Items_ViewAll/shops_items.dart';
import 'package:myfirstproject/Lists_of_the_3_Stuff/details.dart';
import 'package:myfirstproject/Lists_of_the_3_Stuff/shops.dart';
import 'package:myfirstproject/Home_Page/home_page.dart';
import 'Lists_of_the_3_Stuff/products.dart';
import 'Loading_page/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

void main() => runApp(
      EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
        path: 'asset/translations',
        fallbackLocale: Locale('en', 'US'),
        child: Myapp(),
      ),
    );

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(), // The Splash Screen
        '/home': (context) =>
            TheMain(), // Home Page:(the appbar and bottom nav bar are the same, body changes)
        '/home_page_body': (context) => Mylast(),
      },
    );
  }
}

class TheMain extends StatefulWidget {
  @override
  _TheMainState createState() => _TheMainState();
}

class _TheMainState extends State<TheMain> {
  int pageindex = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  bool loading;

  List pages = [
    MyRoute(
      iconData: Icons.home,
      page: Mylast(), //home page (The home icon in the bottom nav bar)
    ),
    MyRoute(
      iconData: Icons.category,
      page: DetailsPage(), //categroies page
    ),
    MyRoute(
      iconData: Icons.store,
      page: ShopsPage(),
    ),
    MyRoute(
      iconData: Icons.shopping_bag,
      page: ProductsPage(),
    ),
  ]; // List for of page Routes to be used in bottom navigation bar

  void changeLanguageToArabic() {
    setState(() {
      context.locale = Locale('ar', 'SA');
    });
  }

  void changeLanguageToEnglish() {
    setState(() {
      context.locale = Locale('en', 'US');
    });
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context);
    return ResponsiveWidgets.builder(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShopsItems(),
                ));
              },
            ),
          ],
          elevation: 8,
          title: Text(
            'title',
            style: TextStyle(
                fontFamily: 'Baloo',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 26),
          ).tr(),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: pages[pageindex].page,
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.deepOrangeAccent,
          backgroundColor: Colors.white,
          buttonBackgroundColor: Colors.deepOrangeAccent,
          height: 60,
          index: 0,
          items: pages
              .map((p) => Icon(
                    p.iconData,
                    size: 30,
                    color: Colors.white,
                  ))
              .toList(),
          animationDuration: Duration(milliseconds: 500),
          animationCurve: Curves.bounceInOut,
          key: bottomNavigationKey,
          onTap: (index) {
            print('$index');
            setState(() {
              pageindex = index;
            });
          },
        ),
      ),
    );
  }
}

class MyRoute {
  final IconData iconData;
  final Widget page;

  MyRoute({this.iconData, this.page});
} // Class of page Routes to be used in bottom nav bar
