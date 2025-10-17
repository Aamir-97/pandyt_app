import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pandyt - Aamir App',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.logout_outlined),
          onPressed: () async {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Local storage cleared!')),
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
          },
        ),
      ],
      // bottom: TabBar(
      //   tabs: [
      //     Tab(icon: Icon(Icons.cloud), text: 'Weather'),
      //     Tab(icon: Icon(Icons.list), text: 'To-Do List'),
      //   ],
      // ),
    );
  }
}
