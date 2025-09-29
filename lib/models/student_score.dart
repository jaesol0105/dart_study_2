import 'package:dart_hw_3/models/score.dart';

class StudentScore extends Score {
  final String name;

  StudentScore(this.name, double score) : super(score);

  @override
  void show() {
    print("이름: $name, 점수: $score");
  }
}
