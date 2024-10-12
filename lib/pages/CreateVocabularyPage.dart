import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/widget/bar/CreateVocabularyBar.dart';

class CreateVocabularyPage extends StatefulWidget {
  const CreateVocabularyPage({super.key});

  @override
  _CreateVocabularyPageState createState() => _CreateVocabularyPageState();
}

class _CreateVocabularyPageState extends State<CreateVocabularyPage> {
  bool _showTextField = false;
  List<int> numberForms = [0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CreateVocabularyBar(),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Chủ đề, chương, đơn vị',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.backgroundColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.backgroundColor),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  'Tiêu đề',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF646363)),
                ),
              ),
              if (_showTextField)
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: const TextField(
                    decoration: InputDecoration(
                      labelText: 'Thông tin mô tả',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.backgroundColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.backgroundColor),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _showTextField = !_showTextField;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _showTextField ? '- Mô tả' : '+ Mô tả',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
          for (int i = 0; i < numberForms.length; i++)
            Dismissible(
              key: Key(numberForms[i].toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  numberForms.removeAt(i);
                });
              },
              background: Container(
                color: AppColors.background,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,size: 30,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                    width: 2,
                  ),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: const TextField(
                            decoration: InputDecoration(
                              labelText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.backgroundColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.backgroundColor),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: const Text(
                            'Thuật ngữ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Color(0xFF646363)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: const TextField(
                            decoration: InputDecoration(
                              labelText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.backgroundColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.backgroundColor),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: const Text(
                            'Định nghĩa',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Color(0xFF646363)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            numberForms.add(numberForms.length);
          });
        },
      ),
    );
  }
}
