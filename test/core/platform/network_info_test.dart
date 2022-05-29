import 'package:category_app_demo/core/platform/network_info.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;
  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo =
        NetworkInfoImpl(dataConnectionChecker: mockDataConnectionChecker);
  });
  group('isConnected', () {
    test('should forward the call to the data connection ', () async {
      //arrange
      final hasConnectionValue = Future.value(true);
      when(() => mockDataConnectionChecker.hasConnection)
          .thenAnswer((invocation) => hasConnectionValue);
      //act
      final result = networkInfo.isConnected;
      //assert
      verify(() => mockDataConnectionChecker.hasConnection);
      expect(result, hasConnectionValue);
      print(result);
      print(hasConnectionValue);
    });
  });
}
