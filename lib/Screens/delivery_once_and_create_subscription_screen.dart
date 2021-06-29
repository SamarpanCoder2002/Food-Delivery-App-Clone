import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../types.dart';

class OrderOptionsScreen extends StatefulWidget {
  final OrderOptions orderOptions;

  OrderOptionsScreen({required this.orderOptions});

  @override
  _OrderOptionsScreenState createState() => _OrderOptionsScreenState();
}

class _OrderOptionsScreenState extends State<OrderOptionsScreen> {
  int _quantityFoodItem = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _bottomSheet(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 110,
        margin: EdgeInsets.only(top: 10.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            _heading(),
            _selectedFoodShow(),
            _itemQuantityChoice(
                Icons.shopping_bag_outlined, 'Quantity per day'),
            widget.orderOptions == OrderOptions.DeliveryOnce
                ? _itemQuantityChoice(
                    Icons.calendar_today_outlined, 'Choose date\n10-05-2021',
                    upperRow: false)
                : Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: _dateRow(),
                  ),
            widget.orderOptions == OrderOptions.DeliveryOnce
                ? _couponCodeApply()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _weekDayShow(),
                  ),
            if (widget.orderOptions == OrderOptions.DeliveryOnce)
              _availableCouponOption(),
            if (widget.orderOptions == OrderOptions.DeliveryOnce)
              _billDetails(),
            if (widget.orderOptions == OrderOptions.Subscription)
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: _itemQuantityChoice(
                    Icons.calendar_today_outlined, 'Start date\n10-05-2021',
                    upperRow: false),
              ),
            if (widget.orderOptions == OrderOptions.Subscription)
              _itemQuantityChoice(
                  Icons.av_timer_outlined, 'Recharge/Top up\n30 Deliveries',
                  upperRow: false),
          ],
        ),
      ),
    );
  }

  Widget _heading() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            widget.orderOptions == OrderOptions.DeliveryOnce
                ? 'Deliver Once'
                : 'Create Subscription',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Gotham'),
          )
        ],
      ),
    );
  }

  Widget _selectedFoodShow() {
    return Container(
      color: const Color.fromRGBO(94, 224, 23, 1),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 150.0,
            child: Image.asset('assets/images/dosa.png',
                errorBuilder: (_, __, ___) => Center(
                      child: CircularProgressIndicator(),
                    )),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                SizedBox(
                    width: 180.0,
                    child: Text(
                      'Special Dosa',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: 180.0,
                  child: Text(
                    'Weight: 130g',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: 180.0,
                  child: Row(
                    children: [
                      Text(
                        '\u20B9150',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'Gotham'),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Per Item',
                        style: TextStyle(color: Colors.white70, fontSize: 12.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total \u20B9150',
            style: TextStyle(fontSize: 18.0, fontFamily: 'Gotham'),
          ),
          SizedBox(
            width: 150.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(94, 224, 23, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
              child: Center(
                child: Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 18.0, fontFamily: 'Gotham'),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemQuantityChoice(IconData iconData, String text,
      {bool upperRow = true}) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(iconData, color: const Color.fromRGBO(130, 130, 130, 1)),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromRGBO(130, 130, 130, 1)),
                  ),
                ),
              ],
            ),
          ),
          upperRow
              ? Container(
                  height: 20.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(
                      color: const Color.fromRGBO(94, 224, 23, 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Text(
                          '-',
                          style: TextStyle(color: Colors.black38),
                        ),
                        onTap: () {
                          if (this._quantityFoodItem > 1) if (mounted) {
                            setState(() {
                              this._quantityFoodItem -= 1;
                            });
                          }
                        },
                      ),
                      Text(
                        '${this._quantityFoodItem}',
                        style: TextStyle(color: Colors.black38, fontSize: 16.0),
                      ),
                      GestureDetector(
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.black38),
                        ),
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              this._quantityFoodItem += 1;
                            });
                          }
                        },
                      ),
                    ],
                  ))
              : Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20.0,
                ),
        ],
      ),
    );
  }

  Widget _couponCodeApply() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/ticket.png',
            errorBuilder: (_, __, ___) =>
                Center(child: CircularProgressIndicator()),
            width: 20.0,
            color: Colors.black12,
          ),
          SizedBox(
            width: 160.0,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: null,
                hintText: 'COUPON CODE',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 16.0),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(94, 224, 23, 1),
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

  Widget _availableCouponOption() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      child: Text(
        'Available Coupon',
        style: TextStyle(color: Colors.blue, fontSize: 12.0),
      ),
    );
  }

  Widget _billDetails() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
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
                            ? 'Package Charge'
                            : 'To Pay',
                    style: TextStyle(
                        color: Color.fromRGBO(96, 96, 96, 1),
                        fontFamily: 'Gotham'),
                  ),
                  Text(
                    '\u20B9150',
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

  Widget _dateRow() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/up.png',
                        width: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset(
                          'assets/images/down.png',
                          width: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                child: Text(
                  'Repeat',
                  style: TextStyle(fontFamily: 'Gotham', color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                child: Text(
                  'DAILY',
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      color: const Color.fromRGBO(94, 224, 23, 1)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weekDayShow() {
    List<String> _weekDay = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Container(
      margin: EdgeInsets.only(left: 50.0, top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 7; i++)
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == 5 || i == 6
                    ? Colors.white
                    : const Color.fromRGBO(94, 224, 23, 1),
                border: i == 5 || i == 6
                    ? Border.all(color: const Color.fromRGBO(94, 224, 23, 1))
                    : null,
              ),
              child: Center(
                  child: Text(
                _weekDay[i],
                style: TextStyle(
                    color: i == 5 || i == 6
                        ? const Color.fromRGBO(94, 224, 23, 1)
                        : Colors.white,
                    fontSize: 18.0),
              )),
            ),
        ],
      ),
    );
  }
}
