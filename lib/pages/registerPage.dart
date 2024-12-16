import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller'lar
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    cityController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8), // Beyaz ve yarı opak
        title: const Text(
          'Kayıt Ol',
          style: TextStyle(color: Colors.black), // Yazı rengi siyah
          textAlign: TextAlign.center, // Ortalanan yazı
        ),
        centerTitle: true, // Yazının tam ortalanması
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Arka plan resmi
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/flowers.webp'), // Resim dosyanızın yolu
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.5), // Resmin üzerine yarı opak katman
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextInput(nameController, 'İsim', TextInputType.text),
                  const SizedBox(height: 10),
                  _buildTextInput(surnameController, 'Soyad', TextInputType.text),
                  const SizedBox(height: 10),
                  _buildTextInput(emailController, 'Gmail', TextInputType.emailAddress),
                  const SizedBox(height: 10),
                  _buildTextInput(phoneController, 'Telefon Numarası', TextInputType.phone),
                  const SizedBox(height: 10),
                  _buildTextInput(cityController, 'Şehir', TextInputType.text),
                  const SizedBox(height: 10),
                  _buildTextInput(birthDateController, 'Doğum Tarihi (YYYY-AA-GG)', TextInputType.datetime),
                  const SizedBox(height: 10),
                  _buildTextInput(passwordController, 'Şifre', TextInputType.text, isPassword: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          UserCredential userCredential =
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          FirebaseFirestore firestore = FirebaseFirestore.instance;
                          await firestore.collection('Kullanıcı bilgiler').doc(userCredential.user!.uid).set({
                            "İsim": nameController.text,
                            "Soyad": surnameController.text,
                            "Gmail": emailController.text,
                            "Telefon Numarası": phoneController.text,
                            "Şehir": cityController.text,
                            "Doğum Tarihi": birthDateController.text,
                            "Şifre": passwordController.text,
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kayıt başarılı ve bilgiler kaydedildi!')),
                          );

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
        ],
      ),
    );
  }

  Widget _buildTextInput(TextEditingController controller, String labelText, TextInputType inputType, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: const Color(0xFF8174A0).withOpacity(0.1), // Yarı opak arka plan
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      keyboardType: inputType,
      obscureText: isPassword,
      validator: (value) => value == null || value.isEmpty ? 'Lütfen $labelText girin' : null,
    );
  }
}
