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

  void _goToPreviousMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
    });
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: _goToPreviousMonth,
                          icon: const Icon(Icons.chevron_left)),
                      Text(selectedMonthStr,
                          style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pretendard')),
                      IconButton(
                          onPressed: _goToNextMonth,
                          icon: const Icon(Icons.chevron_right)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text('총 판매 금액',
                      style: TextStyle(fontSize: 16, fontFamily: 'Pretendard')),
                  Text(
                    '${NumberFormat('#,###').format(totalMonthlySales)}원',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Pretendard'),
                  ),
                  const SizedBox(height: 46),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '매출 등록일 선택',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pretendard',
                            color: Colors.grey[900]),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.grey,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black87,
                                    surface: Colors.white,
                                  ),
                                  datePickerTheme: const DatePickerThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                              selectedMonth =
                                  DateTime(picked.year, picked.month);
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedDateStr,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pretendard',
                                    color: Colors.grey[900]),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${NumberFormat('#,###').format(totalDailySales)}원',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Pretendard'),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dailySales.length,
                      itemBuilder: (context, index) {
                        final s = dailySales[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                s.drink.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pretendard',
                                    fontSize: 20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('${s.drink.price}원 × ${s.sold}개',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Pretendard')),
                                  Text('${s.total}원',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Pretendard',
                                          fontSize: 20)),
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
