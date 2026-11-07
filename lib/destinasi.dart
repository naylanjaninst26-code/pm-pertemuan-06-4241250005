import 'package:material_ui/material_ui.dart';

// Data satu destinasi wisata (semua field final, jadi bisa const)
class Destinasi {
  const Destinasi({
    required this.id,
    required this.nama,
    required this.daerah,
    required this.kategori,
    required this.deskripsi,
    required this.tiket,
    required this.ikon,
  });

  final int id;
  final String nama;
  final String daerah;
  final String kategori;
  final String deskripsi;
  final int tiket; // harga tiket masuk per orang, 0 berarti gratis
  final IconData ikon;

  // Contoh: Gratis atau Rp 25.000
  String get tiketTeks => tiket == 0 ? 'Gratis' : tiket.rupiah;
}

// Extension: menambah getter rupiah pada tipe int, misalnya 10000 menjadi Rp 10.000
extension FormatRupiah on int {
  String get rupiah {
    final teks = toString();
    final hasil = StringBuffer();
    for (var i = 0; i < teks.length; i++) {
      if (i > 0 && (teks.length - i) % 3 == 0) hasil.write('.');
      hasil.write(teks[i]);
    }
    return 'Rp $hasil';
  }
}

// Warna latar dan warna isi untuk tiap kategori, semuanya dari tema
extension WarnaDestinasi on Destinasi {
  (Color, Color) warnaKategori(ColorScheme warna) => switch (kategori) {
    'Sejarah' => (warna.tertiaryContainer, warna.onTertiaryContainer),
    'Pantai' => (warna.secondaryContainer, warna.onSecondaryContainer),
    _ => (warna.primaryContainer, warna.onPrimaryContainer),
  };
}

const daftarDestinasi = [
  Destinasi(
    id: 1,
    nama: 'Danau Toba',
    daerah: 'Samosir',
    kategori: 'Alam',
    deskripsi:
        'Danau vulkanik terbesar di Indonesia dengan air yang tenang dan '
        'pemandangan perbukitan di sekelilingnya. Di tengahnya ada Pulau '
        'Samosir, tempat kamu bisa mengenal budaya Batak, menginap di '
        'penginapan tepi danau, dan menikmati matahari terbenam.',
    tiket: 0,
    ikon: Icons.water,
  ),
  Destinasi(
    id: 2,
    nama: 'Air Terjun Sipiso-piso',
    daerah: 'Karo',
    kategori: 'Alam',
    deskripsi:
        'Air terjun tinggi di kawasan Tongging yang jatuh dari tebing ke '
        'arah Danau Toba. Dari titik pandangnya kamu bisa melihat lembah '
        'hijau yang luas dan hamparan danau di kejauhan.',
    tiket: 10000,
    ikon: Icons.water_drop,
  ),
  Destinasi(
    id: 3,
    nama: 'Gunung Sibayak',
    daerah: 'Karo',
    kategori: 'Alam',
    deskripsi:
        'Gunung berapi di dekat Berastagi yang cocok untuk pendaki pemula. '
        'Jalurnya tidak terlalu panjang, dan setelah turun kamu bisa '
        'berendam di pemandian air panas alami.',
    tiket: 15000,
    ikon: Icons.terrain,
  ),
  Destinasi(
    id: 4,
    nama: 'Bukit Lawang',
    daerah: 'Langkat',
    kategori: 'Alam',
    deskripsi:
        'Pintu masuk Taman Nasional Gunung Leuser di tepi Sungai Bahorok. '
        'Di sini kamu bisa trekking di hutan hujan dan melihat orangutan '
        'Sumatra di habitat aslinya.',
    tiket: 20000,
    ikon: Icons.pets,
  ),
  Destinasi(
    id: 5,
    nama: 'Istana Maimun',
    daerah: 'Medan',
    kategori: 'Sejarah',
    deskripsi:
        'Istana peninggalan Kesultanan Deli yang dibangun pada akhir abad '
        'ke-19. Bangunannya berwarna kuning khas Melayu dengan sentuhan '
        'gaya Timur Tengah dan Eropa, tepat di tengah kota Medan.',
    tiket: 10000,
    ikon: Icons.account_balance,
  ),
  Destinasi(
    id: 6,
    nama: 'Masjid Raya Al-Mashun',
    daerah: 'Medan',
    kategori: 'Sejarah',
    deskripsi:
        'Masjid bersejarah peninggalan Kesultanan Deli dengan kubah besar '
        'dan ornamen yang megah. Pengunjung boleh masuk di luar waktu '
        'ibadah dengan berpakaian sopan.',
    tiket: 0,
    ikon: Icons.mosque,
  ),
  Destinasi(
    id: 7,
    nama: 'Tangkahan',
    daerah: 'Langkat',
    kategori: 'Alam',
    deskripsi:
        'Kawasan hutan di pertemuan dua sungai yang terkenal dengan wisata '
        'gajah. Selain bertemu gajah, kamu bisa berendam di sungai dan '
        'menyusuri hutan dengan suasana yang tenang.',
    tiket: 25000,
    ikon: Icons.forest,
  ),
  Destinasi(
    id: 8,
    nama: 'Pantai Cermin',
    daerah: 'Serdang Bedagai',
    kategori: 'Pantai',
    deskripsi:
        'Pantai yang mudah dijangkau dari Medan, cocok untuk bersantai '
        'bersama keluarga. Sore hari adalah waktu terbaik untuk menikmati '
        'senja dan jajanan di pinggir pantai.',
    tiket: 10000,
    ikon: Icons.beach_access,
  ),
];
