import 'package:flutter/material.dart';

import '../view/addpayment_page_view.dart';
import '../view/expenses_page_view.dart';
import '../view/person_page_view.dart';

class HomepageViewModel with ChangeNotifier{
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;



  late final ExpensesPageView _expansesPageView ;
  late final PersonPageView _personPageView;
  late final AddPaymentPageView _addPaymentPageView;
  late List<Widget> pages;


  HomepageViewModel(){
    _expansesPageView =  const ExpensesPageView();
    _personPageView = const PersonPageView();
    _addPaymentPageView = const AddPaymentPageView();
    pages = [_expansesPageView,_addPaymentPageView,_personPageView];
  }



  void changeSelectedIndex(int index){
    _selectedIndex = index;
    AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
      child: pages[_selectedIndex],
    );
    notifyListeners();
  }


  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}