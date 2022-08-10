import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../models/currency_model.dart';
import '../../provider/home_provider.dart';
import '../../utils/constans.dart';
import '../currency_page/currency_page.dart';
import './my_home_page_view_model.dart';
  
class MyHomePageView extends MyHomePageViewModel {
 

  @override
  Widget build(BuildContext context) {
     var data = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: const Color(0xff1f2235),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Hello Suhayl,\n",
                      style: kTextStyle(size: 16),
                      children: [
                        TextSpan(
                          text: "welcome Back",
                          style:
                              kTextStyle(size: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white12)),
                      child: const Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(child: data.isLoading ? const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue ),
          ),
        ) : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        decoration: BoxDecoration(
                          color: const Color(0xff2d334d),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Exchange",
                                  style: kTextStyle(
                                      size: 16, fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  iconSize: 20,
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                     _itemExch(
                                        data.editingControllerTop, data.topCur, data.topFocus,
                                        ((value) {
                                      if (value is CurrencyModel) {
                                        setState(() => data.topCur = value);
                                      }
                                    })),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    _itemExch(data.editingControllerBottom, data.bottomCur,
                                        data.bottomFocus, ((value) {
                                      if (value is CurrencyModel) {
                                        setState(() => data.bottomCur = value);
                                      }
                                    })),
                                  ],
                                ),
                                InkWell(
                                onTap: () {
                                  context.read<HomeProvider>().exchange();
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2d334d),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white12),
                                  ),
                                  child: const Icon(
                                    Icons.currency_exchange,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                              ],
                            ),
                          ],
                        ),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _itemExch(TextEditingController controller, CurrencyModel? model,
      FocusNode focusNode, Function callback) {
      var data = context.watch<HomeProvider>();   
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '0.00',
                    hintStyle:
                        kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CurrencyPage(
                      listCurrency: data.currencyList,
                      topCur: data.topCur!.ccy,
                      bottomCur: data.bottomCur!.ccy);
                })).then((value) {
                  if (value is CurrencyModel) {
                    setState(() {
                      model = value;
                    });
                  }
                }),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xff10a4d4)),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SvgPicture.asset(
                        'assets/flags/${model?.ccy?.substring(0, 2).toLowerCase()}.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Text(
                        model?.ccy ?? 'UNK',
                        style:
                            kTextStyle(size: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                      size: 15,
                    )
                  ]),
                ),
              )
            ],
          ),
          Text(
            controller.text.isNotEmpty
                ? (double.parse(controller.text) * 0.05).toStringAsFixed(2)
                : '0.00',
            style:
                kTextStyle(fontWeight: FontWeight.w600, color: Colors.white54),
          )
        ],
      ),
    );
  }

}
