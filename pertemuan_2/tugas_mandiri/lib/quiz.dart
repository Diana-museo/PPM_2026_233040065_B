import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const TugasMandiri());
}

// ============================================================
// HELPER FUNCTION
// ============================================================
Future<Uint8List?> pickImageAsBytes() async {
  final picker = ImagePicker();
  final xfile = await picker.pickImage(source: ImageSource.gallery);
  if (xfile == null) return null;
  return await xfile.readAsBytes();
}

// ============================================================
// MODEL
// ============================================================
class ProfileData {
  String name;
  String bio;
  String education;
  String hobby;
  String contact;
  List<String> skills;
  Uint8List? profileImage;

  ProfileData({
    this.name = 'Emeralda Iffatud Diana',
    this.bio =
    'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan pengembangan aplikasi mobile.',
    this.education = 'Universitas Pasundan — Semester 5\nIPK: 3.95',
    this.hobby =
    'Coding • Membaca • Fotografi • Game • Melukis • Menyanyi • Bikin meme',
    this.contact = 'emeralda.dianaxxiv@gmail.com\n+62 896-3826-8193',
    List<String>? skills,
    this.profileImage,
  }) : skills = skills ?? ['PHP', 'Java', 'Python', 'Flutter', 'UI/UX'];
}

class ExperienceData {
  String title;
  String description;
  Uint8List? image;

  ExperienceData({
    required this.title,
    required this.description,
    this.image,
  });
}

