import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/UserCompletionTimesModel.dart';
import 'package:vocabkpop/services/MatchGameResultService.dart';
import 'package:vocabkpop/widget/bar/ResultMatchBar.dart';

class ResultMatchPage extends StatefulWidget {
  final double seconds;
  final String idLesson;

  const ResultMatchPage({
    super.key,
    required this.seconds,
    required this.idLesson,
  });

  @override
  _ResultMatchPageState createState() => _ResultMatchPageState();
}

class _ResultMatchPageState extends State<ResultMatchPage> {
  List<UserCompletionTimesModel> topUsers = [];
  bool isLoading = true;
  late double score;

  @override
  void initState() {
    super.initState();
    _fetchTopUsers();
  }

  Future<void> _fetchTopUsers() async {
    MatchGameResultService service = MatchGameResultService();
    List<UserCompletionTimesModel> users = await service.getTop10FastestUsers(widget.idLesson);

    setState(() {
      topUsers = users;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: ResultMatchbar(submit: () {}, title: 'Ghép thẻ'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const LinearProgressIndicator(
              value: 100,
              backgroundColor: Color(0xFFD7DEE5),
              color: AppColors.iconColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    const Center(
                      child: Text(
                        'Hoàn thành trong',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '${widget.seconds.toStringAsFixed(1)} giây',
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'TOP 10 BẢNG XẾP HẠNG',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                      children: List.generate(
                        topUsers.length,
                            (index) => _buildRankingItem(index + 1, topUsers[index]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingItem(int rank, UserCompletionTimesModel user) {
    Color rankColor;
    if (rank == 1) {
      rankColor = Colors.red;
    } else if (rank == 2) {
      rankColor = Colors.amber;
    } else if (rank == 3) {
      rankColor = Colors.blue;
    } else {
      rankColor = Colors.grey;
    };
    Color colorUser;
    String checkUser;
    if(FirebaseAuth.instance.currentUser!.uid == user.idUser) {
      checkUser = "Bản thân";
      colorUser = Colors.blue;
    } else {
      checkUser = user.idUser;
      colorUser = Colors.black;
    }

    return Container(
      margin: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            color: rankColor,
            child: Text(
              '$rank',
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            '${user.userTimes.toStringAsFixed(1)} giây',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              children: [
                Icon(Icons.account_circle,color: colorUser,),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    checkUser,
                    style: TextStyle(
                      fontSize: 15,
                      color: colorUser,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

}
