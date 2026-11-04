
import 'package:flutter/material.dart';

void main() {
  runApp(const StarLinkAdmin());
}

const navy = Color(0xFF102A56);
const blue = Color(0xFF1769E0);
const background = Color(0xFFF3F7FF);

class StarLinkAdmin extends StatelessWidget {
  const StarLinkAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StarLink Admin',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
      ),
      home: const AdminHome(),
    );
  }
}

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selected = 0;

  final titles = [
    'لوحة التحكم',
    'إدارة الزبائن',
    'المؤسسات الناشئة',
    'إدارة الطلبات',
    'إدارة الخدمات',
    'التقارير والإحصائيات',
    'الإعدادات',
  ];

  final icons = [
    Icons.dashboard_rounded,
    Icons.people_alt_rounded,
    Icons.business_rounded,
    Icons.assignment_rounded,
    Icons.category_rounded,
    Icons.bar_chart_rounded,
    Icons.settings_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          title: const Text(
            'STARLINK ADMIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: navy,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 45),
              const Icon(
                Icons.hub_rounded,
                color: Colors.white,
                size: 65,
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'STARLINK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'لوحة الإدارة',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const Divider(color: Colors.white24, height: 35),
              for (int i = 0; i < titles.length; i++)
                ListTile(
                  selected: selected == i,
                  selectedTileColor: Colors.white24,
                  leading: Icon(icons[i], color: Colors.white),
                  title: Text(
                    titles[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    setState(() => selected = i);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
        body: selected == 0
            ? dashboard()
            : section(titles[selected], icons[selected]),
      ),
    );
  }

  Widget dashboard() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'مرحباً بك، أيها المدير 👋',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'إليك نظرة عامة على منصة StarLink',
          style: TextStyle(color: Colors.blueGrey),
        ),
        const SizedBox(height: 22),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: const [
            StatCard('الزبائن', '0', Icons.people, blue),
            StatCard('المؤسسات', '0', Icons.business, Color(0xFF008CBA)),
            StatCard('الطلبات', '0', Icons.assignment, Color(0xFF7155D9)),
            StatCard('الخدمات', '0', Icons.category, Color(0xFF159B83)),
          ],
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: navy.withOpacity(0.06),
                blurRadius: 15,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'مركز الإدارة',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 15),
              actionRow(Icons.verified_user, 'مراجعة المؤسسات', 2),
              actionRow(Icons.people, 'إدارة الزبائن', 1),
              actionRow(Icons.receipt_long, 'متابعة الطلبات', 3),
              actionRow(Icons.analytics, 'عرض التقارير', 5),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [navy, blue],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STARLINK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'منصة تربط الزبائن بالمؤسسات الناشئة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget actionRow(IconData icon, String title, int index) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFEAF2FF),
        child: Icon(icon, color: blue),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_back_ios, size: 15),
      onTap: () => setState(() => selected = index),
    );
  }

  Widget section(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: blue, size: 75),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'سيتم تجهيز وظائف هذا القسم',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard(
    this.title,
    this.value,
    this.icon,
    this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: navy.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, color: color, size: 30),
          Text(
            value,
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
