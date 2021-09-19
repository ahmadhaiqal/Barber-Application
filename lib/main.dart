import 'package:barber_application/common/theme.dart';
import 'package:barber_application/models/barber_shop.dart';
import 'package:barber_application/screens/login.dart';
import 'package:barber_application/screens/transaction.dart';
import 'package:barber_application/services/auth_service.dart';
import 'package:barber_application/services/firestore_datatbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final db = FirestoreDatabase();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context)=> AuthService()),
        StreamProvider<List<BarberShop>>.value(
          value: db.getListBarberShop(),
          initialData: [],
        ),
      ],
      child: MaterialApp(
        title: 'Barber Application',
        theme: myTheme,
        initialRoute: '/login',
        routes: {
          '/login': (context) => Login(),
          '/transaction': (context)=> TransactionShop()
        },
      ),
    );
  }
}
