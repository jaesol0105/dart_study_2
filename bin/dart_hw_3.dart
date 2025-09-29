import 'dart:io';

import 'package:dart_hw_3/dart_hw_3.dart' as dart_hw_3;
import 'package:dart_hw_3/models/student_score.dart';
import 'package:dart_hw_3/students_grade.dart';
import 'package:collection/collection.dart';

void main(List<String> arguments) async {
  final data = await getStudentsFileData();
  List<StudentScore> students = []; // 전체 학생 성적 리스트
  Set<String> studentNames = {}; // 학생 이름 집합

  // Students 객체로 파싱
  for (var line in data.split('\n')) {
    try {
      var temp = line.split(',');
      var name = temp[0];
      var score = double.parse(temp[1]);
      students.add(StudentScore(name, score));
      studentNames.add(name);
    } catch (e) {
      print("잘못된 형식의 데이터");
      return;
    }
  }

  // 학생 데이터가 없거나 1명일 경우 종료
  if (studentNames.length < 2) {
    print("학생 데이터가 1명 이하입니다.");
    return;
  }

  // 학생별 평균 점수
  List<StudentScore> averages = [];
  for (var name in studentNames) {
    final matches = students.where((s) => s.name == name);
    final totalScore = matches.fold<double>(0.0, (sum, s) => sum + s.score);
    final count = matches.length;
    averages.add(StudentScore(name, totalScore / count));
  }
  /*
  for (var name in studentNames) {
    var totalScore = 0.0;
    var count = 0;
    for (var student in students) {
      if (student.name == name) {
        totalScore += student.score;
        count++;
      }
    }
    averages.add(StudentScore(name, totalScore / count));
  }
  */

  while (true) {
    showMenu();
    String? input = stdin.readLineSync();
    if (input != null && input.isNotEmpty) {
      int number = int.parse(input);
      switch (number) {
        case 1:
          showLine();
          var status = getStudentStatus(students);
          writeResultsToFile(status);
          break;
        case 2:
          showLine();
          showTopStudents(averages);
          break;
        case 3:
          showLine();
          showAverageAndMedian(averages);
          break;
        case 4:
          showLine();
          getGradeDistribution(averages);
          break;
        case 5:
          return;
        default:
          showLine();
          print("잘못된 입력입니다.");
          break;
      }
    }
  }
}
