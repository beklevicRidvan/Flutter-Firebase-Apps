import 'package:flutter/material.dart';
import 'package:harcama_takip_app/tools/components/my_button.dart';
import 'package:harcama_takip_app/tools/components/my_textfield.dart';
import 'package:harcama_takip_app/view_model/auth_view_model/login_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model/loginorregister_page_view_model.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: _buildBottomSheet(context),
      body: _buildBody(context),
    );
  }

  _buildMaterial(BuildContext context) {
    LoginPageViewModel viewModel =
        Provider.of<LoginPageViewModel>(context, listen: false);
    double deviceHeight = MediaQuery.of(context).size.height;

    return Material(
      color: const Color(0xff81b8f9),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: const Color(0xff81b8f9),
        width: double.infinity,
        height: deviceHeight / 1.9,
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextfield(
                controller: viewModel.emailController,
                hintText: "EMAIL",
                obscureTextValue: false),
            const SizedBox(
              height: 15,
            ),
            MyTextfield(
                controller: viewModel.pwController,
                hintText: "PASSWORD",
                obscureTextValue: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Hesabın yoksa"),
                TextButton(
                    onPressed: () => Provider.of<LoginOrRegisterPageViewModel>(
                            context,
                            listen: false)
                        .togglePages(Provider.of<LoginOrRegisterPageViewModel>(
                                context,
                                listen: false)
                            .isLoginPage),
                    child: const Text(
                      "Üye ol",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))
              ],
            ),
            MyButton(
                text: "L O G I N", myFunction: () => viewModel.login(context))
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

  _buildBottomSheet(context) {
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
