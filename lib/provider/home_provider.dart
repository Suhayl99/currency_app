import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/currency_model.dart';

class HomeProvider extends ChangeNotifier{
   List<CurrencyModel> currencyList = [];
   bool isLoading = false;
   final List<CurrencyModel> filterList = [];
  final TextEditingController editingController = TextEditingController();
   final TextEditingController editingControllerTop = TextEditingController();
  final TextEditingController editingControllerBottom =  TextEditingController();
  final FocusNode topFocus = FocusNode();
  final FocusNode bottomFocus = FocusNode();
  CurrencyModel? topCur;
  CurrencyModel? bottomCur;

  HomeProvider(){
    loadData();
  }

  void initChange() {
    filterList.addAll(currencyList);
    notifyListeners();
  }

  changeLoading(){
    isLoading = !isLoading;
    notifyListeners();
  }

    Future loadData() async {
     // changeLoading();
      try {
        var response = await get(
            Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
        if (response.statusCode == 200) {
          for (final item in jsonDecode(response.body)) {
            var model = CurrencyModel.fromJson(item);
            if (model.ccy == 'USD') {
              topCur = model;
            } else if (model.ccy == 'RUB') {
              bottomCur = model;
            }
            currencyList.add(model);
            await Future.delayed(const Duration(seconds: 5));
          }
        } else {
          log('Unknown Error');
        }
      } on SocketException {
        log("Connection Error");
      } catch (e) {
        (e.toString());
      }
   //   changeLoading();
    notifyListeners();
  }


  void exchange() {
    var model = topCur?.copyWith();
    topCur = bottomCur?.copyWith();
    bottomCur = model;
    editingControllerTop.clear();
    editingControllerBottom.clear();

    notifyListeners();
  }


  
 void setEditControllerBottom(){
     editingControllerBottom.addListener(() {
      if (bottomFocus.hasFocus) {
          if (editingControllerBottom.text.isNotEmpty) {
            double sum = double.parse(bottomCur?.rate ?? '0') /
                double.parse(topCur?.rate ?? '0') *
                double.parse(editingControllerBottom.text);
            editingControllerTop.text = sum.toStringAsFixed(2);
          } else {
            editingControllerTop.clear();
          }
           notifyListeners();
      }
    });
       
 }



 void setEditControllerTop(){
     editingControllerTop.addListener(() {
      if (topFocus.hasFocus) {
          if (editingControllerTop.text.isNotEmpty) {
            double sum = double.parse(topCur?.rate ?? '0') /
                double.parse(bottomCur?.rate ?? '0') *
                double.parse(editingControllerTop.text);
            editingControllerBottom.text = sum.toStringAsFixed(2);
          } else {
            editingControllerBottom.clear();
          }
        notifyListeners();
      }
    });

 }

   void setTopCur(CurrencyModel value){
    topCur = value;
    notifyListeners();
 }


 void setBottomCur(CurrencyModel value){
    bottomCur = value;
    notifyListeners();

 }

}