import 'package:flutter/material.dart';
import 'package:np_vending_machine_app/models/drink.dart';
import 'package:np_vending_machine_app/screens/admin/widgets/drink_edit_bottom_sheet.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/change_status_box.dart';
import 'package:np_vending_machine_app/screens/vending/widgets/drink_grid_section.dart';
import 'package:np_vending_machine_app/storage/coin_store.dart';

class AdminBody extends StatefulWidget {
  const AdminBody({super.key});

  @override
  State<AdminBody> createState() => _AdminBodyState();
}

class _AdminBodyState extends State<AdminBody> {
  Map<int, int> changeStatus = {};

  List<Drink> drinks = [
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
    _loadChangeStatus();
  }

  Future<void> _loadChangeStatus() async {
    final coins = await CoinStore.loadCoins();
    setState(() {
      changeStatus = coins;
    });
  }

  void onSelectDrink(Drink drink) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => DrinkEditBottomSheet(
        drink: drink,
        onConfirm: (updatedDrink) {
          setState(() {
            drink.name = updatedDrink.name;
            drink.price = updatedDrink.price;
            drink.stock = updatedDrink.stock;
            drink.requested = updatedDrink.requested;
          });
        },
      ),
    );
  }

  Future<void> _handleCollect() async {
    for (final unit in CoinStore.coinUnits) {
      final current = changeStatus[unit] ?? 0;
      final keep = current > 10 ? 10 : current;
      await CoinStore.setCoin(unit, keep);
    }
    await _loadChangeStatus();
  }

  Future<void> _handleFill() async {
    for (final unit in CoinStore.coinUnits) {
      final current = changeStatus[unit] ?? 0;
      if (current < 10) {
        await CoinStore.setCoin(unit, 10);
      }
    }
    await _loadChangeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
        child: Column(
          children: [
            Expanded(
              child: DrinkGridSection(
                drinks: drinks,
                selectedDrink: null,
                onSelect: onSelectDrink,
                isAdmin: true,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ChangeStatusBox(status: changeStatus)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _handleCollect,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '수금하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 170,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _handleFill,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '채우기',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
