import 'package:flutter/material.dart';
import '../../models/currency_model.dart';
import './currency_page_view.dart';

class CurrencyPage extends StatefulWidget {
   CurrencyPage({Key? key, required this.listCurrency, required this.topCur, required this.bottomCur}) : super(key: key);
   List<CurrencyModel> listCurrency;
   String? topCur;
   String? bottomCur;

  @override
  CurrencyPageView createState() => CurrencyPageView();
}
  
