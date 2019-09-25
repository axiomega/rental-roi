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
  double _low = 0;
  double _hi = 0;
  double _homeCost = 300000;
  double _taxPct = 2.416721;
  double _mRent = 3000;
  double _insurancePct = 0.25;
  final pctFormatter = new NumberFormat("#.##%");

  void _setCost(String s) {
    _homeCost = double.parse(s);
    _setROI();
  }

  void _setMRent(String s) {
    _mRent = double.parse(s);
    _setROI();
  }

  void _setROI() {
    setState(() {
      double aTax = _homeCost * (_taxPct / 100);
      double aInsurance = _homeCost * (_insurancePct /100);
      double aMgmt = _mRent * 12 * 0.1;
      double aMaint = _homeCost * 0.02;
      double aVacancy = 1/12;
      double newTenant = 500;
      double income = _mRent * 12 * (1-aVacancy) - newTenant - aTax - aInsurance - aMgmt - aMaint;
      _low = income / _homeCost;
      _hi = ( _mRent * 12 - aTax - aInsurance - aMgmt - aMaint/2) / _homeCost;
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
              pctFormatter.format(_low),
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              pctFormatter.format(_hi),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
