import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/registerPage.dart'; // Kayıt ol sayfası için import
import 'firebase_options.dart'; // Firebase konfigürasyonu için gerekli

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlat
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Uygulaması',
      theme: ThemeData(
        primaryColor: const Color(0xEC084CFF),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0x8508ECFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xF5F5F5),
          labelStyle: const TextStyle(color: Color(0xEC084CFF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xEC084CFF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xEC084CFF), width: 2),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xEC084CFF),
        title: const Text('Giriş Yap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Kullanıcıyı Firebase Auth ile doğrula
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      // Firestore'dan kullanıcının e-postasına göre veri çek
                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      QuerySnapshot querySnapshot = await firestore
                          .collection('Kullanıcı bilgiler') // Koleksiyon ismi
                          .where('Gmail', isEqualTo: emailController.text.trim()) // E-posta eşleşmesi
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        // Kullanıcı bulunduysa validasyon başarılı
                        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

                        // Örnek validasyon: Şifre kontrolü (Firestore'daki şifre ile karşılaştırma)
                        if (userData['Şifre'] == passwordController.text.trim()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                body: Center(
                                  child: Text(
                                    'Hoşgeldiniz, ${userData['İsim']} ${userData['Soyad']}!',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Şifre hatalıysa
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Şifre hatalı!')),
                          );
                        }
                      } else {
                        // Kullanıcı bulunamazsa
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Kullanıcı bilgileri bulunamadı!')),
                        );
                      }
                    } catch (e) {
                      // Hata mesajı
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hata: ${e.toString()}')),
                      );
                    }
                  }
                },

                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Henüz üye olmadınız mı?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Kayıt Ol',
                      style: TextStyle(color: Color(0xEC084CFF)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
