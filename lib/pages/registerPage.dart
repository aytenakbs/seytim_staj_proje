import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore için gerekli paket
import '../main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Kullanıcı Adı',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kullanıcı adınızı girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen geçerli bir e-posta adresi girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi girin';
                  } else if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Kullanıcıyı Firebase Authentication ile kaydet
                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Firestore bağlantısı ve veri kaydetme
                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      await firestore.collection('Kullanıcı bilgiler').doc(userCredential.user!.uid).set({
                        "İsim": usernameController.text,
                        "Gmail": emailController.text,
                        "Şifre": passwordController.text,
                        "Doğum Tarihi": DateTime.now(), // Sabit bir tarih; formdan veri alarak özelleştirilebilir.
                        "Telefon Numarası": "Belirtilmedi", // Formdan telefon numarası eklenebilir.
                        "Soyad": "Belirtilmedi", // Formdan soyad eklenebilir.
                        "Şehir": "Belirtilmedi", // Formdan şehir eklenebilir.
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Kayıt başarılı ve veriler kaydedildi!')),
                      );

                      // Giriş ekranına yönlendirme
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hata: ${e.toString()}')),
                      );
                    }
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
