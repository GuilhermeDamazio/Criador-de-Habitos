import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4ED),
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            _userCard(context),
            const SizedBox(height: 16),
            _statCard('Método de pagamento', Icons.credit_card, onTap: () {}),
            const SizedBox(height: 12),
            _statCard('Maior sequência', Icons.emoji_events, trailingText: '20 Dias'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFDF4ED),
        notchMargin: 6,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navIcon('assets/images/home_icon.png',
                  onTap: () => Navigator.pushNamed(context, '/habit')),
              const SizedBox(width: 40), 
              _navIcon('assets/images/settings.png',
                  onTap: () => Navigator.pushNamed(context, '/settings')),
              _navIcon('assets/images/icon.png',
                  onTap: () => Navigator.pushNamed(context, '/profile')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Admin',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text('Nome', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              DropdownButton<String>(
                value: 'Essa semana',
                items: const [
                  DropdownMenuItem(value: 'Hoje', child: Text('Hoje')),
                  DropdownMenuItem(value: 'Essa semana', child: Text('Essa semana')),
                  DropdownMenuItem(value: 'Esse mês', child: Text('Esse mês')),
                ],
                onChanged: (_) {},
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _metricBox(Icons.access_time, 'Total de horas trabalhadas', '18'),
              const SizedBox(width: 12),
              _metricBox(Icons.flag, 'Tarefas concluídas', '12'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _circleDay('7', '06/14', completed: true),
              _circleDay('0', '06/15', completed: false),
              _circleDay('6', '06/15', completed: true),
              _circleDay('5', '06/16', completed: true),
              _circleDay('4', '06/16', completed: true),
              _circleDay('9', '06/16', completed: true),
              _circleDay('10', 'Hoje', completed: true, highlight: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricBox(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.orange, size: 28),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _circleDay(String number, String date,
      {bool completed = false, bool highlight = false}) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: highlight
                ? Colors.deepPurple
                : (completed ? Colors.orange : Colors.grey.shade300),
          ),
          child: Text(
            number,
            style: TextStyle(
              color: highlight || completed ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget _statCard(String title, IconData icon,
      {VoidCallback? onTap, String? trailingText}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            ),
            if (trailingText != null)
              Text(trailingText, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(String path, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(path, width: 32, height: 32),
    );
  }
}
