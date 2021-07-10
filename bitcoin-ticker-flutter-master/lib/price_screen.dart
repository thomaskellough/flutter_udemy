import 'package:bitcoin_ticker/NetworkingService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final networkingService = NetworkingService();
  String selectedCurrency = 'USD';
  Map<String, String> cryptoValues = {};

  DropdownButton<String> androidndroidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(item);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            getConversionRate();
          },
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      Text item = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      pickerItems.add(item);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getConversionRate();
      },
      children: pickerItems,
    );
  }

  List<CryptoConversionContainer> getCryptoList() {
    List<CryptoConversionContainer> list = [];
    for (String crypto in cryptoList) {
      CryptoConversionContainer container = CryptoConversionContainer(
        crypto: crypto,
        rate: cryptoValues[crypto],
        currency: selectedCurrency,
      );
      list.add(container);
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    for (String crypto in cryptoList) {
      cryptoValues[crypto] = ':)';
    }
    getConversionRate();
  }

  Future<void> getConversionRate() async {
    for (String crypto in cryptoList) {
      var response = await networkingService.getConversionRate(
          coin: crypto, currency: selectedCurrency);
      double doubleRate = response['rate'];
      setState(() {
        cryptoValues[crypto] = doubleRate.toInt().toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidndroidDropdown(),
          )
        ],
      ),
    );
  }
}

class CryptoConversionContainer extends StatelessWidget {
  String crypto;
  String rate;
  String currency;

  CryptoConversionContainer({this.crypto, this.rate, this.currency});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $rate $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
