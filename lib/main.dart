import 'package:flutter/material.dart';

void main() {
  runApp(const AlTabriApp());
}

class AlTabriApp extends StatelessWidget {
  const AlTabriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'التبري Server',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'sans',
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BFA6),
          brightness: Brightness.dark,
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    DashboardHome(),
    MikrotikPage(),
    CardsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'التبري Server',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          backgroundColor: const Color(0xFF161B22),
        ),
        body: pages[currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.router_outlined),
              selectedIcon: Icon(Icons.router),
              label: 'MikroTik',
            ),
            NavigationDestination(
              icon: Icon(Icons.confirmation_number_outlined),
              selectedIcon: Icon(Icons.confirmation_number),
              label: 'الكروت',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================
// الصفحة الرئيسية
// ===========================

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'لوحة التحكم',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'إدارة MikroTik والـ Hotspot من مكان واحد',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: StatusCard(
                  title: 'السيرفرات',
                  value: '0',
                  icon: Icons.router,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatusCard(
                  title: 'المتصلة',
                  value: '0',
                  icon: Icons.wifi,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: StatusCard(
                  title: 'الكروت',
                  value: '0',
                  icon: Icons.confirmation_number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatusCard(
                  title: 'المستخدمون',
                  value: '0',
                  icon: Icons.people,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          const Text(
            'اختصارات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ActionButton(
            icon: Icons.add_box,
            title: 'إضافة MikroTik',
            subtitle: 'إضافة جهاز جديد إلى التبري',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddMikrotikPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          ActionButton(
            icon: Icons.confirmation_number,
            title: 'إنشاء كروت',
            subtitle: 'إنشاء بطاقات Hotspot جديدة',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GenerateCardsPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          ActionButton(
            icon: Icons.print,
            title: 'طباعة الكروت',
            subtitle: 'طباعة البطاقات التي تم إنشاؤها',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('سيتم إضافة الطباعة الفعلية في الخطوة القادمة'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ===========================
// MikroTik
// ===========================

class MikrotikPage extends StatelessWidget {
  const MikrotikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'MikroTik',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF30363D),
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.router,
                size: 60,
                color: Colors.grey.shade500,
              ),
              const SizedBox(height: 12),
              const Text(
                'لا توجد أجهزة MikroTik',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'أضف جهاز MikroTik متصل بنفس الشبكة',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddMikrotikPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('إضافة جهاز'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ===========================
// إضافة MikroTik
// ===========================

class AddMikrotikPage extends StatefulWidget {
  const AddMikrotikPage({super.key});

  @override
  State<AddMikrotikPage> createState() => _AddMikrotikPageState();
}

class _AddMikrotikPageState extends State<AddMikrotikPage> {
  final nameController = TextEditingController();
  final ipController = TextEditingController(text: '10.10.10.1');
  final usernameController = TextEditingController(text: 'admin');
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    ipController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void saveRouter() {
    if (nameController.text.trim().isEmpty ||
        ipController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('أدخل اسم الجهاز وعنوان IP'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ بيانات MikroTik — سنضيف الاتصال الحقيقي لاحقًا'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة MikroTik'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'بيانات الجهاز',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم الجهاز',
                hintText: 'مثال: سيرفر القرية',
                prefixIcon: Icon(Icons.router),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: ipController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'عنوان IP',
                hintText: 'مثال: 10.10.10.1',
                prefixIcon: Icon(Icons.lan),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'اسم المستخدم',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 14),

            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                prefixIcon: const Icon(Icons.lock),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(
                    obscurePassword
                        ? Icons