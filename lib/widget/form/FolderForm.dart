import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;

class AddFolderForm extends StatefulWidget {
  const AddFolderForm({super.key});

  @override
  _AddFolderFormState createState() => _AddFolderFormState();
}

class _AddFolderFormState extends State<AddFolderForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_sharp, size: 30),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Thư mục mới',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lobster',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: _controller.text.isNotEmpty ? () {

                } : null,
                child: Text(
                  'Tạo thư mục',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lobster',
                    color: _controller.text.isNotEmpty ? app_color.AppColors.backgroundColor : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Tiêu đề',
                      hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
