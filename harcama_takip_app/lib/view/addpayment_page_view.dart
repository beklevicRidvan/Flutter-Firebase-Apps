import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../tools/components/my_textfield.dart';
import '../tools/helper.dart';
import '../view_model/expanses_page_view_model.dart';

class AddPaymentPageView extends StatelessWidget {
  const AddPaymentPageView({super.key});

  @override
  Widget build(BuildContext context) {
    ExpansesPageViewModel myVm = Provider.of(context, listen: false);
    double deviceHeight = context.getDeviceHeight();

    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Consumer<ExpansesPageViewModel>(
                  builder: (context, viewModel, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      child: DropdownButton<String>(
                          isExpanded: true,
                          items: AppHelper.turkBankalari
                            .map((banka) => DropdownMenuItem<String>(
                                  value: banka,
                                  child: Text(banka),
                                ))
                            .toList(), // Convert the Iterable to a List
                        onChanged: (value) {
                          if (value != null) {
                            viewModel.secilenBanka = value;
                          }
                        },
                        underline: Container(),
                        hint: const Text('Banka seçiniz'),

                        value: viewModel.secilenBanka,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                MyTextfield(
                    controller: myVm.paymentNameController,
                    hintText: "PAYMENT NAME",
                    obscureTextValue: false),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                MyTextfield(
                    controller: myVm.priceController,
                    hintText: "PRICE",
                    obscureTextValue: false),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                  child: ButtonBar(

                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: const Color(0xff0288D1)),
                          child: Text(
                            "I P T A L",
                            style:
                                context.getBoldColorTextStyle(16, Colors.white),
                          )),
                      ElevatedButton(
                          onPressed: () => myVm.addCard(),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: const Color(0xff0288D1)),
                          child: Text(
                            "T A M A M",
                            style:
                                context.getBoldColorTextStyle(16, Colors.white),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
