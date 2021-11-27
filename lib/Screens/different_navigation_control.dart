import 'package:customer/Screens/store_subs_flash_section.dart';

import 'package:customer/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DifferentNavigationControl extends StatefulWidget {
  const DifferentNavigationControl({Key? key}) : super(key: key);

  @override
  _DifferentNavigationControlState createState() =>
      _DifferentNavigationControlState();
}

class _DifferentNavigationControlState
    extends State<DifferentNavigationControl> {
  int _screenIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: IndexedStack(
        index: this._screenIndex,
        children: [
          StoreSection(
            pageName: PageName.StorePage,
          ),
          StoreSection(
            pageName: PageName.MenuPage,
          ),
          StoreSection(
            pageName: PageName.FlashSalePage,
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      selectedLabelStyle:
          TextStyle(fontFamily: 'Gotham', fontWeight: FontWeight.w500),
      showUnselectedLabels: false,
      currentIndex: this._screenIndex,
      items: [
        BottomNavigationBarItem(
            label: 'Cafeteria', icon: Icon(Icons.local_restaurant_outlined)),
        BottomNavigationBarItem(
          label: 'Subscription',
          icon: Icon(Icons.cached_outlined),
        ),
        BottomNavigationBarItem(
            label: 'Flash Sale', icon: Icon(Icons.flash_on_outlined)),

      ],
      onTap: (index) {
        print('Index is: $index');
        if (mounted) {
          setState(() {
            this._screenIndex = index;
          });
        }
      },
    );
  }
}
