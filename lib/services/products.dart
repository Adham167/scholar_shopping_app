import 'package:scholar_shopping_app/models/product_model.dart';
import 'package:scholar_shopping_app/models/question_answer.dart';

List<ProductModel> products = [
  ProductModel(
    name: "Leather Office Chair",
    price: 199.99,
    imageurl: "assets/LeatherOfficeChair.webp",
    description: "Ergonomic leather office chair with adjustable height.",
    productDetails: "360-degree swivel, lumbar support, and tilt mechanism.",
    customerReview: "Very comfortable for long working hours.",
    shoppingInformation: "Delivered within 5 days. Assembly included.",
    questionAnswers: [
      QuestionAnswer(
        question: "Is it suitable for tall people?",
        answer: "Yes, it has adjustable height and a tall backrest.",
      ),
      QuestionAnswer(
        question: "Can the wheels be locked?",
        answer: "No, the wheels do not have a locking mechanism.",
      ),
    ],
  ),
  ProductModel(
    name: "Wireless Bluetooth Headphones",
    price: 59.99,
    imageurl: "assets/WirelessBluetoothHeadphones.webp",
    description:
        "Noise-cancelling over-ear headphones with high-fidelity sound.",
    productDetails: "Bluetooth 5.0, 40h playtime, built-in mic.",
    customerReview: "Amazing sound quality and battery life.",
    shoppingInformation: "Ships in 3-4 business days.",
    questionAnswers: [
      QuestionAnswer(
        question: "Does it support fast charging?",
        answer: "Yes, 10 minutes charge gives 4 hours playback.",
      ),
      QuestionAnswer(
        question: "Is it compatible with iPhones?",
        answer: "Fully compatible with all iOS and Android devices.",
      ),
    ],
  ),
  ProductModel(
    name: "Smart LED TV 55 inch",
    price: 599.99,
    imageurl: "assets/SmartLEDTV55inch.webp",
    description: "4K UHD Smart TV with HDR and built-in apps.",
    productDetails: "55 inch, 4K resolution, HDMI & USB ports.",
    customerReview: "Great quality and colors. Easy to use interface.",
    shoppingInformation: "Delivered and installed in 7 days.",
    questionAnswers: [
      QuestionAnswer(
        question: "Can I install apps like Netflix?",
        answer: "Yes, Netflix, YouTube, and more are pre-installed.",
      ),
      QuestionAnswer(
        question: "Does it have screen mirroring?",
        answer: "Yes, supports screen mirroring via Miracast.",
      ),
    ],
  ),
  ProductModel(
    name: "Stainless Steel Cookware Set",
    price: 149.99,
    imageurl: "assets/StainlessSteelCookwareSet.webp",
    description: "10-piece durable cookware set for everyday use.",
    productDetails: "Induction compatible, dishwasher safe.",
    customerReview: "Excellent heat distribution. Very sturdy.",
    shoppingInformation: "Ships in 2 days. 1-year warranty.",
    questionAnswers: [
      QuestionAnswer(
        question: "Are the handles heat resistant?",
        answer: "Yes, handles are made of heat-proof silicone.",
      ),
      QuestionAnswer(
        question: "Is it oven safe?",
        answer: "Safe up to 500°F (260°C).",
      ),
    ],
  ),
  ProductModel(
    name: "Modern Wood Coffee Table",
    price: 89.99,
    imageurl: "assets/ModernWoodCoffeeTable.webp",
    description: "Stylish wooden coffee table with metal legs.",
    productDetails: "Solid wood top, matte black legs, easy assembly.",
    customerReview: "Adds a modern touch to my living room.",
    shoppingInformation: "Ships flat-packed. Assembly tools included.",
    questionAnswers: [
      QuestionAnswer(
        question: "What are the dimensions?",
        answer: "40 x 20 x 18 inches.",
      ),
      QuestionAnswer(
        question: "Is the wood treated against moisture?",
        answer: "Yes, it has a moisture-resistant finish.",
      ),
    ],
  ),
  ProductModel(
    name: "Men’s Running Shoes",
    price: 79.99,
    imageurl: "assets/Men’sRunningShoes.webp",
    description: "Lightweight and breathable running shoes.",
    productDetails: "Rubber sole, mesh upper, cushioned insole.",
    customerReview: "Great support and comfortable fit.",
    shoppingInformation: "Free returns within 30 days.",
    questionAnswers: [
      QuestionAnswer(
        question: "Are they true to size?",
        answer: "Yes, order your regular size.",
      ),
      QuestionAnswer(
        question: "Can I use them for gym workouts?",
        answer: "Yes, suitable for running and indoor training.",
      ),
    ],
  ),
  ProductModel(
    name: "Gaming Mouse RGB",
    price: 39.99,
    imageurl: "assets/GamingMouseRGB.webp",
    description: "High-precision gaming mouse with customizable RGB.",
    productDetails: "7 buttons, 16000 DPI, USB wired.",
    customerReview: "Responsive and looks amazing in the dark.",
    shoppingInformation: "Ships in 1-2 days.",
    questionAnswers: [
      QuestionAnswer(
        question: "Does it support Mac?",
        answer: "Yes, works with Windows and Mac.",
      ),
      QuestionAnswer(
        question: "Is DPI adjustable?",
        answer: "Yes, 6 levels of DPI customization.",
      ),
    ],
  ),
  ProductModel(
    name: "Stainless Steel Water Bottle",
    price: 25.99,
    imageurl: "assets/StainlessSteelWaterBottle.webp",
    description: "Keeps beverages hot for 12h and cold for 24h.",
    productDetails: "750ml, leak-proof, BPA-free.",
    customerReview: "Perfect for workouts and travel.",
    shoppingInformation: "Eco-friendly packaging included.",
    questionAnswers: [
      QuestionAnswer(
        question: "Can I put it in the dishwasher?",
        answer: "Hand wash recommended to maintain insulation.",
      ),
      QuestionAnswer(
        question: "Is it safe for kids?",
        answer: "Yes, made from food-grade stainless steel.",
      ),
    ],
  ),
  ProductModel(
    name: "Laptop Stand Adjustable",
    price: 45.00,
    imageurl: "assets/LaptopStandAdjustable.webp",
    description: "Aluminum laptop stand with height adjustability.",
    productDetails: "Fits 11-17 inch laptops, foldable design.",
    customerReview: "Improved posture and reduces neck strain.",
    shoppingInformation: "Lightweight and easy to carry.",
    questionAnswers: [
      QuestionAnswer(
        question: "Does it work with MacBooks?",
        answer: "Yes, fully compatible with MacBooks and all laptops.",
      ),
      QuestionAnswer(
        question: "Does it have rubber pads?",
        answer: "Yes, prevents slipping and scratching.",
      ),
    ],
  ),
  ProductModel(
    name: "Mini Indoor Plant Set",
    price: 34.99,
    imageurl: "assets/MiniIndoorPlantSet.webp",
    description: "Set of 3 mini indoor plants with ceramic pots.",
    productDetails: "Low maintenance, purifies air.",
    customerReview: "Beautiful addition to my workspace.",
    shoppingInformation: "Includes care guide and potting soil.",
    questionAnswers: [
      QuestionAnswer(
        question: "Do they need sunlight?",
        answer: "Indirect sunlight is perfect.",
      ),
      QuestionAnswer(
        question: "How often do I water them?",
        answer: "Once every 7-10 days depending on humidity.",
      ),
    ],
  ),
];
