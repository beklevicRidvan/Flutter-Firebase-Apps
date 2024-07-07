import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/card_model.dart';
import '../helper.dart';

class MyPiechart extends StatelessWidget {
  final List<CardModel> cards;
  const MyPiechart({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.blue, blurRadius: 2, spreadRadius: 2),
            BoxShadow(color: Colors.blueGrey, blurRadius: 2, spreadRadius: 2),
          ]),
      height: context.getDeviceHeight() / 3,
      child: PieChart(

        swapAnimationCurve: Curves.bounceIn,
        swapAnimationDuration: const Duration(seconds: 1),
        PieChartData(
          titleSunbeamLayout: true,
          sections: cards.map((card) {
            final bankColor = AppHelper.getColor(card.cardName);

            return PieChartSectionData(
              value: card.price.toDouble(),
              color: bankColor,
              gradient: LinearGradient(colors: [
                bankColor.withOpacity(0.6),
                bankColor,
                bankColor.withOpacity(1),
              ]),
              title: AppHelper.getInitials(card.cardName),
              radius: context.getDeviceHeight() * 0.1,
              titleStyle: context.getBoldColorTextStyle(15, Colors.white),
            );
          }).toList(),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
