import 'dart:convert';
import 'dart:io';
import 'package:dart_hw_3/models/student_score.dart';
import 'package:dart_hw_3/util.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:statistics/statistics.dart';

Future<String> getStudentsFileData() async {
  try {
    return await File('assets/students.txt').readAsString();
  } catch (e) {
    print("파일 읽기 실패: $e");
    return "";
  }
}

String getStudentStatus(List<StudentScore> students) {
  while (true) {
    stdout.write("어떤 학생의 통계를 확인하시겠습니까? "); // 줄바꿈 없이 출력
    final name = stdin.readLineSync(encoding: utf8)?.trim(); // 입력 인코딩
    String result = "";

    // 해당 이름을 가진 학생의 모든 성적을 출력
    for (var student in students) {
      if (student.name == name) {
        var textMsg =
            "이름: ${student.name}, 점수: ${numberConverter(student.score)}";
        print(textMsg);
        result += "$textMsg\n";
      }
    }
    if (result.isNotEmpty) {
      return result;
    } else {
      print("잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.");
    }
  }
}

void writeResultsToFile(String txt) {
  try {
    File('assets/results.txt').writeAsStringSync(txt);
    print("저장이 완료되었습니다.");
  } catch (e) {
    print("파일 쓰기 실패: $e");
  }
}

void showTopStudents(List<StudentScore> averages) {
  final sorted = averages.sorted((a, b) => b.score.compareTo(a.score));
  final topScore = sorted.first.score; // 최고 점수
  final topStudents = sorted.where((s) => s.score == topScore);
  for (var student in topStudents) {
    print("우수생: ${student.name} (평균 점수: ${numberConverter(student.score)})");
  }
}

void showAverageAndMedian(List<StudentScore> averages) {
  final scores = averages.map((s) => s.score).toList();
  final avg = scores.sum / scores.length;
  print("전체 평균 점수: ${numberConverter(avg)}");
  double mid = scores.median as double;
  print("평균 중앙 값: ${numberConverter(mid)}");
}

void getGradeDistribution(List<StudentScore> averages) {
  final cutLines = {
    "a": (averages.length * 0.3).ceil() - 1,
    "b": (averages.length * 0.7).ceil() - 1,
  };
  final sorted = averages.sorted((a, b) => b.score.compareTo(a.score));

  // 동점자 고려한 커트라인
  final cutScores = {
    "a": sorted[cutLines["a"]!].score,
    "b": sorted[cutLines["b"]!].score,
  };

  for (var student in sorted) {
    if (student.score >= cutScores["a"]!) {
      student.grade = "A";
    } else if (student.score >= cutScores["b"]!) {
      student.grade = "B";
    } else {
      student.grade = "C";
    }
  }

  print("성적 분포표:");
  print(
    "A (상위 30%): ${sorted.where((s) => s.grade == "A").map((s) => s.name).join(", ")}",
  );
  print(
    "B (상위 70%): ${sorted.where((s) => s.grade == "B").map((s) => s.name).join(", ")}",
  );
  print(
    "C: ${sorted.where((s) => s.grade == "C").map((s) => s.name).join(", ")}",
  );
}

void showMenu() {
  showLine();
  print("메뉴를 선택하세요 :");
  print("1. 특정 학생의 성적 확인 / txt 내보내기");
  print("2. 우수생 출력");
  print("3. 전체 평균 점수 / 중앙값 출력");
  print("4. 성적 분포표 출력");
  print("5. 종료");
  stdout.write("입력: ");
}

void showLine() {
  print("------------------------------");
}
