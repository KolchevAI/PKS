import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthForm());
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Авторизация',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 34
                ),
              ),
              const SizedBox(height: 100), // margin bottom 100
              const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Логин',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    filled: true),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Пароль',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    filled: true),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: false, onChanged: (bool? value) {}),
                  const Text(
                    'Запомнить меня',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Прямоугольная форма
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Войти',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.blue)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Регистрация',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Восстановить Пароль',
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ],
          ),
        ));
  }
}