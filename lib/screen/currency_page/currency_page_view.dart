import 'package:currency_app/provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../utils/constans.dart';
import './currency_page_view_model.dart';
  
class CurrencyPageView extends CurrencyPageViewModel {
    
  @override
  Widget build(BuildContext context) {
    var data = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TextField(
          controller: data.editingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            fillColor: appBarColor,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.white,
              size: 20,
            ),
            hintText: 'Search',
            hintStyle: kTextStyle(color: Colors.white54, size: 16, fontWeight: FontWeight.w500),
            suffixIcon: IconButton(
                onPressed: () {
                  if (data.editingController.text.isEmpty) {
                    Navigator.pop(context);
                  } else {
                    data.editingController.clear();
                    setState(() {
                      data.filterList.clear();
                      data.filterList.addAll(widget.listCurrency);
                    });
                  }
                },
                icon: const Icon(Icons.clear, color: Colors.white, size: 20)),
          ),
          style: kTextStyle(size: 16, fontWeight: FontWeight.w500),
          onChanged: (value) {
            data.filterList.clear();
            if (value.isNotEmpty) {
              for (final item in widget.listCurrency) {
                if (item.ccy!.toLowerCase().contains(value.toLowerCase()) ||
                    item.ccyNmEN!.toLowerCase().contains(value.toLowerCase())) {
                  data.filterList.add(item);
                }
              }
            } else {
              data.filterList.addAll(widget.listCurrency);
            }
            setState(() {});
          },
        ),
      ),
      backgroundColor: const Color(0xff1f2235),
      body: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          itemBuilder: ((context, index) {
            var model = data.filterList[index];
            bool isChosen = widget.topCur == model.ccy || widget.bottomCur == model.ccy;
            return ListTile(
              tileColor: const Color(0xff2d334d),
              onTap: () {
                if (isChosen) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'It has been chosen!!!',
                        style: kTextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                } else {
                  Navigator.pop(context,model);
                //   Navigator.push(context, 
                // })),
                }
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(27.5),
                child: SvgPicture.asset(
                  'assets/flags/${model.ccy?.substring(0, 2).toLowerCase()}.svg',
                  height: 45,
                  width: 45,
                ),
              ),
              title: Text(
                model.ccy ?? '',
                style: kTextStyle(size: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                model.ccyNmEN ?? '',
                style: kTextStyle(fontWeight: FontWeight.w500, color: Colors.white54),
              ),
              trailing: Text(
                model.rate ?? '',
                style: kTextStyle(size: 16, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: isChosen ? const BorderSide(color: Color(0xff10a4d4), width: 2) : BorderSide.none),
            );
          }),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemCount: data.filterList.length),
    );
  }
}

