import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widgets/custom_dialog.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final TextEditingController _habitNameController = TextEditingController();
  final List<String> _days = ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'];
  final Map<String, bool> _selectedDays = {
    'DOM': true,
    'SEG': true,
    'TER': true,
    'QUA': true,
    'QUI': true,
    'SEX': true,
    'SAB': false,
  };

  String _reminderTime = '10:00AM';
  bool _notificationsOn = false;

  Map<String, bool> _reminders = {
    '06:00 AM': false,
    '06:30 AM': false,
    '07:00 AM': false,
    '07:30 AM': false,
    '08:00 AM': false,
    '08:30 AM': false,
    '09:00 AM': false,
    '09:30 AM': false,
    '10:00 AM': false,
    '10:30 AM': false,
    '11:00 AM': false,
    '11:30 AM': false,
  };

  @override
  void initState() {
    super.initState();
    _loadReminderPrefs();
  }

  Future<void> _loadReminderPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var key in _reminders.keys) {
        _reminders[key] = prefs.getBool('reminder_$key') ?? false;
      }
    });
  }

  Future<void> _saveReminderPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in _reminders.entries) {
      await prefs.setBool('reminder_${entry.key}', entry.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF4ED),
      appBar: AppBar(
        title: const Text('Novo hábito'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _habitNameController,
                          decoration: const InputDecoration(
                            hintText: 'Nome do hábito',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_add_outlined),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('Frequência do hábito', style: TextStyle(fontWeight: FontWeight.bold)),
                            Spacer(),
                            Text('Customizar', style: TextStyle(color: Colors.orange)),
                            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.orange),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _days.map((day) {
                            final selected = _selectedDays[day]!;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedDays[day] = !selected),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: selected ? Colors.orange : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  day,
                                  style: TextStyle(color: selected ? Colors.white : Colors.black87),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Lembrete', style: TextStyle(fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: 10, minute: 0),
                            );
                            if (time != null) {
                              setState(() => _reminderTime = time.format(context));
                            }
                          },
                          child: Row(
                            children: [
                              Text(_reminderTime, style: const TextStyle(color: Colors.orange)),
                              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.orange),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Notificação', style: TextStyle(fontWeight: FontWeight.bold)),
                        Switch(
                          value: _notificationsOn,
                          onChanged: (val) => setState(() => _notificationsOn = val),
                          activeColor: Colors.deepPurple,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: const Text(
                        'Horários de Lembrete',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            children: _reminders.entries.map((entry) {
                              final time = entry.key;
                              final isOn = entry.value;
                              return GestureDetector(
                                onTap: () {
                                  setState(() => _reminders[time] = !isOn);
                                  _saveReminderPrefs();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isOn ? Colors.orange.shade100 : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isOn ? Colors.deepPurple : Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        time,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isOn ? Colors.deepPurple : Colors.black54,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        isOn ? 'On' : 'Off',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isOn ? Colors.deepPurple : Colors.black54,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _saveReminderPrefs,
                              icon: const Icon(Icons.alarm_add),
                              label: const Text('Salvar Lembretes'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage('assets/images/habitIcon.png'),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Comece um novo hábito',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Para adicionar um novo hábito clique abaixo:',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/footer_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => CustomSuccessDialog(
                      onCreateNew: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/habit');
                      },
                      onContinue: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                child: const Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFDF4ED),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navIcon('assets/images/home_icon.png',
               onTap: () => Navigator.pushNamed(context, '/habit')),
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

  Widget _navIcon(String path, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(path, width: 32, height: 32),
    );
  }
}
