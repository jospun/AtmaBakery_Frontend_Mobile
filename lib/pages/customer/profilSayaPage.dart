import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class ProfilSayaPage extends StatefulWidget {
  const ProfilSayaPage({Key? key}) : super(key: key);

  @override
  State<ProfilSayaPage> createState() => _ProfilSayaPage();
}

class _ProfilSayaPage extends State<ProfilSayaPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _isLoading = true;
  bool _showCameraIcon = false;
  String _selectedGender = '';
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _tanggalLahirController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  User? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _selectedGender = (_userData?.jenis_kelamin ?? '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      User user = await userClient.showSelf();
      setState(() {
        _userData = user;
        _namaController.text = user.nama ?? '';
        _emailController.text = user.email ?? '';
        _tanggalLahirController.text = user.tanggal_lahir ?? '';
        _noTelpController.text = user.no_telp ?? '';
        _selectedGender = user.jenis_kelamin ?? '';
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Saya"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 4,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 45),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: _userData?.foto_profil_upload !=
                                      null
                                  ? FileImage(File(
                                          _userData!.foto_profil_upload!.path))
                                      as ImageProvider<Object>
                                  : _userData?.foto_profil != null
                                      ? NetworkImage(_userData!.foto_profil!)
                                          as ImageProvider<Object>
                                      : NetworkImage(
                                              "https://res.cloudinary.com/daorbrq8v/image/upload/f_auto,q_auto/v1/atma-bakery/r1xujbu1yfoenzked4rc")
                                          as ImageProvider<Object>,
                            ),
                            if (_showCameraIcon)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () {
                                    _showCameraOptionsModal(context);
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      const Text(
                        "Nama",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _namaController,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          enabled: _isEditing,
                          filled: false,
                          fillColor: const Color.fromRGBO(234, 234, 234, 1),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(244, 142, 40, 1)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(210, 145, 79, 1),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 181, 179, 179)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintStyle: TextStyle(height: 0.13),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silahkan masukkan nama';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      const Text(
                        "Tanggal Lahir",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _tanggalLahirController,
                        enabled: false,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          enabled: _isEditing,
                          filled: false,
                          fillColor: const Color.fromRGBO(234, 234, 234, 1),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(244, 142, 40, 1)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(210, 145, 79, 1),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 181, 179, 179)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintStyle: TextStyle(height: 0.13),
                        ),
                      ),
                      SizedBox(height: 20),
                      const Text(
                        "Nomor Telepon",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _noTelpController,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          enabled: _isEditing,
                          filled: false,
                          fillColor: const Color.fromRGBO(234, 234, 234, 1),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(244, 142, 40, 1)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(210, 145, 79, 1),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 181, 179, 179)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintStyle: TextStyle(height: 0.13),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silahkan masukkan Nomor Telepon';
                          } else if (!RegExp(r'^\+?08\d{8,}$')
                              .hasMatch(value)) {
                            return 'Format Nomor Telepon Tidak Valid';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      const Text(
                        "Jenis Kelamin",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          AbsorbPointer(
                            absorbing: !_isEditing,
                            child: Radio<String>(
                              value: 'L',
                              groupValue: _selectedGender,
                              onChanged: _isEditing
                                  ? (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    }
                                  : null,
                            ),
                          ),
                          Text('Laki-laki'),
                          SizedBox(width: 20),
                          AbsorbPointer(
                            absorbing: !_isEditing,
                            child: Radio<String>(
                              value: 'P',
                              groupValue: _selectedGender,
                              onChanged: _isEditing
                                  ? (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    }
                                  : null,
                            ),
                          ),
                          Text('Perempuan'),
                        ],
                      ),
                      if (_isEditing && _selectedGender.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Pilih jenis kelamin',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                      const Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        enabled: false,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          enabled: _isEditing,
                          filled: false,
                          fillColor: const Color.fromRGBO(234, 234, 234, 1),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(244, 142, 40, 1)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(210, 145, 79, 1),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 181, 179, 179)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintStyle: TextStyle(height: 0.13),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _isEditing && _selectedGender.isNotEmpty
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      _saveProfile();
                                    }
                                  }
                                : _enableEditing,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(244, 142, 40, 1),
                              minimumSize: Size(85, 5),
                            ),
                            child: Text(
                              _isEditing ? 'Simpan Data' : 'Ubah Profil',
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _enableEditing() {
    setState(() {
      _isEditing = true;
      _showCameraIcon = true;
    });
  }

  void _saveProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        _selectedGender = (_selectedGender == 'L') ? 'L' : 'P';

        User updatedUser = User.toUpload(
          nama: _namaController.text,
          email: _emailController.text,
          tanggal_lahir: _tanggalLahirController.text,
          no_telp: _noTelpController.text,
          jenis_kelamin: _selectedGender,
          foto_profil_upload: _userData?.foto_profil_upload,
        );

        await userClient.update(updatedUser, token);

        setState(() {
          _userData = updatedUser;
          _isEditing = false;
          _isLoading = false;
          _showCameraIcon = false;
        });
        print('Data saved:');
        print('Nama: ${_namaController.text}');
        print('Email: ${_emailController.text}');
        print('Tanggal Lahir: ${_tanggalLahirController.text}');
        print('Nomor Telepon: ${_noTelpController.text}');
        print('Jenis Kelamin: ${_selectedGender}');
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error saving profile: $error');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showCameraOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Buka Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.camera, imageQuality: 75);
                  _handlePickedFile(pickedFile);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Pilih dari Device'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  _handlePickedFile(pickedFile);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Hapus Foto Saat Ini'),
                onTap: () {
                  setState(() {
                    _userData!.foto_profil = null;
                    _userData!.foto_profil_upload = null;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handlePickedFile(XFile? pickedFile) {
    if (pickedFile != null) {
      print('Path file yang dipilih: ${pickedFile.path}');
      final String extension = path.extension(pickedFile.path).toLowerCase();
      print('Ekstensi file yang dipilih: $extension');
      if (pickedFile.path.endsWith('.jpg') ||
          pickedFile.path.endsWith('.jpeg') ||
          pickedFile.path.endsWith('.png')) {
        setState(() {
          _userData!.foto_profil_upload = pickedFile;
        });
      } else {
        print('File yang dipilih bukan gambar yang valid.');
      }
    }
  }
}
