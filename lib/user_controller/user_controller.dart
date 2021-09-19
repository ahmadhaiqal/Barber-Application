import 'package:barber_application/models/barber_shop.dart';
import 'package:barber_application/screens/transaction.dart';
import 'package:barber_application/services/auth_service.dart';
import 'package:barber_application/services/firestore_datatbase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserController extends StatefulWidget {
  const UserController({Key? key}) : super(key: key);

  @override
  _UserControllerState createState() => _UserControllerState();
}

class _UserControllerState extends State<UserController> {
  final db = FirestoreDatabase();
  BarberShop barberShop = BarberShop(shopName: 'shopName');

  PageController _pageController = PageController();
  int _selectedIndex = 0;

  List<Widget> _screen = [
    TransactionShop(),
    TransactionShop()
  ];

  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  void  _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    String userIdToken = authProvider.userIdToken.toString();
    print(userIdToken);
    return StreamProvider<BarberShop>.value(
      value: db.getBarberShop(userIdToken),
      initialData: barberShop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screen,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet_rounded,
                size: 32,
                color:  _selectedIndex ==0 ? Theme.of(context).primaryColor : Colors.grey,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: _selectedIndex ==0 ? Theme.of(context).primaryColor : Colors.grey,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet_rounded,
                size: 32,
                color:  _selectedIndex ==0 ? Theme.of(context).primaryColor : Colors.grey,
              ),
              title: Text(
                  'Home',
                  style: TextStyle(
                      color: _selectedIndex ==0 ? Theme.of(context).primaryColor : Colors.grey,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