// ============================================================
// APP
// ============================================================
class TugasMandiri extends StatelessWidget {
  const TugasMandiri({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

// ============================================================
// PROFILE PAGE
// ============================================================
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileData _profile = ProfileData();
  final List<ExperienceData> _experiences = [];

  void _openEditProfile() async {
    final updated = await Navigator.push<ProfileData>(
      context,
      MaterialPageRoute(builder: (_) => EditProfilePage(profile: _profile)),
    );
    if (updated != null) setState(() => _profile = updated);
  }

  void _openUploadExperience() async {
    final newExp = await Navigator.push<ExperienceData>(
      context,
      MaterialPageRoute(builder: (_) => const UploadExperiencePage()),
    );
    if (newExp != null) setState(() => _experiences.add(newExp));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE8F3),
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: const Color(0xFFA7BCD1),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFDDE8F3),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF6887A6)),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const GalleryHome()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text('Upload Pengalaman'),
              onTap: () {
                Navigator.pop(context);
                _openUploadExperience();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content:
                    const Text('Halaman pengaturan sedang dalam perbaikan.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK',
                            style: TextStyle(color: Color(0xFF6887A6))),
                      ),
                    ],
                  ),
                );
              },
            ),
            const ListTile(
                leading: Icon(Icons.info), title: Text('About')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    backgroundImage: _profile.profileImage != null
                        ? MemoryImage(_profile.profileImage!)
                        : const AssetImage('assets/photo.jpeg')
                    as ImageProvider,
                  ),
                  const SizedBox(height: 12),
                  Text(_profile.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Mahasiswa Teknik Informatika',
                      style: TextStyle(
                          fontSize: 14, color: Colors.grey.shade600)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _StatBox(label: 'Post', value: '12')),
                Expanded(child: _StatBox(label: 'Teman', value: '128')),
                Expanded(child: _StatBox(label: 'Like', value: '1.2K')),
              ],
            ),
            const SizedBox(height: 24),

            _SectionCard(
                icon: Icons.info_outline,
                title: 'About Me',
                content: _profile.bio),
            _SectionCard(
                icon: Icons.school,
                title: 'Education',
                content: _profile.education),
            _SectionCard(
                icon: Icons.favorite,
                title: 'Hobby & Interest',
                content: _profile.hobby),
            _SectionCard(
                icon: Icons.email,
                title: 'Contact',
                content: _profile.contact),

            // Skills Card
            Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFF6887A6), size: 28),
                        SizedBox(width: 16),
                        Text('Skills',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _profile.skills
                          .map((s) => Chip(
                        label: Text(s),
                        backgroundColor: const Color(0xFFE2ECF6),
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Pengalaman Card
            if (_experiences.isNotEmpty)
              Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.book,
                              color: Color(0xFF6887A6), size: 28),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text('Pengalaman',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6887A6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_experiences.length}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ..._experiences.map(
                            (exp) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: exp.image != null
                                    ? Image.memory(exp.image!,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover)
                                    : Container(
                                  width: 64,
                                  height: 64,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.image,
                                      color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(exp.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(exp.description,
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openEditProfile,
        label: const Text('Edit'),
        icon: const Icon(Icons.edit),
        backgroundColor: const Color(0xFF6887A6),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFC6D6E6),
        selectedIndex: 1,
        onDestinationSelected: (_) {},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(
              icon: Icon(Icons.message), label: 'Message'),
          NavigationDestination(
              icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

// ============================================================
// EDIT PROFILE PAGE
// ============================================================
class EditProfilePage extends StatefulWidget {
  final ProfileData profile;
  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _bioCtrl;
  late TextEditingController _educationCtrl;
  late TextEditingController _hobbyCtrl;
  late TextEditingController _contactCtrl;
  late TextEditingController _skillsCtrl;
  Uint8List? _pickedImage;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _nameCtrl = TextEditingController(text: p.name);
    _bioCtrl = TextEditingController(text: p.bio);
    _educationCtrl = TextEditingController(text: p.education);
    _hobbyCtrl = TextEditingController(text: p.hobby);
    _contactCtrl = TextEditingController(text: p.contact);
    _skillsCtrl = TextEditingController(text: p.skills.join(', '));
    _pickedImage = p.profileImage;
  }

  @override
  void dispose() {
    for (final c in [
      _nameCtrl,
      _bioCtrl,
      _educationCtrl,
      _hobbyCtrl,
      _contactCtrl,
      _skillsCtrl
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickImage() async {
    final bytes = await pickImageAsBytes();
    if (bytes != null) setState(() => _pickedImage = bytes);
  }

  void _save() {
    final updated = ProfileData(
      name: _nameCtrl.text.trim(),
      bio: _bioCtrl.text.trim(),
      education: _educationCtrl.text.trim(),
      hobby: _hobbyCtrl.text.trim(),
      contact: _contactCtrl.text.trim(),
      skills: _skillsCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      profileImage: _pickedImage,
    );
    Navigator.pop(context, updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE8F3),
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: const Color(0xFFA7BCD1),
        actions: [
          TextButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.check, color: Colors.white),
            label:
            const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Foto Profil
            Center(
              child: Column(
                children: [
                  const Text('Foto Profil',
                      style: TextStyle(
                          color: Color(0xFF6887A6),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _pickedImage != null
                            ? MemoryImage(_pickedImage!)
                            : const AssetImage('assets/photo.jpeg')
                        as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF6887A6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library, size: 16),
                    label: const Text('Ganti Foto dari Galeri'),
                  ),
                ],
              ),
            ),
            const Divider(height: 32),

            const Text('Informasi Profil',
                style: TextStyle(
                    color: Color(0xFF6887A6),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildField(_nameCtrl, 'Nama Lengkap *', Icons.person),
            const SizedBox(height: 12),
            _buildField(_bioCtrl, 'Bio / Tentang', Icons.info_outline,
                maxLines: 3),
            const SizedBox(height: 12),
            _buildField(_educationCtrl, 'Pendidikan', Icons.school,
                maxLines: 2),
            const SizedBox(height: 12),
            _buildField(
                _hobbyCtrl, 'Hobby & Interest', Icons.favorite,
                maxLines: 2),
            const SizedBox(height: 12),
            _buildField(_contactCtrl, 'Kontak', Icons.email, maxLines: 2),
            const SizedBox(height: 12),
            _buildField(_skillsCtrl, 'Skills (pisah koma)', Icons.star),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Perubahan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6887A6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      TextEditingController ctrl, String label, IconData icon,
      {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF6887A6)),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

// ============================================================
// UPLOAD PENGALAMAN PAGE (BONUS)
// ============================================================
class UploadExperiencePage extends StatefulWidget {
  const UploadExperiencePage({super.key});

  @override
  State<UploadExperiencePage> createState() => _UploadExperiencePageState();
}

class _UploadExperiencePageState extends State<UploadExperiencePage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final bytes = await pickImageAsBytes();
    if (bytes != null) setState(() => _image = bytes);
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul wajib diisi!')),
      );
      return;
    }
    Navigator.pop(
      context,
      ExperienceData(
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        image: _image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDDE8F3),
      appBar: AppBar(
        title: const Text('Upload Pengalaman'),
        backgroundColor: const Color(0xFFA7BCD1),
        actions: [
          TextButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save, color: Colors.white),
            label:
            const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEF8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: const Color(0xFF6887A6), width: 1.5),
                ),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(_image!,
                      fit: BoxFit.cover,
                      width: double.infinity),
                )
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate,
                        size: 48, color: Color(0xFF6887A6)),
                    SizedBox(height: 8),
                    Text('Ketuk untuk pilih gambar',
                        style:
                        TextStyle(color: Color(0xFF6887A6))),
                    Text('dari galeri perangkat kamu',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Informasi Pengalaman',
                style: TextStyle(
                    color: Color(0xFF6887A6),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Judul *',
                prefixIcon:
                Icon(Icons.title, color: Color(0xFF6887A6)),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descCtrl,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                prefixIcon:
                Icon(Icons.description, color: Color(0xFF6887A6)),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Pengalaman'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6887A6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HELPERS
// ============================================================
class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _SectionCard(
      {required this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF6887A6), size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// WIDGET GALLERY
// ============================================================
class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Display', Icons.image, Colors.blue),
      ('Input', Icons.edit, Colors.green),
      ('Button', Icons.smart_button, Colors.orange),
      ('Feedback', Icons.notifications, Colors.purple),
      ('Layout', Icons.dashboard, Colors.teal),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Widget Gallery')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (name, icon, color) = categories[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              title: Text(name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CategoryPage(name: name)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String name;
  const CategoryPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final Widget body = switch (name) {
      'Display' => const _DisplayDemo(),
      'Input' => const _InputDemo(),
      'Button' => const _ButtonDemo(),
      'Feedback' => const _FeedbackDemo(),
      'Layout' => const _LayoutDemo(),
      _ => const Center(child: Text('?')),
    };
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16), child: body),
    );
  }
}

class _DisplayDemo extends StatelessWidget {
  const _DisplayDemo();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Card',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Card(
            child: ListTile(
                leading: Icon(Icons.album),
                title: Text('Judul Item'),
                subtitle: Text('Sub-judul'))),
        const SizedBox(height: 16),
        const Text('Chip',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(spacing: 8, children: const [
          Chip(label: Text('Flutter')),
          Chip(label: Text('Dart')),
          Chip(label: Text('Mobile'))
        ]),
        const SizedBox(height: 16),
        const Text('Divider',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Divider(thickness: 2),
        const SizedBox(height: 16),
        const Text('CircleAvatar & Icon',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Row(children: const [
          CircleAvatar(child: Text('A')),
          SizedBox(width: 12),
          CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.check)),
          SizedBox(width: 12),
          Icon(Icons.star, color: Colors.amber, size: 40),
        ]),
      ],
    );
  }
}

class _InputDemo extends StatefulWidget {
  const _InputDemo();
  @override
  State<_InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<_InputDemo> {
  bool _checked = false;
  bool _switched = true;
  double _slider = 0.5;
  String? _dropdown = 'Apel';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TextField'),
        const SizedBox(height: 4),
        const TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nama',
              hintText: 'Ketik nama Anda'),
        ),
        const SizedBox(height: 16),
        CheckboxListTile(
            title: const Text('Checkbox'),
            value: _checked,
            onChanged: (v) => setState(() => _checked = v ?? false)),
        SwitchListTile(
            title: const Text('Switch'),
            value: _switched,
            onChanged: (v) => setState(() => _switched = v)),
        const Text('Slider'),
        Slider(
            value: _slider,
            onChanged: (v) => setState(() => _slider = v)),
        const SizedBox(height: 8),
        const Text('Dropdown'),
        DropdownButton<String>(
          value: _dropdown,
          items: ['Apel', 'Jeruk', 'Mangga']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => setState(() => _dropdown = v),
        ),
      ],
    );
  }
}

