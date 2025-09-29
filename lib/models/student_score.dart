import 'package:dart_hw_3/models/score.dart';

class StudentScore extends Score {
  final String name;
  String? grade;

  StudentScore(this.name, double score, [this.grade = ""]) : super(score);

  @override
  void show() {
    print("이름: $name, 점수: $score");
  }
}
