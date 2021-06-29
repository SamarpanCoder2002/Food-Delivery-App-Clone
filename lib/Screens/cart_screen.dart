import 'package:customer/Screens/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _quantityFoodItem = 1;

  bool _cafeteriaChecked = true;
  bool _hDelChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _bottomSheet(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 90,
        child: ListView(
          shrinkWrap: true,
          children: [
            topPortion(context),
            _cartHeading(),
            _itemsInCart(),
            _couponCode(),
            _billDetails(),
            _pickUpSection(),
          ],
        ),
      ),
    );
  }

  Widget _cartHeading() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            'Cart',
            style: TextStyle(fontSize: 25.0, fontFamily: 'Gotham'),
          )
        ],
      ),
    );
  }

  Widget _itemsInCart() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black12, width: 0.5),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0,
                color: Colors.black12,
              ),
              BoxShadow(
                offset: Offset(0.0, -1.0),
                blurRadius: 3.0,
                color: Colors.black12,
              ),
            ]),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: Text(
                'ITEMS IN CART',
                style: TextStyle(fontSize: 18.0, fontFamily: 'Gotham'),
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 0.5,
              color: Colors.black12,
            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good Mocktail',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Gotham'),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 40.0,
                        height: 30.0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.5, color: Colors.black12))),
                          child: Text(
                            '-',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            if (this._quantityFoodItem > 1) if (mounted) {
                              setState(() {
                                this._quantityFoodItem -= 1;
                              });
                            }
                          },
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 30.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 0.5),
                        ),
                        child: Text(
                          '${this._quantityFoodItem}',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                        height: 30.0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.5, color: Colors.black12))),
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                this._quantityFoodItem += 1;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\u20B9300',
                    style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 20.0,
              thickness: 0.5,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              width: double.maxFinite,
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: 18.0, fontFamily: 'Gotham', color: Colors.grey),
                  hintText: 'Suggestion for the restaurant',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _couponCode() {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black12, width: 0.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 1.0),
              blurRadius: 2.0,
              color: Colors.black12,
            ),
            BoxShadow(
              offset: Offset(0.0, -1.0),
              blurRadius: 2.0,
              color: Colors.black12,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/ticket.png',
            width: 20.0,
            errorBuilder: (_, __, ___) =>
                Center(child: CircularProgressIndicator()),
          ),
          SizedBox(
            width: 160.0,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: null,
                hintText: 'COUPON CODE',
                hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                    fontFamily: 'Gotham'),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(94, 224, 23, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Apply',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _billDetails() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black12, width: 0.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 1.0),
              blurRadius: 2.0,
              color: Colors.black12,
            ),
            BoxShadow(
              offset: Offset(0.0, -1.0),
              blurRadius: 2.0,
              color: Colors.black12,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: double.maxFinite,
              child: Text(
                'BILL DETAILS',
                style: TextStyle(fontSize: 16.0),
              )),
          for (int i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    i == 0
                        ? 'Item Total'
                        : i == 1
                            ? 'Restaurant Charge'
                            : 'To Pay',
                    style: TextStyle(
                        color: i == 2
                            ? Colors.black
                            : Color.fromRGBO(96, 96, 96, 1),
                        fontFamily: 'Gotham'),
                  ),
                  Text(
                    '\u20B9300',
                    style: TextStyle(
                        color: Color.fromRGBO(96, 96, 96, 1),
                        fontSize: i == 2 ? 20.0 : 16.0,
                        fontFamily: 'Gotham'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _pickUpSection() {
    return Container(
      margin: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 5.0, right: 5.0),
      padding: EdgeInsets.only(left: 15.0, top: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black12, width: 0.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 1.0),
              blurRadius: 2.0,
              color: Colors.black12,
            ),
            BoxShadow(
              offset: Offset(0.0, -1.0),
              blurRadius: 2.0,
              color: Colors.black12,
            ),
          ]),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 16.0, top: 10.0),
            child: Text(
              'Pick Up',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Gotham'),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  Checkbox(
                      value: this._cafeteriaChecked,
                      activeColor: const Color.fromRGBO(94, 224, 23, 1),
                      onChanged: (changedVal) {
                        if (mounted) {
                          setState(() {
                            this._cafeteriaChecked = changedVal!;
                          });
                        }
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Cafeteria',
                    style: TextStyle(fontFamily: 'Gotham', color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  Checkbox(
                      value: this._hDelChecked,
                      activeColor: const Color.fromRGBO(94, 224, 23, 1),
                      onChanged: (changedVal) {
                        if (mounted) {
                          setState(() {
                            this._hDelChecked = changedVal!;
                          });
                        }
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Home Delivery',
                    style: TextStyle(fontFamily: 'Gotham', color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      width: double.maxFinite,
      height: 80.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(94, 224, 23, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: Text(
        'SELECT PAYMENT METHOD',
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}
