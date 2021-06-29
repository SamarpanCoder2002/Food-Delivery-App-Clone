import 'package:customer/Screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget topPortion(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: Icon(
          Icons.location_on_rounded,
          color: const Color.fromRGBO(94, 90, 91, 1),
          size: 30.0,
        ),
        onPressed: () {},
      ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('tapp',
                style: TextStyle(
                    color: const Color.fromRGBO(94, 224, 23, 1),
                    fontSize: 35.0,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w500)),
            Column(
              children: [
                Image.asset(
                  'assets/images/heading_i.png',
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: Image.asset(
                    'assets/images/i_bottom_dot.png',
                    width: 8.0,
                  ),
                ),
              ],
            ),
            Text('t',
                style: TextStyle(
                    color: const Color.fromRGBO(94, 224, 23, 1),
                    fontSize: 35.0,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      IconButton(
        icon: Icon(
          Icons.shopping_cart,
          color: const Color.fromRGBO(94, 90, 91, 1),
          size: 30.0,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CartScreen()));
        },
      ),
    ],
  );
}

Widget searchBar(String hintText, {bool trailing = false}) {
  return Container(
    margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
    height: 35.0,
    child: TextField(
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: hintText == 'Search Your Food' ? 0.0 : 10.0),
        prefixIcon: Icon(
          Icons.search_outlined,
          color: const Color.fromRGBO(39, 211, 103, 1),
        ),
        suffix: trailing
            ? Container(
                margin: EdgeInsets.only(right: 10.0, left: 10.0),
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(186, 186, 191, 1),
                    borderRadius: BorderRadius.circular(40.0)),
                width: 70.0,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Filter',
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                    )),
                    Expanded(
                        child: Icon(
                      Icons.filter_list_outlined,
                      size: 18.0,
                    )),
                  ],
                ),
              )
            : null,
        enabledBorder: hintText == 'Search Your Food'
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
        focusedBorder: hintText == 'Search Your Food'
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
      ),
    ),
  );
}
