
import 'package:flutter/material.dart';

void main() => runApp(const StarLinkAdmin());

const navy = Color(0xFF102A56);
const blue = Color(0xFF1769E0);
const bg = Color(0xFFF3F7FF);

class StarLinkAdmin extends StatelessWidget {
  const StarLinkAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StarLink Admin',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        scaffoldBackgroundColor: bg,
      ),
      home: const AdminHome(),
    );
  }
}

class Customer {
  String name;
  String phone;
  String email;

  Customer(this.name, this.phone, this.email);
}

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selected = 0;
  String search = '';
  final List<Customer> customers = [];

  final titles = [
    'لوحة التحكم',
    'إدارة الزبائن',
    'المؤسسات الناشئة',
    'إدارة الطلبات',
    'إدارة الخدمات',
    'التقارير',
    'الإعدادات',
  ];

  final icons = [
    Icons.dashboard,
    Icons.people,
    Icons.business,
    Icons.assignment,
    Icons.category,
    Icons.bar_chart,
    Icons.settings,
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
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          backgroundColor: navy,
          child: ListView(
            children: [
              const SizedBox(height: 35),
              const Icon(Icons.hub, color: Colors.white, size: 65),
              const Center(
                child: Text(
                  'STARLINK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: Colors.white24),
              for (int i = 0; i < titles.length; i++)
                ListTile(
                  leading: Icon(icons[i], color: Colors.white),
                  title: Text(
                    titles[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                  selected: selected == i,
                  selectedTileColor: Colors.white24,
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
            : selected == 1
                ? customerPage()
                : sectionPage(titles[selected], icons[selected]),
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
        const Text('نظرة عامة على منصة StarLink'),
        const SizedBox(height: 22),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            stat('الزبائن', '${customers.length}', Icons.people, blue),
            stat('المؤسسات', '0', Icons.business, Colors.teal),
            stat('الطلبات', '0', Icons.assignment, Colors.purple),
            stat('الخدمات', '0', Icons.category, Colors.green),
          ],
        ),
        const SizedBox(height: 25),
        Card(
          child: ListTile(
            leading: const Icon(Icons.people, color: blue),
            title: const Text('إدارة الزبائن'),
            subtitle: const Text('إضافة ومتابعة الزبائن'),
            trailing: const Icon(Icons.arrow_back_ios, size: 16),
            onTap: () => setState(() => selected = 1),
          ),
        ),
      ],
    );
  }

  Widget stat(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget customerPage() {
    final filtered = customers.where((c) =>
        c.name.toLowerCase().contains(search.toLowerCase()) ||
        c.phone.contains(search)).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن زبون بالاسم أو الهاتف',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (v) => setState(() => search = v),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
              ),
              onPressed: () => customerDialog(),
              icon: const Icon(Icons.person_add),
              label: const Text('إضافة زبون جديد'),
            ),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('لا يوجد زبائن حالياً'))
              : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final c = filtered[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 6),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFEAF2FF),
                          child: Icon(Icons.person, color: blue),
                        ),
                        title: Text(c.name),
                        subtitle: Text('${c.phone}\n${c.email}'),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              customerDialog(customer: c);
                            } else {
                              setState(() => customers.remove(c));
                            }
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text('تعديل'),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('حذف'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void customerDialog({Customer? customer}) {
    final nameController =
        TextEditingController(text: customer?.name ?? '');
    final phoneController =
        TextEditingController(text: customer?.phone ?? '');
    final emailController =
        TextEditingController(text: customer?.email ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(customer == null ? 'إضافة زبون' : 'تعديل بيانات الزبون'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الهاتف'),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty ||
                  phoneController.text.trim().isEmpty) {
                return;
              }

              setState(() {
                if (customer == null) {
                  customers.add(Customer(
                    nameController.text.trim(),
                    phoneController.text.trim(),
                    emailController.text.trim(),
                  ));
                } else {
                  customer.name = nameController.text.trim();
                  customer.phone = phoneController.text.trim();
                  customer.email = emailController.text.trim();
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

  Widget sectionPage(String title, IconData icon) {
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
            'سيتم تطوير وظائف هذا القسم في المرحلة القادمة',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
