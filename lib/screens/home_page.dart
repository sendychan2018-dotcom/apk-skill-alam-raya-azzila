import 'package:alam_raya_azzila/models/user_model.dart';
import 'package:alam_raya_azzila/screens/login_page.dart';
import 'package:alam_raya_azzila/screens/profile_page.dart';
import 'package:flutter/material.dart';

const _forest = Color(0xFF087445);
const _deepForest = Color(0xFF075536);
const _canvas = Color(0xFFF4F8FB);

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const _tabs = [
    _HomeTab(),
    _PlayersTab(),
    _SkillsTab(),
    _NewsTab(),
    _ProfileTab(),
  ];

  void _openTab(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _canvas,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _selectedIndex, children: _tabs),
      ),
      bottomNavigationBar: NavigationBar(
        height: 68,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _openTab,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE2F4EA),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Pemain',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border_rounded),
            selectedIcon: Icon(Icons.star_rounded),
            label: 'Nilai',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article_rounded),
            label: 'Berita',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final home = context.findAncestorStateOfType<_HomePageState>()!;
    final username = home.widget.user.username;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _DashboardHeader(username: username)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const _SectionTitle(title: 'Home'),
              const SizedBox(height: 10),
              _TrainingBanner(
                onTap: () => _showMessage(context, 'Jadwal latihan'),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  _FeatureCard(
                    icon: Icons.groups_rounded,
                    title: 'Data Pemain',
                    color: const Color(0xFF13A36A),
                    onTap: () => home._openTab(1),
                  ),
                  const SizedBox(width: 10),
                  _FeatureCard(
                    icon: Icons.star_rounded,
                    title: 'Nilai Skill',
                    color: const Color(0xFFFF9D16),
                    onTap: () => home._openTab(2),
                  ),
                  const SizedBox(width: 10),
                  _FeatureCard(
                    icon: Icons.calendar_month_rounded,
                    title: 'Jadwal',
                    color: const Color(0xFF1388E8),
                    onTap: () => _showMessage(context, 'Jadwal latihan'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _FeatureCard(
                    icon: Icons.emoji_events_rounded,
                    title: 'Kompetisi',
                    color: const Color(0xFFFF9D16),
                    onTap: () => _showMessage(context, 'Kompetisi'),
                  ),
                  const SizedBox(width: 10),
                  _FeatureCard(
                    icon: Icons.article_rounded,
                    title: 'Berita',
                    color: const Color(0xFF1680B4),
                    onTap: () => home._openTab(3),
                  ),
                  const SizedBox(width: 10),
                  _FeatureCard(
                    icon: Icons.bar_chart_rounded,
                    title: 'Laporan',
                    color: const Color(0xFF13A36A),
                    onTap: () => home._openTab(2),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const _SectionTitle(title: 'Statistik Singkat'),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(
                    child: _StatisticCard(
                      icon: Icons.groups_rounded,
                      label: 'Total Pemain',
                      value: '32',
                      color: Color(0xFF13A36A),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _StatisticCard(
                      icon: Icons.person_rounded,
                      label: 'Pemain Aktif',
                      value: '28',
                      color: Color(0xFF1680E8),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  final String username;

  const _DashboardHeader({required this.username});

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari akun?'),
        content: const Text('Anda akan kembali ke halaman login.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (shouldLogout != true || !context.mounted) return;
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 13, 20, 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_forest, _deepForest],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 21,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: const Icon(Icons.person_rounded, color: Colors.white),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, ${_capitalize(username)} 👋',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'ADMIN',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showMessage(context, 'Tidak ada notifikasi baru'),
            tooltip: 'Notifikasi',
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => _confirmLogout(context),
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _TrainingBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _TrainingBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _deepForest,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 139,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('img/gambar1.jpg', fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.black.withValues(alpha: 0.12),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Latihan Hari Ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pukul 15.30 - 17.00',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    const Text(
                      'Lapangan SSB Alam Raya Azzila',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                bottom: 13,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_forward_rounded, color: _forest),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            height: 83,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 25, color: color),
                const SizedBox(height: 7),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF263238),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatisticCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, size: 19, color: color),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10)),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayersTab extends StatelessWidget {
  const _PlayersTab();

  static const _players = [
    ('Ahmad Fauzi', 'U-10 • No. 7', 'AF'),
    ('Bima Saputra', 'U-12 • No. 10', 'BS'),
    ('Cahya Ramadhan', 'U-14 • No. 11', 'CR'),
    ('Daffa Pratama', 'U-12 • No. 8', 'DP'),
    ('Fadil Maulana', 'U-8 • No. 5', 'FM'),
  ];

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      title: 'Data Pemain',
      child: Column(
        children: [
          _SearchBox(hint: 'Cari nama pemain...'),
          const SizedBox(height: 12),
          const Row(
            children: [
              _FilterChip(label: 'Semua', selected: true),
              _FilterChip(label: 'U-8'),
              _FilterChip(label: 'U-10'),
              _FilterChip(label: 'U-12'),
              _FilterChip(label: 'U-14'),
            ],
          ),
          const SizedBox(height: 10),
          for (final player in _players)
            _ListCard(
              leading: _PlayerAvatar(initials: player.$3),
              title: player.$1,
              subtitle: player.$2,
            ),
        ],
      ),
    );
  }
}