class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
        const SizedBox(height: 8),
        FilledButton(onPressed: () {}, child: const Text('Filled')),
        const SizedBox(height: 8),
        OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
        const SizedBox(height: 8),
        TextButton(onPressed: () {}, child: const Text('Text Button')),
        const SizedBox(height: 8),
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send),
            label: const Text('Dengan Icon')),
        const SizedBox(height: 8),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite, color: Colors.red)),
      ],
    );
  }
}

class _FeedbackDemo extends StatelessWidget {
  const _FeedbackDemo();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Halo dari SnackBar!'))),
          child: const Text('Tampilkan SnackBar'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Konfirmasi'),
              content: const Text('Yakin ingin lanjut?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal')),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ya')),
              ],
            ),
          ),
          child: const Text('Tampilkan Dialog'),
        ),
        const SizedBox(height: 16),
        const Text('Progress Indicator:'),
        const SizedBox(height: 8),
        const LinearProgressIndicator(value: 0.6),
        const SizedBox(height: 12),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

class _LayoutDemo extends StatelessWidget {
  const _LayoutDemo();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Stack — widget bertumpuk'),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: Stack(children: [
            Container(
                width: double.infinity, color: Colors.blue.shade100),
            Positioned(
                top: 12,
                left: 12,
                child: Container(
                    width: 50, height: 50, color: Colors.red)),
            const Positioned(
                bottom: 12,
                right: 12,
                child:
                Icon(Icons.star, size: 40, color: Colors.amber)),
          ]),
        ),
        const SizedBox(height: 16),
        const Text('Wrap — auto-pindah baris saat penuh'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
              8,
                  (i) => Container(
                padding: const EdgeInsets.all(12),
                color: Colors.teal.shade100,
                child: Text('Item ${i + 1}'),
              )),
        ),
        const SizedBox(height: 16),
        const Text('GridView (count: 3)'),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(
                6,
                    (i) => Container(
                  color: Colors.purple.shade100,
                  alignment: Alignment.center,
                  child: Text('${i + 1}'),
                )),
          ),
        ),
      ],
    );
  }
}