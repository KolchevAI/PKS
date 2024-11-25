import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> itemsInCart = [
    CartItem(name: 'Клинический анализ крови с лейкоцитарной формулировкой', price: 690.0, quantity: 1),
    CartItem(name: 'Общий анализ мочи', price: 350.0, quantity: 2),
  ];

  @override
  Widget build(BuildContext context) {
    double totalCost = itemsInCart.fold(0, (total, item) => total + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Корзина',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemsInCart.length + 1,
                itemBuilder: (context, index) {
                  if (index < itemsInCart.length) {
                    return CartItemWidget(cartItem: itemsInCart[index]);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Сумма',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${totalCost} ₽',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Center(
                child: SizedBox(
                  width: 335,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Логика перехода к оформлению заказа
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Перейти к оформлению заказа',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cartItem.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  // Логика удаления услуги из корзины
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cartItem.price} ₽',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${cartItem.quantity} клиент${cartItem.quantity > 1 ? 'а' : ''}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 64,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Логика уменьшения количества
                          },
                          child: Icon(Icons.remove, size: 15, color: Color(0xFFB8C1CC)),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Логика увеличения количества
                          },
                          child: Icon(Icons.add, size: 15, color: Color(0xFFB8C1CC)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  final int quantity;

  CartItem({required this.name, required this.price, required this.quantity});
}