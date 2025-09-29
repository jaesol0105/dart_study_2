import 'package:dart_hw_3/dart_hw_3.dart' as dart_hw_3;
import 'package:dart_hw_3/models/student_score.dart';
import 'package:dart_hw_3/students_grade.dart';

void main(List<String> arguments) async {
  final data = await getStudentsFileData();
  List<StudentScore> students = [];

  // Students 객체로 파싱
  for (var line in data.split('\n')) {
    var temp = line.split(',');
    var name = temp[0];
    var score = double.parse(temp[1]);
    students.add(StudentScore(name, score));
  }

  var status = getStudentStatus(students);
  writeResultsToFile(status);
}
