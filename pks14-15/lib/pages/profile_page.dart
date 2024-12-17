import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/auth_provider.dart';
import '../logic/orders_provider.dart';
import './chat_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser;
    if (user != null) {
      _nameController.text = user.fullName ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _openChat() {
    final user = context.read<AuthProvider>().currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            sellerId: 'seller_1',
          ),
        ),
      );
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final success = await context.read<AuthProvider>().updateProfile(
            fullName: _nameController.text.trim(),
          );

      if (mounted) {
        if (success) {
          setState(() => _isEditing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Профиль обновлен')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ошибка обновления профиля')),
          );
        }
      }
    }
  }

  String _getOrdersText(int count) {
    if (count == 1) {
      return 'заказ';
    } else if (count < 5) {
      return 'заказа';
    } else {
      return 'заказов';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.currentUser;

          if (user == null) {
            return const Center(child: Text('Пользователь не авторизован'));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          // Верхняя панель с отступом для кнопки редактирования
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 16,
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                          ),

                          // Фото профиля
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ФИО с возможностью редактирования
                          if (_isEditing)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'ФИО',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Пожалуйста, введите ФИО';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _isEditing = false;
                                              _nameController.text =
                                                  user.fullName ?? '';
                                            });
                                          },
                                          child: const Text('Отмена'),
                                        ),
                                        const SizedBox(width: 16),
                                        ElevatedButton(
                                          onPressed: _updateProfile,
                                          child: const Text('Сохранить'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            Text(
                              user.fullName ?? 'Укажите ваше имя',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(height: 32),

                          // Email секция
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.email,
                                        color: Colors.black54),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Email',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          user.email,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Разделитель
                          const Divider(height: 1),

                          // Мои заказы
                          ListTile(
                            leading: const Icon(Icons.shopping_bag_outlined),
                            title: const Text('Мои заказы'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '2 заказа',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                            onTap: () =>
                                Navigator.pushNamed(context, '/orders'),
                          ),

                          // Чат с продавцом
                          ListTile(
                            leading: const Icon(Icons.chat_outlined),
                            title: const Text('Чат с продавцом'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: _openChat,
                          ),

                          const Divider(height: 1),

                          // Выйти
                          ListTile(
                            leading: Icon(Icons.logout, color: Colors.red[400]),
                            title: Text(
                              'Выйти',
                              style: TextStyle(color: Colors.red[400]),
                            ),
                            onTap: () async {
                              await authProvider.signOut();
                              if (context.mounted) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              }
                            },
                          ),
                        ],
                      ),
                      // Кнопка редактирования в правом верхнем углу
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        right: 8,
                        child: IconButton(
                          icon: Icon(_isEditing ? Icons.close : Icons.edit),
                          onPressed: () {
                            setState(() {
                              _isEditing = !_isEditing;
                              if (!_isEditing) {
                                _nameController.text = user.fullName ?? '';
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Нижняя навигация
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Icons.home_outlined, 'Главная', () {
                      Navigator.pushNamed(context, '/');
                    }),
                    _buildNavItem(Icons.favorite_outline, 'Избранное', () {
                      Navigator.pushNamed(context, '/favorites');
                    }),
                    _buildNavItem(Icons.shopping_cart_outlined, 'Корзина', () {
                      Navigator.pushNamed(context, '/cart');
                    }),
                    _buildNavItem(Icons.person, 'Профиль', () {},
                        isSelected: true),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, VoidCallback onTap,
      {bool isSelected = false}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.blue : Colors.grey,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.blue : Colors.grey,
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
