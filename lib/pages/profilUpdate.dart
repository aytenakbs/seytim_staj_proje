import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UpdateProfilePage(),
    );
  }
}

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Güncelleme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Adınız'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen adınızı girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(labelText: 'Soyadınız'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen soyadınızı girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Doğum Tarihiniz (GG/AA/YY)'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen doğum tarihinizi girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-posta'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Lütfen geçerli bir e-posta girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telefon'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen telefon numaranızı girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Şehir'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şehirinizi girin';
                  }
                  return null;
                },
              ),
              // Mevcut Şifre
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(labelText: 'Mevcut Şifreniz'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen mevcut şifrenizi girin';
                  }
                  return null;
                },
              ),
              // Yeni Şifre
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'Yeni Şifre'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen yeni şifrenizi girin';
                  }
                  return null;
                },
              ),
              // Yeni Şifreyi Onayla
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Yeni Şifreyi Onayla'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen yeni şifrenizi onaylayın';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Şifreler uyuşmuyor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Profil ve şifre güncelleme işlemi yapılabilir
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profil başarıyla güncellendi')),
                    );
                  }
                },
                child: Text('Güncelle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}