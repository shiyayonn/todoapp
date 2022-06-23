// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:todoapp/utils/valididators.dart';

void main() {

  const String testString = "I am a test String";
  const String emptyString = "";

  test("Should return null on non-empty String", () {
    expect(Validators.isEmpty(testString), null);
  });

  test("Should return 'Can\'t be empty' on empty string", () {
    expect(Validators.isEmpty(emptyString), "Can\'t be empty");
  });
}
