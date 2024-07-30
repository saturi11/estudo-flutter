import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;
import 'package:trilhaapp/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool hiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 58, 79, 81), // Cor de teal mais suave
                    Color.fromARGB(255, 38, 50, 51), // Cor de teal mais escura
                  ],
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 5,
                          child: Image.network(
                            "https://pbs.twimg.com/media/FnUFi3yXwAcL-uz.jpg:large",
                            height: 150,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Informe seus dados para acessar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: gf.GoogleFonts.padauk().fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(193, 37, 60, 63),
                              ),
                              border: InputBorder.none,
                              hintText: 'Login',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            obscureText: hiddenPassword,
                            controller: senhaController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color.fromARGB(193, 37, 60, 63),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    hiddenPassword = !hiddenPassword;
                                  });
                                },
                                child: Icon(
                                  hiddenPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color.fromARGB(193, 37, 60, 63),
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Senha',
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade700.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (emailController.text == 'admin' &&
                                  senhaController.text == 'admin') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login ou senha inválidos'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          margin: const EdgeInsets.only(top: 50),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade700.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: () {
                              //Navigator.pushNamed(context, '/home');
                            },
                            child: const Text(
                              'Faça seu cadastro',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
