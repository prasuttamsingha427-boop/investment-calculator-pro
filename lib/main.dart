
import 'package:flutter/material.dart';

void main() {
  runApp(const InvestmentApp());
}

class InvestmentApp extends StatelessWidget {
  const InvestmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Investment Calculator Pro',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF155EEF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class CalcInfo {
  final String title;
  final String subtitle;
  final String keyName;
  final IconData icon;
  final Color color;

  const CalcInfo(
    this.title,
    this.subtitle,
    this.keyName,
    this.icon,
    this.color,
  );
}

const calculators = [
  CalcInfo(
    'SIP Calculator',
    'Monthly investment',
    'sip',
    Icons.trending_up,
    Color(0xFF2563EB),
  ),
  CalcInfo(
    'SWP Calculator',
    'Monthly withdrawal',
    'swp',
    Icons.account_balance_wallet,
    Color(0xFF7C3AED),
  ),
  CalcInfo(
    'EMI Calculator',
    'Loan calculation',
    'emi',
    Icons.home_work,
    Color(0xFFEA580C),
  ),
  CalcInfo(
    'FD Calculator',
    'Fixed deposit',
    'fd',
    Icons.savings,
    Color(0xFF059669),
  ),
  CalcInfo(
    'RD Calculator',
    'Recurring deposit',
    'rd',
    Icons.calendar_month,
    Color(0xFFDB2777),
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.account_balance, color: Color(0xFF155EEF)),
            SizedBox(width: 10),
            Text(
              'Investment Pro',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF155EEF), Color(0xFF6038C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SMART MONEY PLANNING',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1.3,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Plan Your Future\nWith Smart Calculators',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Calculate your savings, investments and loans.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Our Calculators',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Choose a calculator to get started',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: calculators.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 13,
                mainAxisSpacing: 13,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final item = calculators[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CalculatorPage(info: item),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: item.color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            item.icon,
                            color: item.color,
                            size: 29,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Made with ❤️ for smarter financial planning',
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  final CalcInfo info;

  const CalculatorPage({super.key, required this.info});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late final List<TextEditingController> controllers;
  String result = '';
  String detail = '';
  bool calculated = false;

  List<String> get labels {
    switch (widget.info.keyName) {
      case 'sip':
        return [
          'Monthly Investment (₹)',
          'Expected Annual Return (%)',
          'Investment Period (Years)',
        ];
      case 'swp':
        return [
          'Initial Investment (₹)',
          'Monthly Withdrawal (₹)',
          'Expected Annual Return (%)',
          'Withdrawal Period (Years)',
        ];
      case 'emi':
        return [
          'Loan Amount (₹)',
          'Annual Interest Rate (%)',
          'Loan Period (Years)',
        ];
      case 'fd':
        return [
          'Deposit Amount (₹)',
          'Annual Interest Rate (%)',
          'Deposit Period (Years)',
        ];
      default:
        return [
          'Monthly Deposit (₹)',
          'Annual Interest Rate (%)',
          'Deposit Period (Years)',
        ];
    }
  }

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      labels.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double number(int index) {
    return double.tryParse(controllers[index].text.trim()) ?? 0;
  }

  String money(double value) {
    if (!value.isFinite) return '₹0';
    return '₹${value.toStringAsFixed(2)}';
  }

  void calculate() {
    if (controllers.any((c) => c.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final values = List.generate(controllers.length, number);

    if (values.any((v) => !v.isFinite || v <= 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid numbers greater than zero'),
        ),
      );
      return;
    }

    double invested = 0;
    double total = 0;
    String explanation = '';

    switch (widget.info.keyName) {
      case 'sip':
        final monthly = values[0];
        final rate = values[1] / 1200;
        final months = (values[2] * 12).round();

        invested = monthly * months;

        total = rate == 0
            ? invested
            : monthly *
                ((pow1(1 + rate, months) - 1) / rate);

        explanation = 'Estimated investment value';
        break;

      case 'swp':
        final initial = values[0];
        final withdrawal = values[1];
        final monthlyRate = values[2] / 1200;
        final months = (values[3] * 12).round();

        total = initial;

        for (int i = 0; i < months; i++) {
          total = total * (1 + monthlyRate) - withdrawal;
          if (total <= 0) {
            total = 0;
            break;
          }
        }

        invested = initial;
        explanation = 'Estimated remaining balance';
        break;

      case 'emi':
        final principal = values[0];
        final monthlyRate = values[1] / 1200;
        final months = (values[2] * 12).round();

        final emi = monthlyRate == 0
            ? principal / months
            : principal *
                monthlyRate *
                pow1(1 + monthlyRate, months) /
                (pow1(1 + monthlyRate, months) - 1);

        total = emi;
        invested = emi * months;
        explanation = 'Total repayment: ${money(invested)}';
        break;

      case 'fd':
        invested = values[0];
        final rate = values[1] / 100;
        final years = values[2];

        total = invested * pow1(1 + rate / 4, 4 * years);
        explanation = 'Estimated maturity value';
        break;

      case 'rd':
        final monthly = values[0];
        final rate = values[1] / 1200;
        final months = (values[2] * 12).round();

        invested = monthly * months;

        total = rate == 0
            ? invested
            : monthly *
                ((pow1(1 + rate, months) - 1) / rate);

        explanation = 'Estimated maturity value (monthly compounding)';
        break;
    }

    setState(() {
      result = widget.info.keyName == 'emi'
          ? money(total)
          : money(total);
      detail = explanation;
      calculated = true;
    });
  }

  void reset() {
    for (final controller in controllers) {
      controller.clear();
    }

    setState(() {
      result = '';
      detail = '';
      calculated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.info.title),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.info.color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.info.icon,
                    color: widget.info.color,
                    size: 38,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.info.title,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Enter your details below',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            ...List.generate(labels.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 17),
                child: TextField(
                  controller: controllers[index],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: labels[index],
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    prefixIcon: const Icon(Icons.edit),
                  ),
                ),
              );
            }),
            const SizedBox(height: 5),
            SizedBox(
              height: 53,
              child: FilledButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.calculate),
                label: const Text(
                  'Calculate Now',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                onPressed: reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ),
            if (calculated) ...[
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F7EF),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR RESULT',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF087443),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(detail),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              'Note: Results are estimates, not guaranteed returns. '
              'Actual bank and investment calculations may differ.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double pow1(double base, num exponent) {
  double answer = 1;
  for (int i = 0; i < exponent.toInt(); i++) {
    answer *= base;
  }
  return answer;
}
