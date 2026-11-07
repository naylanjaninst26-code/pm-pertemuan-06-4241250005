import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_pertemuan_06/destinasi.dart';

class DaftarDestinasi extends StatelessWidget {
  const DaftarDestinasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Sumatera Utara'),
        scrolledUnderElevation: 0,
      ),
      // LayoutBuilder mengukur ruang milik grid ini, bukan seluruh layar
      body: LayoutBuilder(
        builder: (context, constraints) {
          final kolom = switch (constraints.maxWidth) {
            < 600 => 2,
            < 900 => 3,
            _ => 4,
          };
          // builder: kartu dibuat hanya saat terlihat (lazy)
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kolom,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 215, // tinggi tetap tiap kartu
            ),
            itemCount: daftarDestinasi.length,
            itemBuilder: (context, i) =>
                KartuDestinasi(destinasi: daftarDestinasi[i]),
          );
        },
      ),
    );
  }
}

// Pil kecil berisi nama kategori, dipakai di kartu dan di sampul detail
class PilKategori extends StatelessWidget {
  const PilKategori({super.key, required this.teks});

  final String teks;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: warna.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        teks,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: warna.onSurface, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class KartuDestinasi extends StatelessWidget {
  const KartuDestinasi({super.key, required this.destinasi});

  final Destinasi destinasi;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    final (latar, isi) = destinasi.warnaKategori(warna);

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: warna.surfaceContainerLow,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        // go() pindah ke rute detail dengan id destinasi
        onTap: () => context.go('/destinasi/${destinasi.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // Stack: ikon di tengah, pil kategori menumpuk di pojok kiri atas
              child: Stack(
                children: [
                  Positioned.fill(child: ColoredBox(color: latar)),
                  Center(child: Icon(destinasi.ikon, size: 56, color: isi)),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: PilKategori(teks: destinasi.kategori),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destinasi.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: teks.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: warna.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destinasi.daerah,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: teks.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        destinasi.tiketTeks,
                        style: teks.labelLarge?.copyWith(
                          color: warna.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (destinasi.tiket > 0)
                        Flexible(
                          child: Text(
                            ' / orang',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: teks.bodySmall,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
