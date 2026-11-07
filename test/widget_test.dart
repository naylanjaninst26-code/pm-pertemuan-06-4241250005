import 'package:flutter_test/flutter_test.dart';
import 'package:pm_pertemuan_06/main.dart';

void main() {
  testWidgets('Membuka detail destinasi dari grid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AplikasiWisata());
    await tester.pumpAndSettle();

    // Halaman daftar tampil dan memuat destinasi pertama
    expect(find.text('Danau Toba'), findsOneWidget);

    // Ketuk kartu Danau Toba, halaman detail terbuka
    await tester.tap(find.text('Danau Toba'));
    await tester.pumpAndSettle();

    expect(find.text('Tiket masuk'), findsOneWidget);
    expect(find.text('Lokasi'), findsOneWidget);
  });
}
