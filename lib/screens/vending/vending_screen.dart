import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/currency_input_section.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/drink_grid_section.dart';

class VendingScreen extends StatefulWidget {
  static const routeName = '/vending';

  const VendingScreen({super.key});

  @override
  State<VendingScreen> createState() => _VendingScreenState();
}

class _VendingScreenState extends State<VendingScreen> {
  int insertedAmount = 0;
  Drink? selectedDrink;

  final List<Drink> drinks = [
    Drink(name: '믹스커피', price: 200, stock: 5),
    Drink(name: '고급믹스커피', price: 300, stock: 3),
    Drink(name: '물', price: 450, stock: 4),
    Drink(name: '캔커피', price: 500, stock: 2),
    Drink(name: '이온음료', price: 550, stock: 2),
    Drink(name: '고급캔커피', price: 700, stock: 2),
    Drink(name: '탄산음료', price: 750, stock: 1),
    Drink(name: '특화음료', price: 800, stock: 0),
  ];

  void insertMoney(int unit) {
    if (insertedAmount + unit <= 7000) {
      setState(() {
        insertedAmount += unit;
      });
    }
  }

  void refund() {
    setState(() {
      insertedAmount = 0;
      selectedDrink = null;
    });
  }

  void selectDrink(Drink drink) {
    setState(() {
      selectedDrink = drink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '자판기',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 32, 16, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrinkGridSection(
              drinks: drinks,
              selectedDrink: selectedDrink,
              onSelect: selectDrink,
            ),
            const SizedBox(height: 32),
            CurrencyInputSection(
              insertedAmount: insertedAmount,
              onInsertMoney: insertMoney,
              onRefund: refund,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                '관리자 페이지로 이동',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
