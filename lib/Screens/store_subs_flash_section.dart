import 'package:connectivity/connectivity.dart';
import 'package:customer/Screens/delivery_once_and_create_subscription_screen.dart';
import 'package:customer/Screens/food_menu.dart';

import 'package:customer/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'common_widgets.dart';

class StoreSection extends StatefulWidget {
  final PageName pageName;

  StoreSection({required this.pageName});

  @override
  _StoreSectionState createState() => _StoreSectionState();
}

class _StoreSectionState extends State<StoreSection> {
  bool _vegOnlyToggle = false;

  void _checkConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    print('Connectivity Result: $connectivityResult');

    if (connectivityResult == ConnectivityResult.none)
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 0.0,
                title: Center(
                  child: Text(
                    'No Internet Connection',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ));
  }

  @override
  void initState() {
    if (widget.pageName == PageName.StorePage) _checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            topPortion(context),
            widget.pageName == PageName.StorePage
                ? searchBar('Search for Stores')
                : _sampleShow(),
            widget.pageName == PageName.StorePage
                ? _sampleShow()
                : searchBar('Search Your Food'),
            _fourthRowInformation(),
            if (widget.pageName == PageName.StorePage ||
                widget.pageName == PageName.MenuPage)
              _fifthRowInformation(),
            widget.pageName == PageName.StorePage
                ? _foodShowCaseForStore()
                : widget.pageName == PageName.MenuPage
                    ? _foodShowCaseForMenu()
                    : _flashSalePageCategory(),
          ],
        ),
      ),
    );
  }

  Widget _sampleShow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0, bottom: 15.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            width: 300.0,
            child: Image.asset(
              'assets/images/shop_page_upper.png',
            ),
          )),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
              child: Container(
            width: 300.0,
            child: Image.asset(
              'assets/images/shop_page_upper.png',
            ),
          )),
        ],
      ),
    );
  }

  Widget _fourthRowInformation() {
    return Container(
      margin: EdgeInsets.only(
          left: widget.pageName == PageName.FlashSalePage ? 30.0 : 15.0,
          right: 15.0,
          top: widget.pageName == PageName.StorePage ? 0.0 : 10.0),
      child: widget.pageName == PageName.FlashSalePage
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Flash Sale',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.pageName == PageName.StorePage
                      ? '10 Stores around you'
                      : 'Menu',
                  style: TextStyle(
                      fontSize:
                          widget.pageName == PageName.StorePage ? 18.0 : 30.0),
                ),
                Row(
                  children: [
                    Text(
                      'Veg only',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Switch(
                      value: this._vegOnlyToggle,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {
                            this._vegOnlyToggle = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _fifthRowInformation() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 5.0),
      child: Text(
        'TCS IT PARK II',
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  Widget _foodShowCaseForStore() {
    return GestureDetector(
      onTap: () {
        print(widget.pageName);
        if (widget.pageName == PageName.StorePage)
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => FoodMenu()));
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
        width: double.maxFinite,
        child: Column(
          children: [
            for (int i = 0; i < 3; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Image.asset('assets/images/shop_page_lower.png'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _foodShowCaseForMenu() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
      width: double.maxFinite,
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: double.maxFinite,
                    height: 170,
                    margin: EdgeInsets.only(left: 40.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6.0,
                            offset: Offset(2.0, 2.0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 45,
                            margin: EdgeInsets.only(left: 120.0, top: 10.0),
                            padding: EdgeInsets.only(right: 3.0, left: 3.0),
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Text(
                              '3.4\u2605',
                              style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.green),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 50.0),
                          padding: const EdgeInsets.only(top: 10.0, left: 30.0),
                          width: 200,
                          child: Text(
                            'Special Dosa',
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30.0),
                          padding:
                              const EdgeInsets.only(top: 5.0, bottom: 11.0),
                          width: 200,
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Weight: 130g',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                          ),
                        ),
                        Container(
                          width: 230,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              )),
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _subscribtionPlan();
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(39, 211, 103, 1),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(30.0),
                                          topLeft: Radius.circular(30.0)),
                                    ),
                                    child: Text(
                                      '+',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                    child: Image.asset(
                      'assets/images/dosa.png',
                      errorBuilder: (_, __, ___) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _flashSalePageCategory() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        children: [
          for (int i = 0; i < 4; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => StoreSection(
                                  pageName: PageName.MenuPage,
                                )));
                  },
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              ExactAssetImage('assets/images/fruits.png'),
                          radius: 50.0,
                        ),
                        Text(
                          'Fruits',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => StoreSection(
                                  pageName: PageName.MenuPage,
                                )));
                  },
                  child: Container(
                    width: 150.0,
                    height: 160.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black12,
                          backgroundImage: ExactAssetImage(
                              'assets/images/beverage.jpg'),
                          radius: 50.0,
                          onBackgroundImageError: (_, __) {
                            Center(child: CircularProgressIndicator());
                          },
                        ),
                        Text(
                          'Beverages',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _subscribtionPlan() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        elevation: 0.0,
        title: Center(
          child: Text(
            'Subscription Plan',
            style: TextStyle(
                color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        content: Container(
          height: 140.0,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Please Choose a plan to order this item?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(105, 188, 69, 1),
                  ),
                  child: Container(
                    width: 150.0,
                    alignment: Alignment.center,
                    child: Text(
                      'Delivery once',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OrderOptionsScreen(
                                  orderOptions: OrderOptions.DeliveryOnce,
                                )));
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(105, 188, 69, 1),
                  ),
                  child: Container(
                    width: 150.0,
                    alignment: Alignment.center,
                    child: Text(
                      'Subscribe',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OrderOptionsScreen(
                                  orderOptions: OrderOptions.Subscription,
                                )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
