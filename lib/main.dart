import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_pertemuan_06/halaman_daftar.dart';
import 'package:pm_pertemuan_06/halaman_detail.dart';
import 'package:pm_pertemuan_06/halaman_tentang.dart';

void main() => runApp(const AplikasiWisata());

// Satu-satunya warna yang ditulis langsung: warna dasar (seed) untuk tema.
const warnaDasar = Color(0xFF1E7F74);

// Konfigurasi rute: cabang 0 untuk daftar dan detail, cabang 1 untuk tentang
final _router = GoRouter(
  initialLocation: '/',
  // URL yang tidak dikenal menampilkan halaman 404
  errorBuilder: (context, state) =>
      HalamanTidakDitemukan(pesan: 'Alamat ${state.uri} tidak ditemukan'),
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => KerangkaNavigasi(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DaftarDestinasi(),
              routes: [
                // Alamat lengkapnya /destinasi/:id, misalnya /destinasi/3
                GoRoute(
                  path: 'destinasi/:id',
                  builder: (context, state) => DetailDestinasi(
                    id: int.tryParse(state.pathParameters['id'] ?? ''),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tentang',
              builder: (context, state) => const Tentang(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class AplikasiWisata extends StatelessWidget {
  const AplikasiWisata({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wisata Sumatera Utara',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: warnaDasar),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: warnaDasar,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
    );
  }
}

// Kerangka navigasi: NavigationBar di layar sempit, NavigationRail di layar lebar
class KerangkaNavigasi extends StatelessWidget {
  const KerangkaNavigasi({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _pilih(int indeks) {
    // Menekan tab yang sedang aktif kembali ke halaman awal cabang itu
    shell.goBranch(indeks, initialLocation: indeks == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery mengukur seluruh layar atau jendela
    final lebar = MediaQuery.sizeOf(context).width;

    if (lebar >= 840) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: shell.currentIndex,
              onDestinationSelected: _pilih,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore),
                  label: Text('Destinasi'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: Text('Tentang'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: shell),
          ],
        ),
      );
    }

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: _pilih,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Destinasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}
