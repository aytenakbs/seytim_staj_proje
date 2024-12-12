import 'package:flutter/material.dart';



class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xEC084CFF),
        title: const Text('Kayıt Ol'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'İsim',
                ),
                validator: (value) =>
                value!.isEmpty ? 'Lütfen isminizi girin' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Soyadı',
                ),
                validator: (value) =>
                value!.isEmpty ? 'Lütfen soyadınızı girin' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Doğum Tarihi',
                  hintText: 'GG/AA/YYYY',
                ),
                validator: (value) =>
                value!.isEmpty ? 'Lütfen doğum tarihinizi girin' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Gmail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value!.isEmpty ? 'Lütfen geçerli bir e-posta girin' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Telefon Numarası',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value!.isEmpty ? 'Lütfen telefon numaranızı girin' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Yaşadığı Şehir',
                ),
                validator: (value) =>
                value!.isEmpty ? 'Lütfen şehir adını girin' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                ),
                obscureText: true,
                validator: (value) =>
                value!.isEmpty ? 'Lütfen şifrenizi girin' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kayıt başarılı!')),
                    );
                  }
                },
                child: const Text(
                  'Kaydı Tamamla',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
