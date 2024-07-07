import 'package:flutter/material.dart';
import 'package:harcama_takip_app/tools/helper.dart';
import 'package:provider/provider.dart';

import '../model/card_model.dart';
import '../model/my_listtile.dart';
import '../tools/components/my_piechart.dart';
import '../view_model/expanses_page_view_model.dart';

class ExpensesPageView extends StatelessWidget {
  const ExpensesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  _buildBody(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        StreamBuilder(
          stream: Provider.of<ExpansesPageViewModel>(context, listen: false)
              .getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              List<CardModel> cards = snapshot.data!;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () =>
                                    Provider.of<ExpansesPageViewModel>(context,
                                            listen: false)
                                        .logOut(),
                                icon: const Icon(
                                  Icons.logout,
                                  size: 40,
                                )),
                            FutureBuilder(
                              future:
                                  Provider.of<ExpansesPageViewModel>(context)
                                      .getCurrentUserModel(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  var user = snapshot.data!;

                                  return Container(
                                    margin: const EdgeInsets.only(right: 10,top: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child:
                                                    Icon(Icons.person_outline)),
                                            SizedBox(
                                              width: context.getDeviceHeight() *
                                                  0.01,
                                            ),
                                            Text(user.userEmail),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              context.getDeviceHeight() * 0.005,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'User NO: ',
                                              style:
                                                  context.getBoldTextStyle(15),
                                            ),
                                            Text(user.userId
                                                .substring(0, 9)
                                                .toString(),style: const TextStyle(decoration: TextDecoration.underline,),)
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.getDeviceHeight() * 0.02,
                      ),
                      Stack(
                        children: [
                          MyPiechart(
                            cards: cards,
                          ),
                          Positioned(
                              left: 10,
                              top: 10,
                              child: _buildTitle('Harcama OZET'))
                        ],
                      ),
                      _buildTitle('Harcamalarım'),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          var currentElement = cards[index];
                          return MyListTile(
                              title: currentElement.cardName,
                              subTitle: currentElement.paymentName,
                              price: currentElement.price);
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 10),
        alignment: AlignmentDirectional.bottomStart,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: title.contains('Harcamalarım') ? 25 : 17),
        ));
  }
}