class _SkillsTab extends StatelessWidget {
  const _SkillsTab();

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      title: 'Perkembangan Skill',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ListCard(
            leading: const _PlayerAvatar(initials: 'AF'),
            title: 'Ahmad Fauzi',
            subtitle: 'U-10 • No. 7',
          ),
          const SizedBox(height: 18),
          const _SectionTitle(title: 'Rata-rata Nilai Skill'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                for (final skill in [
                  ('Passing', 80, const Color(0xFF128A52)),
                  ('Controlling', 75, const Color(0xFF1688E8)),
                  ('Dribbling', 70, const Color(0xFFFF9715)),
                  ('Heading', 65, const Color(0xFFAB67D5)),
                  ('Shooting', 60, const Color(0xFFF0477D)),
                ])
                  _SkillProgress(
                    label: skill.$1,
                    score: skill.$2,
                    color: skill.$3,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionTitle(title: 'Nilai Terakhir (Oktober 2025)'),
          const SizedBox(height: 10),
          const _ScoreSummary(),
        ],
      ),
    );
  }
}

class _NewsTab extends StatelessWidget {
  const _NewsTab();

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      title: 'Berita',
      child: Column(
        children: [
          const Row(
            children: [
              _FilterChip(label: 'Semua', selected: true),
              _FilterChip(label: 'SSB'),
              _FilterChip(label: 'Kompetisi'),
              _FilterChip(label: 'Kegiatan'),
            ],
          ),
          const SizedBox(height: 12),
          for (final item in [
            (
              'SSB Alam Raya Azzila Ikuti Turnamen Ramadhan Cup 2025',
              '10 Oktober 2025',
            ),
            (
              'Latihan Rutin Minggu Ini Fokus pada Teknik Passing',
              '7 Oktober 2025',
            ),
            ('Pengumuman Pendaftaran Siswa Baru 2026', '1 Oktober 2025'),
          ])
            _ListCard(
              leading: const _NewsThumbnail(),
              title: item.$1,
              subtitle: item.$2,
            ),
        ],
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      title: 'Profil',
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: Color(0xFFE8EEF2),
                  child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
                ),
                SizedBox(height: 10),
                Text(
                  'Admin Azzila',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text('Administrator', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          for (final entry in [
            ('Ubah Profil', Icons.person_outline),
            ('Ganti Password', Icons.lock_outline),
            ('Notifikasi', Icons.notifications_none),
            ('Tentang Aplikasi', Icons.info_outline),
          ])
            _ListCard(
              leading: Icon(entry.$2, color: _forest),
              title: entry.$1,
              showChevron: true,
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const ProfilePage()),
                (route) => route.isFirst,
              ),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Lihat detail profil'),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const _PageScaffold({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 17, 18, 17),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [_forest, _deepForest]),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(child: child),
        ),
      ],
    );
  }
}

class _ListCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final bool showChevron;

  const _ListCard({
    required this.leading,
    required this.title,
    this.subtitle,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SizedBox(width: 42, height: 42, child: Center(child: leading)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
          if (showChevron)
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF91A0A8)),
        ],
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  final String initials;

  const _PlayerAvatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFFD8EEE2),
      child: Text(
        initials,
        style: const TextStyle(
          color: _forest,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _NewsThumbnail extends StatelessWidget {
  const _NewsThumbnail();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Image.asset(
        'img/gambar1.jpg',
        width: 42,
        height: 42,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final String hint;

  const _SearchBox({required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded, size: 20),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _FilterChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _forest : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9,
            color: selected ? Colors.white : const Color(0xFF455A64),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF263238),
      ),
    );
  }
}

class _SkillProgress extends StatelessWidget {
  final String label;
  final int score;
  final Color color;

  const _SkillProgress({
    required this.label,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(Icons.sports_soccer_rounded, size: 17, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          SizedBox(
            width: 90,
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 6,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: const Color(0xFFE9EFF2),
              color: color,
            ),
          ),
          SizedBox(
            width: 34,
            child: Text(
              '$score',
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreSummary extends StatelessWidget {
  const _ScoreSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: Color(0xFFE1F4E9),
            child: Text(
              '74',
              style: TextStyle(
                color: _forest,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(child: Text('Rata-rata nilai skill')),
          Text(
            'Naik 8% ↗',
            style: TextStyle(
              color: _forest,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

String _capitalize(String value) {
  if (value.isEmpty) return value;
  return '${value[0].toUpperCase()}${value.substring(1)}';
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$message segera hadir'),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
