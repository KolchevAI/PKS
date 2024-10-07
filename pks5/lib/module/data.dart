class FormItem {
  final String name;
  final String image;
  final String description;
  final double price;

  FormItem({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });
}

List<FormItem> formItems = [
  FormItem(
    name: 'Домашняя форма сезона 2024/25',
    image: 'assets/images/home.png',
    description: 'Домашний комплект формы состоит из красной футболки и синих шорт – именно в таком сочетании армейцы впервые сыграли 85 лет назад. Ключевой элемент формы – паттерн в виде нашего дома – ВЭБ Арены. Благодаря изображению нашего стадиона, этот комплект формы можно назвать по-настоящему домашним.',
    price: 6599.0,
  ),
  FormItem(
    name: 'Гостевая форма сезона 2024/25',
    image: 'assets/images/away.png',
    description: 'Гостевой комплект формы выполнен с песчаным оттенком и узором, напоминающим песок, раздуваемый ветром. Конечно, задумка связана с нашей родной 3-й Песчаной улицей, на которой еще в 1961 году был построен стадион ЦСКА имени Григория Федотова. А сегодня в этом историческом месте располагается ВЭБ Арена. И теперь даже на выездных матчах родная «Песчанка» всегда будет с нами.',
    price: 6599.0,
  ),
  FormItem(
    name: 'Резервная форма сезона 2024/25',
    image: 'assets/images/res.png',
    description: 'Черный комплект с красно-синими элементами на рукавах и гетрах — форма, посвященная нашим фанатам, которые традиционно поддерживают команду на трибунах именно в этом цвете. На футболке считывается паттерн из шотландской сетки — элемента из фанатской культуры.',
    price: 6599.0,
  ),
];