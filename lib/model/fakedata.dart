import 'model.dart';

var productList = [
  Product(
    id: "1",
    title: "Modern Sofa",
    description: "A sleek and comfortable modern sofa for your living room.",
    imagePath: "assets/images/modern_sofa.jpg",
    price: 899.99,
    hasDiscount: true,
    discount: 10.0,
    quantity: 25,
    category: Category(
        title: "Living Room", imagePath: "assets/images/categories/living_room.jpg"),
  ),
  Product(
    id: "2",
    title: "Vintage Armchair",
    description: "A classic vintage armchair to add charm to any room.",
    imagePath: "assets/images/vintage_armchair.jpg",
    price: 499.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 15,
    category: Category(
        title: "Living Room", imagePath: "assets/images/categories/living_room.jpg"),
  ),
  Product(
    id: "3",
    title: "Rustic Dining Table",
    description: "A sturdy and charming dining table for family gatherings.",
    imagePath: "assets/images/rustic_dining_table.jpg",
    price: 699.99,
    hasDiscount: true,
    discount: 15.0,
    quantity: 10,
    category: Category(
        title: "Dining Room", imagePath: "assets/images/categories/dining_room.jpg"),
  ),
  Product(
    id: "4",
    title: "Elegant Chandelier",
    description: "An elegant chandelier to illuminate your dining area.",
    imagePath: "assets/images/elegant_chandelier.jpg",
    price: 349.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 5,
    category: Category(
        title: "Dining Room", imagePath: "assets/images/categories/dining_room.jpg"),
  ),
  Product(
    id: "5",
    title: "Cozy Bedside Table",
    description: "A cozy bedside table with ample storage for your bedroom.",
    imagePath: "assets/images/cozy_bedside_table.jpg",
    price: 199.99,
    hasDiscount: true,
    discount: 20.0,
    quantity: 8,
    category:
        Category(title: "Bedroom", imagePath: "assets/images/categories/bedroom.jpg"),
  ),
  Product(
    id: "6",
    title: "TV Stand",
    description: "A TV stand to elevate your entertainment area.",
    imagePath: "assets/images/tv_stand.jpg",
    price: 449.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 12,
    category: Category(
        title: "Living Room", imagePath: "assets/images/categories/living_room.jpg"),
  ),
  Product(
    id: "7",
    title: "Nightstand",
    description: "A compact nightstand with two drawers.",
    imagePath: "assets/images/nightstand.jpg",
    price: 129.99,
    hasDiscount: true,
    discount: 5.0,
    quantity: 50,
    category:
        Category(title: "Bedroom", imagePath: "assets/images/categories/bedroom.jpg"),
  ),
  Product(
    id: "8",
    title: "Dresser",
    description: "A spacious dresser with six drawers.",
    imagePath: "assets/images/dresser.jpg",
    price: 399.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 20,
    category:
        Category(title: "Bedroom", imagePath: "assets/images/categories/bedroom.jpg"),
  ),
  Product(
    id: "9",
    title: "Bedside Lamp",
    description: "A modern bedside lamp with adjustable brightness.",
    imagePath: "assets/images/bedside_lamp.jpg",
    price: 59.99,
    hasDiscount: true,
    discount: 10.0,
    quantity: 60,
    category:
        Category(title: "Bedroom", imagePath: "assets/images/categories/bedroom.jpg"),
  ),
  Product(
    id: "10",
    title: "Wardrobe",
    description: "A sleek wardrobe with sliding doors and mirror panels.",
    imagePath: "assets/images/wardrobe.jpg",
    price: 799.99,
    hasDiscount: true,
    discount: 15.0,
    quantity: 10,
    category:
        Category(title: "Bedroom", imagePath: "assets/images/categories/bedroom.jpg"),
  ),
  Product(
    id: "11",
    title: "Dining Table Set",
    description: "A wooden dining table with four chairs.",
    imagePath: "assets/images/dining_table_set.jpg",
    price: 749.99,
    hasDiscount: true,
    discount: 15.0,
    quantity: 10,
    category: Category(
        title: "Dining Room", imagePath: "assets/images/categories/dining_room.jpg"),
  ),
  Product(
    id: "12",
    title: "Bar Stools",
    description: "A set of two bar stools with cushioned seats.",
    imagePath: "assets/images/barstools.jpg",
    price: 149.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 30,
    category: Category(
        title: "Dining Room", imagePath: "assets/images/categories/dining_room.jpg"),
  ),
  Product(
    id: "13",
    title: "Buffet Cabinet",
    description: "A wooden buffet cabinet with ample storage.",
    imagePath: "assets/images/buffet_cabinet.jpg",
    price: 599.99,
    hasDiscount: true,
    discount: 10.0,
    quantity: 15,
    category: Category(
        title: "Dining Room", imagePath: "assets/images/categories/dining_room.jpg"),
  ),
  Product(
    id: "14",
    title: "Dining Bench",
    description: "A versatile dining bench with wooden finish.",
    imagePath: "assets/images/dining_bench.jpg",
    price: 199.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 25,
    category: Category(
        title: "Dining Room", imagePath: "assets/images/categories/dining_room.jpg"),
  ),
  Product(
    id: "15",
    title: "Dining Room Rug",
    description: "A decorative rug for your dining area.",
    imagePath: "assets/images/dining_rug.jpg",
    price: 89.99,
    hasDiscount: true,
    discount: 5.0,
    quantity: 40,
    category: Category(
        title: "Dining Room", imagePath: "assets/images/categories/dining_room.jpg"),
  ),
  Product(
    id: "16",
    title: "Ergonomic Office Chair",
    description:
        "A comfortable office chair with adjustable height and lumbar support.",
    imagePath: "assets/images/ergonomic_chair.jpg",
    price: 299.99,
    hasDiscount: true,
    discount: 20.0,
    quantity: 30,
    category:
        Category(title: "Office", imagePath: "assets/images/categories/office.jpg"),
  ),
  Product(
    id: "17",
    title: "Office Desk",
    description: "A spacious desk with cable management features.",
    imagePath: "assets/images/office_desk.jpg",
    price: 499.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 20,
    category:
        Category(title: "Office", imagePath: "assets/images/categories/office.jpg"),
  ),
  Product(
    id: "18",
    title: "Filing Cabinet",
    description: "A secure and compact filing cabinet with three drawers.",
    imagePath: "assets/images/filing_cabinet.jpg",
    price: 199.99,
    hasDiscount: true,
    discount: 10.0,
    quantity: 40,
    category:
        Category(title: "Office", imagePath: "assets/images/categories/office.jpg"),
  ),
  Product(
    id: "19",
    title: "Bookshelf",
    description: "A compact bookshelf for office use.",
    imagePath: "assets/images/bookshelf.jpg",
    price: 129.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 25,
    category:
        Category(title: "Office", imagePath: "assets/images/categories/office.jpg"),
  ),
  Product(
    id: "20",
    title: "White Office Chair",
    description: "A white office chair for your back.",
    imagePath: "assets/images/white_office_chair.jpg",
    price: 59.99,
    hasDiscount: true,
    discount: 5.0,
    quantity: 50,
    category:
        Category(title: "Office", imagePath: "assets/images/categories/office.jpg"),
  ),
  Product(
    id: "21",
    title: "Outdoor Patio Set",
    description: "A durable and weather-resistant patio furniture set.",
    imagePath: "assets/images/patio_set.jpg",
    price: 649.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 8,
    category: Category(
        title: "Outdoors", imagePath: "assets/images/categories/outdoors.jpg"),
  ),
  Product(
    id: "22",
    title: "Hammock",
    description: "A relaxing hammock with a sturdy frame.",
    imagePath: "assets/images/hammock.jpg",
    price: 249.99,
    hasDiscount: true,
    discount: 15.0,
    quantity: 20,
    category: Category(
        title: "Outdoors", imagePath: "assets/images/categories/outdoors.jpg"),
  ),
  Product(
    id: "23",
    title: "Fire Pit",
    description: "A stylish fire pit for cozy outdoor gatherings.",
    imagePath: "assets/images/firepit.jpg",
    price: 399.99,
    hasDiscount: true,
    discount: 60.0,
    quantity: 15,
    category: Category(
        title: "Outdoors", imagePath: "assets/images/categories/outdoors.jpg"),
  ),
  Product(
    id: "24",
    title: "Garden Bench",
    description: "A wooden bench perfect for gardens and patios.",
    imagePath: "assets/images/garden_bench.jpg",
    price: 199.99,
    hasDiscount: false,
    discount: 0.0,
    quantity: 30,
    category: Category(
        title: "Outdoors", imagePath: "assets/images/categories/outdoors.jpg"),
  ),
  Product(
    id: "25",
    title: "Outdoor Umbrella",
    description: "A large outdoor umbrella to provide shade.",
    imagePath: "assets/images/outdoor_umbrella.jpg",
    price: 129.99,
    hasDiscount: true,
    discount: 45.0,
    quantity: 25,
    category: Category(
        title: "Outdoors", imagePath: "assets/images/categories/outdoors.jpg"),
  ),
];

var discountedProductsList =
    productList.where((product) => product.hasDiscount).toList();

var categoriesList = [
  Category(title: 'Outdoors', imagePath: 'assets/images/categories/outdoors.jpg'),
  Category(title: 'Office', imagePath: 'assets/images/categories/office.jpg'),
  Category(
      title: 'Dining Room', imagePath: 'assets/images/categories/dining_room.jpg'),
  Category(
      title: 'Living Room', imagePath: 'assets/images/categories/living_room.jpg'),
  Category(title: 'Bedroom', imagePath: 'assets/images/categories/bedroom.jpg'),
];



List showProductsByCategory(String chosenCategory){
  List<Product> returnedProductsList =
    productList.where((product) => product.category.title == chosenCategory).toList();
  return  returnedProductsList;
}


