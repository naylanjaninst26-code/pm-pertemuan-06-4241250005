import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_pertemuan_06/destinasi.dart';
import 'package:pm_pertemuan_06/halaman_daftar.dart';

class DetailDestinasi extends StatelessWidget {
  const DetailDestinasi({super.key, required this.id});

  final int? id; // null bila bagian :id di URL bukan angka

  @override
  Widget build(BuildContext context) {
    // Cari destinasi dengan id itu; hasilnya null bila tidak ada
    final destinasi = daftarDestinasi.where((d) => d.id == id).firstOrNull;

    if (destinasi == null) {
      return const HalamanTidakDitemukan(pesan: 'Destinasi tidak ditemukan');
    }

    return Scaffold(
      appBar: AppBar(title: Text(destinasi.nama), scrolledUnderElevation: 0),
      // LayoutBuilder mengukur ruang milik halaman ini
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 700) {
            // Lebar: dua kolom, sampul di kiri dan info di kanan
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SampulDestinasi(destinasi: destinasi),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(8, 24, 24, 24),
                    child: InfoDestinasi(destinasi: destinasi),
                  ),
                ),
              ],
            );
          }

          // Sempit: satu kolom, sampul di atas dan info di bawah
          return ListView(
            children: [
              SizedBox(
                height: 240,
                child: SampulDestinasi(destinasi: destinasi),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InfoDestinasi(destinasi: destinasi),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Sampul: ikon besar, pil kategori, dan nama ditumpuk dengan Stack
class SampulDestinasi extends StatelessWidget {
  const SampulDestinasi({super.key, required this.destinasi});

  final Destinasi destinasi;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    final (latar, isi) = destinasi.warnaKategori(warna);

    return Stack(
      children: [
        Positioned.fill(child: ColoredBox(color: latar)),
        // Ikon besar di pojok kanan bawah, sebagian keluar bingkai dan terpotong
        Positioned(
          right: -20,
          bottom: -24,
          child: Icon(
            destinasi.ikon,
            size: 180,
            color: isi.withValues(alpha: 0.25),
          ),
        ),
        Positioned(
          top: 16,
          left: 20,
          child: PilKategori(teks: destinasi.kategori),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: Text(
            destinasi.nama,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: teks.headlineMedium?.copyWith(
              color: isi,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class InfoDestinasi extends StatelessWidget {
  const InfoDestinasi({super.key, required this.destinasi});

  final Destinasi destinasi;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: KotakInfo(
                ikon: Icons.location_on,
                label: 'Lokasi',
                nilai: destinasi.daerah,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: KotakInfo(
                ikon: Icons.confirmation_number,
                label: 'Tiket masuk',
                nilai: destinasi.tiketTeks,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('Tentang tempat ini', style: teks.titleLarge),
        const SizedBox(height: 8),
        Text(destinasi.deskripsi, style: teks.bodyLarge?.copyWith(height: 1.6)),
      ],
    );
  }
}

// Kotak kecil berisi ikon, label, dan nilai
class KotakInfo extends StatelessWidget {
  const KotakInfo({
    super.key,
    required this.ikon,
    required this.label,
    required this.nilai,
  });

  final IconData ikon;
  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: warna.surfaceContainerLow,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: warna.primaryContainer,
              child: Icon(ikon, size: 18, color: warna.onPrimaryContainer),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: teks.bodySmall,
                  ),
                  Text(
                    nilai,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: teks.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
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

// Halaman 404: dipakai untuk URL yang salah dan untuk id yang tidak ada
class HalamanTidakDitemukan extends StatelessWidget {
  const HalamanTidakDitemukan({
    super.key,
    this.pesan = 'Halaman tidak ditemukan',
  });

  final String pesan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.explore_off, size: 64),
              const SizedBox(height: 16),
              Text(
                pesan,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/'),
                child: const Text('Kembali ke daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
