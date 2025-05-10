import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4ED),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Configurações', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _profileCard(context),
            const SizedBox(height: 24),
            _sectionTitle('General'),
            _settingsTile(
              icon: Icons.notifications_active,
              title: 'Notificações',
              subtitle: 'Customizar notificações',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.tune,
              title: 'Mais customizações',
              subtitle: 'Altere as coisas para deixar do seu jeito',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _sectionTitle('Suporte'),
            _settingsTile(
              icon: Icons.contact_support,
              title: 'Contate-nos',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.feedback_outlined,
              title: 'Feedback',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Política de privacidade',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.info_outline,
              title: 'Sobre nós',
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
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

  Widget _profileCard(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/user_config.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Ver perfil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromARGB(255, 191, 179, 179),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'admin@gmail.com',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: const Text('Ver'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 8),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Colors.orange.shade50,
        child: Icon(icon, color: Colors.orange),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }

  Widget _navIcon(String path, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(path, width: 28, height: 28),
    );
  }
}
