import 'package:flutter/material.dart';

class LibraryBar extends StatefulWidget {
  const LibraryBar({super.key});

  @override
  _LibraryBarState createState() => _LibraryBarState();
}

class _LibraryBarState extends State<LibraryBar> {
  int _selectedIndex = 0; // Chỉ số của lựa chọn hiện tại

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thư viện',
                  style: TextStyle(fontSize: 25,fontFamily: 'Lobster')
              ),
              Icon(Icons.add),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildChoice(0, 'Học phần'),
              const SizedBox(width: 40,),
              _buildChoice(1, 'Thư mục'),
              const SizedBox(width: 40,),
              _buildChoice(2, 'Lớp học'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChoice(int index, String title) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 2,
            width: 40,
            color: isSelected ? Colors.blue : Colors.white,
          ),
        ],
      ),
    );
  }
}
