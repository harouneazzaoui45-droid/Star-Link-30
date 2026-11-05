
import 'package:flutter/material.dart';

void main() {
  runApp(const StarLinkAdmin());
}

const Color navy = Color(0xFF102A56);
const Color blue = Color(0xFF1769E8);
const Color bg = Color(0xFFF3F6FC);

class StarLinkAdmin extends StatelessWidget {
  const StarLinkAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StarLink Admin',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        fontFamily: 'Arial',
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
  int selectedIndex = 0;
  String search = '';

  final List<Map<String, String>> customers = [
    {'name': ' يانيس 'محمدphone': '0550000001', 'status': 'نشط'},
    {'name': 'بوجمعة سيد 'يوسفف'لي', 'phone': '0550000002', 'status': 'نشط'},
    {'name'لعياط عمادالدين خالد'', 'phone': '0550000003', 'status': 'معلق'},
  ];

  final List<Map<String, String>> businesses = [
    {'name': 'مؤسسة المستقبل', 'type':'تكنولوجيا'', 'status': 'مقبولة'},
    {'name': 'مؤسسة الإبداع', 'type':التطبيقية'', 'status': 'قيد المراجعة'},
    {'name': 'مؤسسة النجاح', 'type':بيولوجيا'', 'status': 'مقبولة'},
  ];

  final List<Map<String, String>> requests = [
    {'name': 'طلب خدمة إلكترونية', 'client': 'أحمد محمد', 'status': 'جديد'},
    {'name': 'طلب صيانة', 'client': 'محمد علي', 'status': 'قيد المعالجة'},
    {'name': 'طلب استشارة', 'client': 'يوسف خالد', 'status': 'مكتمل'},
  ];

  final List<String> titles = [
    'لوحة التحكم',
    'إدارة الزبائن',starlink_....1layat-"imad"
    
    'إدارة المؤسسات',
    'إدارة الطلبات',
  ];

  void addRecord() {
    final nameController = TextEditingController();
    final extraController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('إضافة ${selectedIndex == 1 ? "زبون" : selectedIndex == 2 ? "مؤسسة" : "طلب"}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'الاسم',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: extraController,
              decoration: InputDecoration(
                labelText: selectedIndex == 1
                    ?'ر0673739060''
                    : selectedIndex == 2
                        ? 'نوع النشاط'
                        : client/imad'                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty) return;

              setState(() {
                if (selectedIndex == 1) {
                  customers.add({
                    'name': nameController.text,
                    'phone': extraController.text,
                    'status': 'نشط',
                  });
                } else if (selectedIndex == 2) {
                  businesses.add({
                    'name': nameController.text,
                    'type': extraController.text,
                    'status': 'قيد المراجعة',
                  });
                } else if (selectedIndex == 3) {
                  requests.add({
                    'name': nameController.text,
                    'client': extraController.text,
                    'status': 'جديد',
                  });
                }
              });

              Navigator.pop(dialogContext);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
      search = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          title: Row(
            children: [
              const Icon(Icons.hub, size: 28),
              const SizedBox(width: 10),
              const Text(
                'StarLink',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.admin_panel_settings, size: 25),
              const SizedBox(width: 7),
              const Text('المدير', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: navy,
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hub, color: Colors.white, size: 45),
                    SizedBox(height: 10),
                    Text(
                      'StarLink Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'لوحة الإدارة المركزية',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              drawerItem(Icons.dashboard, 'لوحة التحكم', 0),
              drawerItem(Icons.people, 'الزبائن', 1),
              drawerItem(Icons.business, 'المؤسسات', 2),
              drawerItem(Icons.assignment, 'الطلبات', 3),
              const Divider(),
              const Spacer(),
              const ListTile(
                leading: Icon(Icons.info_outline, color: blue),
                title: Text('StarLink Version 1.0'),
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            dashboard(),
            customerPage(),
            businessPage(),
            requestPage(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: changePage,
          backgroundColor: Colors.white,
          indicatorColor: blue.withOpacity(0.13),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard, color: blue),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people, color: blue),
              label: 'الزبائن',
            ),
            NavigationDestination(
              icon: Icon(Icons.business_outlined),
              selectedIcon: Icon(Icons.business, color: blue),
              label: 'المؤسسات',
            ),
            NavigationDestination(
              icon: Icon(Icons.assignment_outlined),
              selectedIcon: Icon(Icons.assignment, color: blue),
              label: 'الطلبات',
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: selectedIndex == index ? blue : Colors.grey),
      title: Text(title),
      selected: selectedIndex == index,
      onTap: () {
        changePage(index);
        Navigator.pop(context);
      },
    );
  }

  Widget dashboard() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'مرحباً بك في StarLink 👋',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'إدارة ومتابعة المنصة من مكان واحد',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 22),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.35,
          children: [
            statCard('الزبائن', customers.length.toString(),
                Icons.people, blue),
            statCard('المؤسسات', businesses.length.toString(),
                Icons.business, Colors.deepPurple),
            statCard('الطلبات', requests.length.toString(),
                Icons.assignment, Colors.orange),
            statCard(
              'الطلبات الجديدة',
              requests.where((r) => r['status'] == 'جديد').length.toString(),
              Icons.notifications_active,
              Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'الإجراءات السريعة',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        quickAction(Icons.person_add, 'إضافة زبون', 1),
        quickAction(Icons.add_business, 'إضافة مؤسسة', 2),
        quickAction(Icons.post_add, 'إضافة طلب', 3),
        const SizedBox(height: 20),
        const Text(
          'آخر الطلبات',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...requests.reversed.take(3).map((r) => ListTile(
              tileColor: Colors.white,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE5EDFF),
                child: Icon(Icons.assignment, color: blue),
              ),
              title: Text(r['name']!),
              subtitle: Text(r['client']!),
              trailing: Text(
                r['status']!,
                style: const TextStyle(color: blue, fontSize: 12),
              ),
            )),
      ],
    );
  }

  Widget statCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 28),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget quickAction(IconData icon, String title, int index) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE8F0FF),
          child: Icon(icon, color: blue),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          changePage(index);
          if (index != 0) addRecord();
        },
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        onChanged: (value) => setState(() => search = value),
        decoration: InputDecoration(
          hintText: 'ابحث هنا...',
          prefixIcon: const Icon(Icons.search, color: blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget customerPage() {
    final filtered = customers.where((c) {
      return c['name']!.contains(search) ||
          c['phone']!.contains(search);
    }).toList();

    return Column(
      children: [
        searchBox(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final c = filtered[index];
              return recordCard(
                Icons.person,
                c['name']!,
                c['phone']!,
                c['status']!,
                index,
                customers,
              );
            },
          ),
        ),
        addButton('إضافة زبون جديد'),
      ],
    );
  }

  Widget businessPage() {
    final filtered = businesses.where((b) {
      return b['name']!.contains(search) ||
          b['type']!.contains(search);
    }).toList();

    return Column(
      children: [
        searchBox(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final b = filtered[index];
              return recordCard(
                Icons.business,
                b['name']!,
                b['type']!,
                b['status']!,
                index,
                businesses,
              );
            },
          ),
        ),
        addButton('إضافة مؤسسة جديدة'),
      ],
    );
  }

  Widget requestPage() {
    final filtered = requests.where((r) {
      return r['name']!.contains(search) ||
          r['client']!.contains(search);
    }).toList();

    return Column(
      children: [
        searchBox(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final r = filtered[index];
              return recordCard(
                Icons.assignment,
                r['name']!,
                r['client']!,
                r['status']!,
                index,
                requests,
                requestMode: true,
              );
            },
          ),
        ),
        addButton('إضافة طلب جديد'),
      ],
    );
  }

  Widget recordCard(
    IconData icon,
    String title,
    String subtitle,
    String status,
    int index,
    List<Map<String, String>> records, {
    bool requestMode = false,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE8F0FF),
          child: Icon(icon, color: blue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(subtitle),
            const SizedBox(height: 5),
            Text(
              'الحالة: $status',
              style: const TextStyle(color: blue, fontSize: 12),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            setState(() {
              if (value == 'delete') {
                records.removeAt(records.indexOf(
                  records.firstWhere((r) => r['name'] == title),
                ));
              } else if (value == 'approve') {
                records.firstWhere(
                  (r) => r['name'] == title,
                )['status'] = requestMode ? 'مكتمل' : 'مقبولة';
              } else if (value == 'pending') {
                records.firstWhere(
                  (r) => r['name'] == title,
                )['status'] = 'قيد المعالجة';
              }
            });
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'approve',
              child: Text('قبول / إكمال'),
            ),
            const PopupMenuItem(
              value: 'pending',
              child: Text('قيد المعالجة'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('حذف'),
            ),
          ],
        ),
      ),
    );
  }

  Widget addButton(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FilledButton.icon(
          onPressed: addRecord,
          icon: const Icon(Icons.add),
          label: Text(title),
          style: FilledButton.styleFrom(
            backgroundColor: blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}
