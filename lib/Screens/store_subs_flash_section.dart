import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:customer/BackEnd/api_call_section.dart';
import 'package:customer/Screens/delivery_once_and_create_subscription_screen.dart';

import 'package:customer/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'common_widgets.dart';
import 'food_menu.dart';

class StoreSection extends StatefulWidget {
  final PageName pageName;

  StoreSection({required this.pageName});

  @override
  _StoreSectionState createState() => _StoreSectionState();
}

class _StoreSectionState extends State<StoreSection> {
  bool _vegOnlyToggle = false;
  late Future _future;

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

    this._future = widget.pageName == PageName.StorePage
        ? getStoreCollectionData()
        : getFoodCategory();
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
    return Container(
        margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height / 2,
        child: FutureBuilder(
            future: this._future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final List<dynamic> _fetchData =
                    jsonDecode(snapshot.data.toString())['data'].values.first;

                return ListView.builder(
                  itemCount: _fetchData.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      print(widget.pageName);
                      if (widget.pageName == PageName.StorePage)
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => FoodMenu()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      padding: EdgeInsets.only(top: 110.0),
                      width: double.maxFinite,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        image: (_fetchData[index]['shopImageUrl'] != Null &&
                                !_fetchData[index]['shopImageUrl']
                                    .toString()
                                    .contains('null'))
                            ? DecorationImage(
                                image: NetworkImage(_fetchData[index]
                                        ['shopImageUrl']
                                    .toString()),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: NetworkImage(
                                    'https://media.istockphoto.com/vectors/error-like-laptop-with-dead-emoji-cartoon-flat-minimal-trend-modern-vector-id1011988208?k=6&m=1011988208&s=612x612&w=0&h=6l7ZtOJxcQ_xTThiNX_X0XWKRDx9rKZzgjSePb0XmtQ='),
                                fit: BoxFit.cover,
                              ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 3.0),
                            color: Colors.black26,
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: _manageDecoration(_fetchData, index),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
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
                                    _subscriptionPlan();
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
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(bottom: 20.0),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 2,
      child: FutureBuilder(
          future: this._future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<dynamic> _fetchData =
                  jsonDecode(snapshot.data.toString())['data'].values.first;

              return ListView.builder(
                itemCount: _fetchData.length ~/ 2.0,
                itemBuilder: (context, index) =>
                    _constructCategorySection(_fetchData, index),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  void _subscriptionPlan() {
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

  Widget _manageDecoration(List<dynamic> _fetchData, int index) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 20.0),
          child: _fetchData[index]['shopName'] != null
              ? Text(
                  _fetchData[index]['shopName'],
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                )
              : Text(
                  'Shop Name Not Found',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 40.0, left: 25.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/food_pic.png',
                color: const Color.fromRGBO(32, 172, 79, 1),
                width: 10.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              _fetchData[index]['typeOfFood'] != null &&
                      _fetchData[index]['typeOfFood'].length > 0
                  ? Text(
                      _fetchData[index]['typeOfFood'][0].toString(),
                      style: TextStyle(color: Colors.black45),
                    )
                  : Text(
                      'Indian',
                      style: TextStyle(color: Colors.black45),
                    ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.0, top: 65.0),
          child: Row(
            children: [
              Text(
                '\u0025',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '30% odder upto 100',
                style: TextStyle(color: Colors.black45),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: 10.0, left: MediaQuery.of(context).size.width - 40 - 60),
          padding: EdgeInsets.only(right: 3.0, left: 3.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Text(
            '3.4\u2605',
            style: TextStyle(
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 12.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 40.0, left: MediaQuery.of(context).size.width - 40 - 90),
          child: Text(
            "\u20B9${_fetchData[index]['priceCategory'] == null ? '100' : _fetchData[index]['priceCategory']} for one",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black45,
                fontSize: 12.0),
          ),
        ),
      ],
    );
  }

  Widget _constructCategorySection(List<dynamic> _fetchData, int index) {
    return Row(
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
                  backgroundColor: Colors.white24,
                  backgroundImage:
                      NetworkImage(_fetchData[index * 2]['categoryImageUrl']),
                  radius: 50.0,
                ),
                Text(
                  _fetchData[index * 2]['categoryName'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                  backgroundColor: Colors.white24,
                  backgroundImage: NetworkImage(
                      _fetchData[index * 2 + 1]['categoryImageUrl']),
                  radius: 50.0,
                  onBackgroundImageError: (_, __) {
                    Center(child: CircularProgressIndicator());
                  },
                ),
                Text(
                  _fetchData[index * 2 + 1]['categoryName'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
