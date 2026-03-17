import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelApp());
    expect(find.text('Explore'), findsOneWidget);
  });
}