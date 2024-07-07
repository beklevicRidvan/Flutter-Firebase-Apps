import 'package:flutter/material.dart';
import 'package:harcama_takip_app/tools/components/my_button.dart';
import 'package:provider/provider.dart';

import '../../tools/components/my_textfield.dart';
import '../../view_model/auth_view_model/loginorregister_page_view_model.dart';
import '../../view_model/auth_view_model/register_page_view_model.dart';

class RegisterPageView extends StatelessWidget {
  const RegisterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  _buildMaterial(BuildContext context) {
    RegisterPageViewModel viewModel = Provider.of(context, listen: false);
    double deviceHeight = MediaQuery.of(context).size.height;
    return Material(
      color: const Color(0xff81b8f9),

      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: const Color(0xff81b8f9),
        width: double.infinity,
        height: deviceHeight / 1.8,
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextfield(
                controller: viewModel.emailController,
                hintText: "EMAIL",
                obscureTextValue: false),
             SizedBox(
              height: deviceHeight*0.02,
            ),
            MyTextfield(
                controller: viewModel.pwController,
                hintText: "PASSWORD",
                obscureTextValue: true),
            SizedBox(
              height: deviceHeight*0.02,
            ),
            MyTextfield(
                controller: viewModel.confirmController,
                hintText: "AGAIN PW",
                obscureTextValue: true),
            SizedBox(
              height: deviceHeight*0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Hesabın varsa"),
                TextButton(
                    onPressed: () =>
                        Provider.of<LoginOrRegisterPageViewModel>(context,
                                listen: false)
                            .togglePages(
                                Provider.of<LoginOrRegisterPageViewModel>(
                                        context,
                                        listen: false)
                                    .isLoginPage),
                    child: const Text("Giriş Yap",style: TextStyle(color: Colors.white),))
              ],
            ),
            SizedBox(
              height: deviceHeight*0.01,
            ),
            MyButton(
                text: "R E G I S T E R",
                myFunction: () => viewModel.register(context))
          ],
        ),
      ),
    );
  }


  _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Image.asset(
            "assets/background.jpg",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  _buildBottomSheet(context){
    return Stack(
      children: [
        _buildMaterial(context), // Container içeriği
        Positioned(
          top: -10,
          left: 0,
          right: 0, //
          child: Center(
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.cover,
              width: 520,
              height: 100,
            ),
          ),
        ),
      ],
    );
  }

}
