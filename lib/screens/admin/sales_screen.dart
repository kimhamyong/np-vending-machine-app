import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:np_vending_machine_app/models/drink.dart';
import 'package:np_vending_machine_app/models/sales.dart';
import 'package:np_vending_machine_app/screens/admin/widgets/admin_bottom_nav_bar.dart';

class SalesScreen extends StatefulWidget {
  static const routeName = '/sales';

  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  DateTime selectedMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  final List<Sales> salesData = [
    Sales(
        drink: Drink(name: '돈까', price: 100000, stock: 3),
        sold: 2,
        date: DateTime.now()),
    Sales(
        drink: Drink(name: '테스트3', price: 10000, stock: 10),
        sold: 5,
        date: DateTime.now()),
    Sales(
        drink: Drink(name: '메뉴명22', price: 10000, stock: 1),
        sold: 0,
        date: DateTime.now().subtract(const Duration(days: 1))),
    Sales(
        drink: Drink(name: '양파숲', price: 10000, stock: 8),
        sold: 3,
        date: DateTime.now()),
    Sales(
        drink: Drink(name: 'ㅎㅍ', price: 899, stock: 4),
        sold: 1,
        date: DateTime.now()),
    Sales(
        drink: Drink(name: '가나', price: 5000, stock: 9),
        sold: 2,
        date: DateTime.now()),
  ];

  int get totalMonthlySales => salesData
      .where((s) =>
          s.date.year == selectedMonth.year &&
          s.date.month == selectedMonth.month)
      .fold(0, (sum, s) => sum + s.total);

  List<Sales> get dailySales => salesData
      .where((s) =>
          s.date.year == selectedDate.year &&
          s.date.month == selectedDate.month &&
          s.date.day == selectedDate.day)
      .toList();

  int get totalDailySales => dailySales.fold(0, (sum, s) => sum + s.total);

  Future<void> _selectMonth(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: '월 선택',
    );

    if (picked != null) {
      setState(() {
        selectedMonth = DateTime(picked.year, picked.month, 1);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedMonth = DateTime(picked.year, picked.month, 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String selectedMonthStr =
        DateFormat('yyyy년 M월').format(selectedMonth);
    final String selectedDateStr =
        DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '매출',
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedMonthStr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('총 판매 금액', style: TextStyle(fontSize: 16)),
                  Text(
                    '${NumberFormat('#,###').format(totalMonthlySales)}원',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _selectMonth(context),
                        child: const Text('월 선택'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('일 선택'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (dailySales.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$selectedDateStr 총 매출: ${NumberFormat('#,###').format(totalDailySales)}원',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dailySales.length,
                      itemBuilder: (context, index) {
                        final s = dailySales[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(s.drink.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('${s.drink.price}원 × ${s.sold}개',
                                      style: const TextStyle(fontSize: 14)),
                                  Text('${s.total}원',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AdminBottomNavBar(),
    );
  }
}
