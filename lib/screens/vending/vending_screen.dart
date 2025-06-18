import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/coin_drop_overlay.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/currency_input_section.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/drink_grid_section.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/change_status_box.dart';
import 'package:np_vending_machine_app/vending/vending_manager.dart';
import 'package:np_vending_machine_app/screens/utils/error_dialog.dart';

class VendingScreen extends StatefulWidget {
  static const routeName = '/vending';

  const VendingScreen({super.key});

  @override
  State<VendingScreen> createState() => _VendingScreenState();
}

class _VendingScreenState extends State<VendingScreen> {
  final VendingManager vendingManager = VendingManager();
  Drink? selectedDrink;
  Map<int, int> changeStatus = {};

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

  @override
  void initState() {
    super.initState();
    _loadInitialInventoryStatus();
  }

  void _loadInitialInventoryStatus() async {
    final status = await vendingManager.getInventoryStatus();
    setState(() {
      changeStatus = status;
    });
  }

  void insertMoney(int unit) {
    try {
      vendingManager.insert(unit);
      setState(() {});
    } catch (e) {
      _showAlert(e.toString());
    }
  }

  void _showCoinDrop(List<int> coins) {
    if (coins.isEmpty) return;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (_) => CoinDropOverlay(coins: coins),
    );
  }

  void handleRefund() {
    final refundQueue = vendingManager.refund();
    final list = refundQueue.toList();

    if (list.isNotEmpty) {
      _showCoinDrop(list); // 애니메이션으로 동전 내려오기
    }

    setState(() {});
  }

  void handlePurchase() async {
    if (selectedDrink == null) return;

    try {
      final change = await vendingManager.purchase(selectedDrink!.price);
      final list = change.toList();

      if (list.isNotEmpty) {
        _showCoinDrop(list);
      }

      final status = await vendingManager.getInventoryStatus();
      setState(() {
        changeStatus = status;
        selectedDrink = null;
      });
    } catch (e) {
      _showAlert(e.toString()); // 예외만 다이얼로그로 출력
    }
  }

  void _showAlert(String msg) {
    ErrorDialog.show(
      context,
      msg.replaceFirst('Exception: ', ''),
    );
  }

  void selectDrink(Drink drink) {
    setState(() {
      selectedDrink = drink;
    });
  }

  Widget buildCommonButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final insertedAmount = vendingManager.totalAmount;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrinkGridSection(
              drinks: drinks,
              selectedDrink: selectedDrink,
              onSelect: selectDrink,
            ),
            const SizedBox(height: 24),
            CurrencyInputSection(
              insertedAmount: insertedAmount,
              onInsertMoney: insertMoney,
              onRefund: handleRefund,
              onPurchase: handlePurchase,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ChangeStatusBox(status: changeStatus)),
                const SizedBox(width: 16),
                buildCommonButton('관리자 모드', () {
                  Navigator.pushNamed(context, '/admin');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
