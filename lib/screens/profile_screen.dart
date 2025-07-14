import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String _name = 'Jane Doe';
  String _email = 'jane@example.com';
  String _bio = 'Aspiring Sign Language Interpreter';
  double _progress = 0.65;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _editProfile() {
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController emailController = TextEditingController(text: _email);
    TextEditingController bioController = TextEditingController(text: _bio);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: bioController, decoration: const InputDecoration(labelText: 'Bio')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _name = nameController.text;
                _email = emailController.text;
                _bio = bioController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout?'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : const AssetImage('assets/images/default_profile.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.deepPurple),
                          onPressed: _pickImage,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(_name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(_email, style: const TextStyle(color: Colors.grey)),
                  Text(_bio, style: const TextStyle(fontStyle: FontStyle.italic)),
                  TextButton.icon(
                    onPressed: _editProfile,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Progress Section
            const Text('Overall Learning Progress', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: _progress, color: Colors.deepPurple),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text('Lessons: 45'),
                Text('Level: Intermediate'),
                Text('Streak: 5 days'),
              ],
            ),

            const SizedBox(height: 20),

            // Learning Stats
            const Text('Learning Stats', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatCard(label: 'Signs', count: '120', icon: Icons.gesture),
                _StatCard(label: 'Sessions', count: '32', icon: Icons.videocam),
                _StatCard(label: 'Time', count: '6h', icon: Icons.timer),
              ],
            ),

            const SizedBox(height: 20),

            // Achievements
            const Text('Achievements & Badges', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _badge('Beginner'),
                  _badge('Daily Streak 5x'),
                  _badge('Level Up'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings
            const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Dark Theme'),
              value: false,
              onChanged: (_) {},
              secondary: const Icon(Icons.dark_mode),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('ASL'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('Accessibility'),
              onTap: () {},
            ),

            const SizedBox(height: 20),

            // Support & Logout
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & FAQ'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Send Feedback'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _showLogoutDialog,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String count;
  final IconData icon;

  const _StatCard({required this.label, required this.count, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.deepPurple.withOpacity(0.2),
          child: Icon(icon, color: Colors.deepPurple),
        ),
        const SizedBox(height: 6),
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }
}

Widget _badge(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
  );
}
