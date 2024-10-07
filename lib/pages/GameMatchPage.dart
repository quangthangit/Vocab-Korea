import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'dart:math';
import 'dart:async';

class GameMatchPage extends StatefulWidget {
  final List<Map<String, String>> vocabularyList;

  GameMatchPage({required this.vocabularyList});

  @override
  _GameMatchState createState() => _GameMatchState();
}

class _GameMatchState extends State<GameMatchPage> with SingleTickerProviderStateMixin {
  late List<String> _listVocabulary;
  late List<bool> _selectedIndices; // Danh sách theo dõi ô nào được chọn
  late List<bool> _isCorrect; // Danh sách trạng thái đúng/sai cho các ô
  late AnimationController _controller; // Điều khiển animation rung lắc
  late Animation<double> _shakeAnimation; // Animation rung lắc
  int numberDone = 0;
  double _seconds =  0.0;

  bool _isRunning = false;// Biến để theo dõi trạng thái đồng hồ

  @override
  void initState() {
    super.initState();

    // Kiểm tra nếu widget.vocabularyList không null
    if (widget.vocabularyList.isNotEmpty) {
      _listVocabulary = handelList(widget.vocabularyList);
    } else {
      _listVocabulary = [""]; // Hoặc một giá trị mặc định khác
    }

    _startTimer();

    // Khởi tạo danh sách trạng thái
    _selectedIndices = List.generate(_listVocabulary.length, (index) => false);
    // Khởi tạo trạng thái đúng/sai
    _isCorrect = List.generate(_listVocabulary.length, (index) => false);

    // Khởi tạo animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Khởi tạo animation rung lắc
    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  // Hàm để bắt đầu Timer
  void _startTimer() {
    _isRunning = true; // Đánh dấu rằng đồng hồ đang chạy
    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      if (_isRunning) {
        setState(() {
          _seconds += 0.1; // Tăng số giây
        });
      } else {
        timer.cancel(); // Dừng Timer nếu đồng hồ không còn chạy
      }
    });
  }

  // Hàm để dừng Timer
  void _stopTimer() {
    setState(() {
      _isRunning = false; // Đánh dấu rằng đồng hồ đã dừng
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCardTap(int index) {
    setState(() {
      // Kiểm tra số lượng ô đã được chọn
      int selectedCount = _selectedIndices.where((isSelected) => isSelected).length;

      // Nếu ô đã được chọn, bỏ chọn ô đó
      if (_selectedIndices[index]) {
        _selectedIndices[index] = false; // Bỏ chọn ô
        // Nếu số ô đã chọn ít hơn 2, cho phép chọn ô này
      } else if (selectedCount < 2) {
        _selectedIndices[index] = true; // Chọn ô mới
      }

      // Nếu đã chọn 2 ô
      if (selectedCount == 1) { // Kiểm tra khi có 1 ô đã chọn
        List<int> numberSelected = checkNumberSelected(_selectedIndices);
        // Thực hiện kiểm tra nghĩa chỉ khi có 2 ô được chọn
        if (numberSelected.length == 2) {
          bool isCorrect = checkMeaning(
            _listVocabulary[numberSelected[0]],
            _listVocabulary[numberSelected[1]],
            widget.vocabularyList,
          );

          // Hiển thị thông báo
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isCorrect ? "ok" : "sai roi"),
              duration: Duration(seconds: 1),
            ),
          );

          if (!isCorrect) {
            // Bắt đầu animation rung lắc
            _controller.forward().then((value) {
              _controller.reverse();
            });

            // Đánh dấu trạng thái sai cho các ô
            _isCorrect[numberSelected[0]] = false; // Đánh dấu ô đầu tiên là sai
            _isCorrect[numberSelected[1]] = false; // Đánh dấu ô thứ hai là sai
          } else {
            // Đúng, đánh dấu trạng thái đúng và xóa các ô đã đúng
            _isCorrect[numberSelected[0]] = true; // Đánh dấu ô đầu tiên là đúng
            _isCorrect[numberSelected[1]] = true; // Đánh dấu ô thứ hai là đúng

            // Biến mất các ô đã chọn
            _listVocabulary[numberSelected[0]] = ""; // Hoặc dùng null nếu muốn ô không hiển thị
            _listVocabulary[numberSelected[1]] = ""; // Hoặc dùng null nếu muốn ô không hiển thị

            // Tăng số lượng ô đã trả lời đúng
            numberDone += 1;

            if (numberDone == 6) {
              _stopTimer(); // Dừng đồng hồ khi hoàn thành
              _showCompletionMessage(); // Hiển thị thông báo hoàn thành
            }
          }

          // Đặt lại trạng thái lựa chọn
          _selectedIndices = List<bool>.filled(_selectedIndices.length, false);
        }
      }
    });
  }

  void _showCompletionMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hoàn thành!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          content: Text("Bạn đã hoàn thành trò chơi trong ${_seconds.toStringAsFixed(1)} giây.", style: const TextStyle(fontSize: 16),),
          actions: <Widget>[
            TextButton(
              child: const Text("Kết thúc", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.of(context).pop();
                // Bạn có thể thêm logic để quay lại màn hình chính hoặc chơi lại
              },
            ),
          ],
        );
      },
    );
  }


  List<int> checkNumberSelected(List<bool> selectedIndices) {
    List<int> number = [];
    for (int i = 0; i < selectedIndices.length; i++) {
      if (selectedIndices[i]) {
        number.add(i);
      }
    }
    return number;
  }

  // Hàm kiểm tra nghĩa
  bool checkMeaning(String a, String b, List<Map<String, String>> vocabularyList) {
    for (var entry in vocabularyList) {
      if ((entry['korean'] == a && entry['vietnamese'] == b) ||
          (entry['korean'] == b && entry['vietnamese'] == a)) {
        return true;
      }
    }
    return false;
  }

  List<String> handelList(List<Map<String, String>> vocabularyList) {
    // tạo một list chỉ nhận tối đa 6 cặp từ vựng
    List<Map<String, String>> selectedWords;
    if (vocabularyList.length > 6) {
      // Trộn danh sách
      vocabularyList.shuffle(Random());
      // Lấy 6 phần tử đầu tiên
      selectedWords = vocabularyList.take(6).toList();
    } else {
      // Nếu ít hơn hoặc bằng 6 phần tử, giữ nguyên danh sách
      selectedWords = vocabularyList;
    }
    // Chuyển đổi thành danh sách chỉ chứa từ vựng tiếng Hàn
    List<String> koreanWords = selectedWords.map((item) => item['korean']!).toList();
    // Chuyển đổi thành danh sách chỉ chứa từ vựng tiếng Việt
    List<String> vietnameseWords = selectedWords.map((item) => item['vietnamese']!).toList();
    return koreanWords + vietnameseWords;
  }

  @override
  Widget build(BuildContext context) {
    double progress = (numberDone) / 6;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.iconColor, size: 40),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
             Expanded(
              child: Text(
                '${_seconds.toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style:  const TextStyle(
                  color: AppColors.iconColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.iconColor, size: 40),
              onPressed: () {
                // Hành động khi nhấn nút cài đặt
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Thanh tiến độ
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFD7DEE5),
            color: AppColors.iconColor,
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          // Thẻ từ vựng
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              itemCount: _listVocabulary.length, // Sử dụng độ dài của danh sách từ vựng
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Số cột
                childAspectRatio: 120 / 150,
              ),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    // Chỉ hiển thị ô nếu từ vựng không rỗng
                    if (_listVocabulary[index] != "") {
                      return Transform.translate(
                        offset: _isCorrect[index]
                            ? Offset.zero
                            : Offset(
                            _shakeAnimation.value *
                                (index % 2 == 0 ? 1 : -1),
                            0),
                        // Rung lắc qua lại
                        child: GestureDetector(
                          onTap: () => _onCardTap(index),
                          child: Container(
                            width: 120,
                            // Đặt chiều rộng cho từng ô
                            height: 150,
                            // Đặt chiều cao cho từng ô
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            // Khoảng cách giữa các ô
                            child: Card(
                              color: _selectedIndices[index]
                                  ? Color(0xFFBFC4FC)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: AppColors.iconColor, // Màu của border
                                  width: 1, // Độ dày của border
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                // Độ cong của góc
                              ),
                              child: Center(
                                child: Text(
                                  _listVocabulary[index],
                                  // Hiển thị từng từ trong danh sách
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(

                      ); // Không hiển thị gì nếu từ vựng đã được trả lời đúng
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
