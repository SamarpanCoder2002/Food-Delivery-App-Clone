import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'common_widgets.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  final List<int> _quantityFoodItem = List.generate(10, (index) => 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            _topPortion(),
            searchBar('Search for Food', trailing: true),
            _foodMenuHeading(),
            _category(),
            _foodList(),
          ],
        ),
      ),
    );
  }

  Widget _topPortion() {
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
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _foodMenuHeading() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left_outlined),
            onPressed: () {},
          ),
          SizedBox(
            width: 25.0,
          ),
          Text(
            'Food Menu',
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  Widget _category() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      width: double.maxFinite,
      height: 40.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            width: index == 0 ? 70.0 : 100.0,
            margin: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              color: index == 0
                  ? const Color.fromRGBO(94, 224, 23, 1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(index == 0 ? 15.0 : 20.0),
              border: index > 0
                  ? Border.all(width: 1, color: Colors.black12)
                  : null,
            ),
            child: Center(
              child: index == 0
                  ? Text(
                      'All',
                      style: TextStyle(color: Colors.white),
                    )
                  : _foodItemsCategory(index),
            ),
          );
        },
      ),
    );
  }

  Widget _foodItemsCategory(int index) {
    String _foodCategoryShowImage = 'assets/images/fruits.png';
    String _foodCategoryShowName = 'Fruits';

    if (index == 1) {
      _foodCategoryShowImage = 'assets/images/pawvaji.png';
      _foodCategoryShowName = 'Chaat';
    } else if (index == 2) {
      _foodCategoryShowImage = 'assets/images/noodles.png';
      _foodCategoryShowName = 'Food';
    }

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Row(
        children: [
          SizedBox(
            width: 50.0,
            child: Image.asset(
              _foodCategoryShowImage,
              width: 5.0,
            ),
          ),
          Text(
            _foodCategoryShowName,
          ),
        ],
      ),
    );
  }

  Widget _foodList() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 100.0),
      padding: EdgeInsets.only(bottom: 20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.5,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      onError: (_, __) {
                        Center(child: CircularProgressIndicator());
                      },
                      image: ExactAssetImage(
                        'assets/images/cocktail.jpg',
                      ),
                    )),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 150,
                        child: Text(
                          'Good Mocktail',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20.0),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        'Mocktail mixed with apple cider vinegar',
                        style: TextStyle(color: Colors.black26),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        '\u20B9300',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(94, 224, 23, 1),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: const Color.fromRGBO(94, 224, 23, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            child: Text('-'),
                            onPressed: () {
                              if (this._quantityFoodItem[index] >
                                  1) if (mounted) {
                                setState(() {
                                  this._quantityFoodItem[index] -= 1;
                                });
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '${this._quantityFoodItem[index]}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              primary: const Color.fromRGBO(94, 224, 23, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            child: Text('+'),
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  this._quantityFoodItem[index] += 1;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
