import 'package:material_ui/material_ui.dart';
import 'package:pm_pertemuan_06/destinasi.dart';

class Tentang extends StatelessWidget {
  const Tentang({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    // Angka dihitung otomatis dari data, jadi ikut berubah bila data bertambah
    final jumlahKategori = daftarDestinasi
        .map((d) => d.kategori)
        .toSet()
        .length;
    final jumlahDaerah = daftarDestinasi.map((d) => d.daerah).toSet().length;

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang'), scrolledUnderElevation: 0),
      body: Center(
        // Di layar lebar, isi dibatasi supaya tidak melebar berlebihan
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Sampul: Stack menumpuk ikon besar dan teks
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ColoredBox(color: warna.primaryContainer),
                      ),
                      Positioned(
                        right: -20,
                        bottom: -24,
                        child: Icon(
                          Icons.landscape,
                          size: 190,
                          color: warna.onPrimaryContainer.withValues(
                            alpha: 0.25,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wisata Sumatera Utara',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: teks.headlineMedium?.copyWith(
                                color: warna.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Alam, sejarah, dan pantai dalam satu aplikasi',
                              style: teks.bodyMedium?.copyWith(
                                color: warna.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Temukan tempat-tempat menarik di Sumatera Utara, dari Danau '
                'Toba yang megah, hutan Bukit Lawang, sampai istana dan masjid '
                'bersejarah di Medan. Buka tiap destinasi untuk melihat lokasi, '
                'harga tiket, dan ceritanya.',
                style: teks.bodyLarge?.copyWith(height: 1.6),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: KotakAngka(
                      angka: '${daftarDestinasi.length}',
                      label: 'Destinasi',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: KotakAngka(
                      angka: '$jumlahKategori',
                      label: 'Kategori',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: KotakAngka(angka: '$jumlahDaerah', label: 'Daerah'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Kotak kecil berisi satu angka besar dan labelnya
class KotakAngka extends StatelessWidget {
  const KotakAngka({super.key, required this.angka, required this.label});

  final String angka;
  final String label;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: warna.surfaceContainerLow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(
              angka,
              style: teks.headlineMedium?.copyWith(
                color: warna.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(label, style: teks.bodySmall),
          ],
        ),
      ),
    );
  }
}
