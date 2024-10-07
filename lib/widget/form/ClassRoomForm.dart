import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;

class AddClassRoomForm extends StatefulWidget {
  const AddClassRoomForm({super.key});

  @override
  _AddClassRoomFormState createState() => _AddClassRoomFormState();
}

class _AddClassRoomFormState extends State<AddClassRoomForm> {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
                    'Iớp mới',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lobster',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: (_classNameController.text.isNotEmpty || _descriptionController.text.isNotEmpty) ? () {

                } : null,
                child: Icon(
                  Icons.check,
                  color: (_classNameController.text.isNotEmpty && _descriptionController.text.isNotEmpty)
                      ? app_color.AppColors.backgroundColor
                      : Colors.black,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: Expanded(
              child: Column(
                children: [
                  _buildTextField(_classNameController, 'Tên lớp', 'Môn học, khóa học, niêm học, v.v..'),
                  const SizedBox(height: 20),
                  _buildTextField(_descriptionController, 'Mô tả', 'Thông tin bổ sung'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: app_color.AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
