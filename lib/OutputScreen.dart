import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final String? username;
  final String? password;
  final String? email;
  final bool? rememberMe;
  final String? gender;
  final String? country;
  final double? age;
  final DateTime? selectedDate;

  const OutputScreen({
    super.key,
    this.username,
    this.password,
    this.email,
    this.rememberMe,
    this.gender,
    this.country,
    this.age,
    this.selectedDate,
  });

  static const Color primary = Color(0xFF1565C0);
  static const Color secondary = Color(0xFF42A5F5);
  static const Color background = Color(0xFFF3F8FF);
  static const Color textDark = Color(0xFF102A43);
  static const Color textLight = Color(0xFF627D98);

  String get formattedDate {
    if (selectedDate == null) return 'Not selected';
    return '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
  }

  @override
  Widget build(BuildContext context) {
    final List<_InfoItem> items = [
      _InfoItem(
        icon: Icons.person_outline,
        title: 'Username',
        value: username ?? 'Not entered',
      ),
      _InfoItem(
        icon: Icons.lock_outline,
        title: 'Password',
        value: password == null ? 'Not entered' : '******',
      ),
      _InfoItem(
        icon: Icons.email_outlined,
        title: 'Email',
        value: email ?? 'Not entered',
      ),
      _InfoItem(
        icon: Icons.bookmark_border,
        title: 'Remember Me',
        value: rememberMe == true ? 'Yes' : 'No',
      ),
      _InfoItem(
        icon: Icons.wc,
        title: 'Gender',
        value: gender ?? 'Not selected',
      ),
      _InfoItem(
        icon: Icons.public,
        title: 'Country',
        value: country ?? 'Not selected',
      ),
      _InfoItem(
        icon: Icons.cake_outlined,
        title: 'Age',
        value: '${age?.round() ?? 0} years',
      ),
      _InfoItem(
        icon: Icons.calendar_today_outlined,
        title: 'Selected Date',
        value: formattedDate,
      ),
    ];

    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 58, 24, 34),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary,
                  secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(34),
                bottomRight: Radius.circular(34),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Form Submitted',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Created by: Yousef Sbeitan',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 22,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    children: items.map((item) {
                      return _OutputTile(item: item);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      'Go Back',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });
}

class _OutputTile extends StatelessWidget {
  final _InfoItem item;

  const _OutputTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F3FB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7D9EF),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: OutputScreen.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              item.icon,
              color: OutputScreen.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: OutputScreen.textLight,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: const TextStyle(
                    color: OutputScreen.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}