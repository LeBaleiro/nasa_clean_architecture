import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';

void main() {
  DateInputConverter dateInputConverter;

  setUp(() {
    dateInputConverter = DateInputConverter();
  });

  final tDateTimeString = '2020-11-01';
  test('should convert a datetime into a string with the correct format', () {
    final dateTime = DateTime(2020, 11, 01);

    final result = dateInputConverter.format(dateTime);

    expect(result, tDateTimeString);
  });
}
