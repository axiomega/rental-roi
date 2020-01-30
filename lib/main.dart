import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Rental ROI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _roi = 0;
  double _homeCost = 300000;
  double _taxPct = 2.416721;
  double _mRent = 3000;
  double _insurance = 700;
  final pctFormatter = new NumberFormat("#.##%");

  void _setCost(String s) {
    _homeCost = double.parse(s);
    _setROI();
  }

  void _setMRent(String s) {
    _mRent = double.parse(s);
    _setROI();
  }

  void _setInsurance(String s) {
    _insurance = double.parse(s);
    _setROI();
  }

  void _setROI() {
    setState(() {
      double revenue = _mRent * 12;
      double aTax = _homeCost * (_taxPct / 100);
      double aInsurance = _insurance;
      double aMgmt = _mRent * 12 * 0.1;
      double aMaint = _homeCost * 0.02;
      // 1/2 month vacancy per year
      double aVacancy = _mRent * 0.5;
      double income = revenue - aTax - aInsurance - aMgmt - aMaint - aVacancy;
      _roi = income / _homeCost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              initialValue: '$_homeCost',
              onChanged: _setCost,
              decoration: new InputDecoration(
                labelText: "Cost",
              ),
              keyboardType: TextInputType.number,
            ),
            new TextFormField(
              initialValue: '$_insurance',
              onChanged: _setInsurance,
              decoration: new InputDecoration(
                labelText: "Insurance Premium",
              ),
              keyboardType: TextInputType.number,
            ),
            new TextFormField(
              initialValue: '$_mRent',
              onChanged: _setMRent,
              decoration: new InputDecoration(
                labelText: "Monthly Rent",
              ),
              keyboardType: TextInputType.number,
            ),
            Text(
              'ROI:',
            ),
            Text(
              pctFormatter.format(_roi),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
