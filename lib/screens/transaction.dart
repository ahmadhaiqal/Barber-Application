import 'package:barber_application/models/barber_shop.dart';
import 'package:barber_application/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionShop extends StatefulWidget {
  const TransactionShop({Key? key}) : super(key: key);

  @override
  _TransactionShopState createState() => _TransactionShopState();
}

class _TransactionShopState extends State<TransactionShop> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context);
    List<BarberShop> barberShop = Provider.of<List<BarberShop>>(context);
    BarberShop barberShop1 = Provider.of<BarberShop>(context);
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        title: Center(
          child: Text(
            'Transaction',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white),
          ),
        ),
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('This is the transaction page'),
            for(int i = 0; i<barberShop.length; i++)
              Text('data'),
            Text(barberShop1.shopName),


            ElevatedButton(
              onPressed: (){
                authProvider.signOut();
                Navigator.pop(context);
              },
              child: Text('Sign out')
            )
          ],
        ),
      ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}
