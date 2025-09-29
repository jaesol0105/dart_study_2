import 'dart:convert';
import 'dart:io';

import 'package:dart_hw_3/models/student_score.dart';
import 'package:dart_hw_3/util.dart';

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
    final name = stdin.readLineSync(encoding: utf8)?.trim(); //입력 인코딩
    String result = "";

    // 해당 이름을 가진 모든 학생의 정보를 출력 (학번이 없기때문에,,)
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

void getTopStudents() {}
void getAverageAndMedian() {}
void getGradeDistribution() {}
void showMenu() {
  print("메뉴를 선택하세요 :");
  print("1. 특정 학생의 통계 확인");
  print("2. 우수생 출력");
  print("3. 전체 평균 점수 / 중앙값 출력");
  print("4. 성적 분포표 출력");
}
