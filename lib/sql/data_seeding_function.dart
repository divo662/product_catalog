import '../models/category_model.dart';
import '../models/product_models.dart';
import 'database_helper.dart';

Future<void> seedDatabase(DatabaseHelper dbHelper) async {
  try {
    print("Seeding database with initial data");

    final existingCategories = await dbHelper.getCategories();
    if (existingCategories.isEmpty) {
      final categories = [
        Category(id: 1, name: 'Electronics'),
        Category(id: 2, name: 'Clothing'),
        Category(id: 3, name: 'Home Appliances'),
        Category(id: 4, name: 'Sports & Outdoors'),
      ];

      for (var category in categories) {
        await dbHelper.insertCategory(category);
      }
    }
    // Insert products
    final products = [
      // Electronics
      Product(
          id: 1,
          name: 'iPhone 13 Pro Max',
          description:
          'Experience the future with the iPhone 13 Pro Max. Featuring the latest A15 Bionic chip, 5G capability for ultra-fast connectivity, a high-resolution Super Retina XDR display, and a Pro camera system with sensor-shift optical image stabilization for stunning photos and videos. With up to 1TB storage options and longer battery life, it’s built for performance and style.',
          price: 999.99,
          imageUrl:
          'https://th.bing.com/th/id/R.e670d68ec6fcd40220925093f8e5581f?rik=NgwauuQDDceSxA&pid=ImgRaw&r=0',
          categoryId: 1),
      Product(
          id: 2,
          name: 'HP Spectre x360',
          description:
          'The HP Spectre x360 is a versatile powerhouse, ideal for both work and play. It features a 13.5-inch OLED display for stunning visuals, an 11th Gen Intel Core i7 processor for blazing fast performance, and a flexible 360-degree hinge that lets you use it as a laptop or tablet. With long battery life, sleek design, and robust security features, it’s perfect for on-the-go productivity.',
          price: 1299.99,
          imageUrl:
          'https://th.bing.com/th/id/R.9f519b57cbd4546fb384b7675441ec20?rik=mE5o6kc4ju1Jjw&pid=ImgRaw&r=0',
          categoryId: 1),
      Product(
          id: 3,
          name: 'Sony WF-1000XM4',
          description:
          'Enjoy your favorite music like never before with the Sony WF-1000XM4 true wireless earbuds. Equipped with industry-leading noise cancellation, these earbuds deliver immersive sound quality with powerful bass and crystal-clear audio. Featuring ergonomic design, touch controls, voice assistant compatibility, and water resistance, they’re perfect for daily use, workouts, and travel.',
          price: 199.99,
          imageUrl:
          'https://th.bing.com/th/id/R.dd3e98d9c469d3191ff52207798a0286?rik=qdT9Pj3g98qygg&pid=ImgRaw&r=0',
          categoryId: 1),
      Product(
          id: 4,
          name: 'Samsung QLED TV',
          description:
          'Transform your living room into a home theater with the Samsung QLED TV. Featuring a 4K Ultra HD display, Quantum Dot technology for vibrant colors, HDR support for enhanced contrast, and smart capabilities to stream content from your favorite apps. With sleek, minimalist design and powerful audio, it offers a premium viewing experience for movies, sports, and gaming.',
          price: 799.99,
          imageUrl:
          'https://th.bing.com/th/id/R.bf65bdee9c30dbf74e1659b06ef57b63?rik=pdRh6d53l9P%2flQ&riu=http%3a%2f%2fimages.samsung.com%2fis%2fimage%2fsamsung%2fp5%2fes%2fa-fondo%2fimagen-y-sonido%2fcurarse-en-salud-con-un-tv-qled%2ftv-qled-samsung.png%3f%24ORIGIN_PNG%24&ehk=K7robWMFdI5U0SlGatQpw%2bkL12CbfSsuaJo7O70zHR8%3d&risl=&pid=ImgRaw&r=0',
          categoryId: 1),
      Product(
          id: 5,
          name: 'Apple iPad Pro',
          description:
          'The new Apple iPad Pro is the ultimate tool for creativity and productivity. With a stunning 12.9-inch Liquid Retina XDR display, M1 chip for lightning-fast performance, support for the Apple Pencil and Magic Keyboard, and a dual-camera system with LiDAR scanner for immersive AR experiences, it’s perfect for artists, designers, and professionals on the go.',
          price: 499.99,
          imageUrl:
          'https://th.bing.com/th/id/R.45c4d01c4ece55d12359be66662998e0?rik=5kCKWSoA08UD6Q&pid=ImgRaw&r=0',
          categoryId: 1),
      Product(
          id: 6,
          name: 'Canon EOS R6',
          description:
          'Capture every moment in stunning detail with the Canon EOS R6 mirrorless camera. Boasting a 20.1 MP full-frame CMOS sensor, DIGIC X image processor, 4K video capability, and advanced autofocus for breathtaking photos and videos. With in-body stabilization, dual card slots, and a durable build, it’s the perfect choice for both professional photographers and enthusiasts.',
          price: 899.99,
          imageUrl:
          'https://th.bing.com/th/id/R.d51fd0fc0167346062f672effa077c03?rik=3v8TaIxkUpqKbQ&pid=ImgRaw&r=0',
          categoryId: 1),
      Product(
          id: 7,
          name: 'Fitbit Versa 3',
          description:
          'Stay on top of your fitness goals with the Fitbit Versa 3. This smartwatch tracks your heart rate, sleep, and workouts, and includes built-in GPS, 24/7 heart rate monitoring, and 6-day battery life. With Alexa built-in, music control, and phone notifications, it’s the perfect companion for an active lifestyle, whether you’re running, cycling, or swimming.',
          price: 249.99,
          imageUrl:
          'https://th.bing.com/th/id/R.aee5447d37e58b5e3258b44b7e6a20b3?rik=4njr2vzgq0D%2fog&pid=ImgRaw&r=0',
          categoryId: 1),
      Product(
          id: 8,
          name: 'JBL Flip 5',
          description:
          'Take your music everywhere with the JBL Flip 5, a portable waterproof speaker with bold sound and deep bass. Featuring a 12-hour battery life, durable fabric material, and IPX7 waterproof design, it’s perfect for outdoor adventures, pool parties, or beach days. Enjoy wireless Bluetooth streaming and pair multiple speakers for an amplified sound experience.',
          price: 129.99,
          imageUrl:
          'https://th.bing.com/th/id/R.9768474b150b5aa7f3246cff9225e559?rik=XjO2ZjNCMRmIkA&pid=ImgRaw&r=0',
          categoryId: 1),

      // Clothing
      Product(
          id: 9,
          name: 'Nike Air Max 270',
          description: 'Experience unmatched comfort and style with the Nike Air Max 270. Featuring a breathable mesh upper, responsive cushioning, and a large Air Max unit for superior impact absorption, these sneakers are perfect for both casual wear and light workouts.',
          price: 19.99,
          imageUrl: 'https://th.bing.com/th/id/R.7d7f9fb08cb0228ee4c1764de0c9f408?rik=63e9%2f1pbuQ5atA&pid=ImgRaw&r=0',
          categoryId: 2
      ),
      Product(
          id: 10,
          name: 'Levi\'s 501 Jeans',
          description: 'The original Levi\'s 501 Jeans are an iconic piece of clothing, featuring a timeless straight-leg fit and durable denim fabric. They come in a variety of washes, making them perfect for any casual or semi-formal occasion.',
          price: 59.99,
          imageUrl: 'https://th.bing.com/th/id/R.ec9886b999858073d0e06b07dc10c04e?rik=Fy0%2f%2ftGPKOlohg&pid=ImgRaw&r=0',
          categoryId: 2
      ),
      Product(
          id: 11,
          name: 'H&M Evening Dress',
          description: 'Look stunning in this elegant H&M Evening Dress. Crafted with a luxurious blend of fabrics, it offers a flattering silhouette that is perfect for any formal occasion or special night out.',
          price: 89.99,
          imageUrl: 'https://th.bing.com/th/id/R.664e46ac1c42aa3db5c94907b97ca8f2?rik=x98caH9wv8VrTQ&pid=ImgRaw&r=0',
          categoryId: 2
      ),
      Product(
          id: 12,
          name: 'Adidas Ultraboost',
          description: 'Enhance your running experience with the Adidas Ultraboost. These shoes provide a lightweight feel, responsive cushioning, and a supportive upper, making them ideal for both long-distance running and everyday wear.',
          price: 79.99,
          imageUrl: 'https://th.bing.com/th/id/R.226f33be984a9be7c3125ee1b4339dee?rik=g3uuzWLsMXUTyA&pid=ImgRaw&r=0',
          categoryId: 2
      ),
      Product(
          id: 13,
          name: 'The North Face Jacket',
          description: 'Stay dry and comfortable with The North Face Waterproof Outdoor Jacket. Designed with advanced waterproof technology, this jacket is perfect for hiking, camping, or any outdoor adventure in unpredictable weather.',
          price: 129.99,
          imageUrl: 'https://th.bing.com/th/id/R.f0cf6f0e49b72db8f020ee69d794c5c3?rik=8sMIzOW5Tpq2%2bg&pid=ImgRaw&r=0',
          categoryId: 2
      ),
      Product(
          id: 14,
          name: 'Uniqlo Wool Sweater',
          description: 'Stay warm and stylish with the Uniqlo Wool Sweater. Made from high-quality wool, this sweater provides excellent insulation while maintaining a soft, lightweight feel, making it ideal for layering during colder months.',
          price: 69.99,
          imageUrl: 'https://th.bing.com/th/id/R.23aca73c77a6532edd9497623d8907aa?rik=s89uVnb6fBeI7A&pid=ImgRaw&r=0',
          categoryId: 2
      ),
      Product(
          id: 15,
          name: 'Gap Casual Shorts',
          description: "Perfect for summer, these Gap Casual Shorts are crafted from breathable cotton fabric and feature a relaxed fit for all-day comfort. Whether you're heading to the beach or enjoying a casual day out, these shorts have you covered.",
          price: 29.99,
          imageUrl: 'https://th.bing.com/th/id/R.7299d294e0bcc212a5b46fc2b7a2b98e?rik=G%2bWcWliZsLRI1A&pid=ImgRaw&r=0',
          categoryId: 2
      ),
      Product(
          id: 16,
          name: 'Columbia Sun Hat',
          description: 'Stay cool and protected from the sun with the Columbia Sun Hat. Featuring a wide brim and UV protection, this hat is a stylish and practical accessory for outdoor activities like hiking, fishing, or relaxing at the beach.',
          price: 24.99,
          imageUrl: 'https://th.bing.com/th/id/R.292a7e43fbc459dc7555fb7ab0f4a23d?rik=m3l8ocku9ndthw&pid=ImgRaw&r=0',
          categoryId: 2
      ),

// Home Appliances
      Product(
          id: 17,
          name: 'Samsung French Door Refrigerator',
          description: 'An energy-efficient side-by-side refrigerator with a spacious French door design that allows for easy access to fresh and frozen foods. Features adjustable shelves, a built-in water and ice dispenser, and digital temperature control to keep your groceries fresh for longer.',
          price: 1299.99,
          imageUrl: 'https://th.bing.com/th/id/R.a8b7b493c729a438ce1ca34d591e77db?rik=LVJ3KeNU8C2V6g&pid=ImgRaw&r=0',
          categoryId: 3),
      Product(
          id: 18,
          name: 'LG Front Load Washing Machine',
          description: 'A high-efficiency, front-loading washing machine with multiple wash cycles and a large capacity drum to handle big loads. Equipped with smart technology that offers remote control, real-time notifications, and customized cycles through a mobile app. Quiet operation and water-saving features make it an ideal choice for eco-conscious households.',
          price: 699.99,
          imageUrl: 'https://th.bing.com/th/id/R.87ffe829e6f86290cc89cfae35a614f2?rik=ZIJQDDTguwh6JA&pid=ImgRaw&r=0',
          categoryId: 3),
      Product(
          id: 19,
          name: 'Panasonic Microwave Oven',
          description: 'A versatile counter-top microwave oven with smart sensors that automatically adjust cooking times and power levels for optimal results. Features a compact design, easy-to-clean interior, and multiple preset options for defrosting, reheating, and cooking a variety of foods, making it perfect for quick meals and snacks.',
          price: 149.99,
          imageUrl: 'https://th.bing.com/th/id/R.fcd30b0d144e272c6b91584858913793?rik=ldeN4tTy3WD5kg&pid=ImgRaw&r=0&sres=1&sresct=1',
          categoryId: 3),
      Product(
          id: 20,
          name: 'Dyson Cordless Vacuum Cleaner',
          description: 'A lightweight and powerful cordless stick vacuum cleaner that provides deep cleaning on all floor types, from carpets to hard floors. Comes with multiple attachments for versatile cleaning and a long-lasting battery that delivers fade-free suction for up to 60 minutes. Easy to empty and maintain, it’s ideal for quick clean-ups and large homes alike.',
          price: 299.99,
          imageUrl: 'https://th.bing.com/th/id/R.ef1aff65bdb76831ff11ab4cc411ae61?rik=RyoMkNdb6fGULA&pid=ImgRaw&r=0',
          categoryId: 3),
      Product(
          id: 21,
          name: 'Carrier Air Conditioner',
          description: 'A split system air conditioner that provides powerful cooling and heating, ensuring comfort all year round. Features a digital thermostat, multiple fan speeds, and an energy-saving mode for efficient operation. Comes with a remote control for easy adjustment of temperature and settings from anywhere in the room.',
          price: 899.99,
          imageUrl: 'https://th.bing.com/th/id/R.ae4b07220a387189e99e9b4364c3de4d?rik=DbfKucrM7JX%2fBw&pid=ImgRaw&r=0',
          categoryId: 3),
      Product(
          id: 22,
          name: 'Bosch Dishwasher',
          description: 'A high-performance, quiet operation dishwasher with multiple wash cycles and a spacious interior that can handle large loads. Features a stainless steel tub, adjustable racks, and a sanitize option to remove bacteria and ensure spotless dishes. Energy-efficient and designed with advanced leak protection technology for worry-free operation.',
          price: 549.99,
          imageUrl: 'https://th.bing.com/th/id/R.cec0f7d11ccab84bbc8b285fcbcd1b00?rik=586cqSZFVpCpXQ&pid=ImgRaw&r=0',
          categoryId: 3),
      Product(
          id: 23,
          name: 'Keurig Coffee Maker',
          description: 'A programmable coffee maker with a built-in grinder that grinds fresh beans for every brew, ensuring a rich, full flavor in every cup. Offers multiple brew sizes and a customizable strength setting to suit every coffee lover’s taste. Comes with an auto-off feature for safety and energy efficiency, and is compatible with K-Cups and ground coffee.',
          price: 179.99,
          imageUrl: 'https://th.bing.com/th/id/R.85b2424cca161a9e10e81d16766c97ec?rik=%2b96SeHuKdL7QtA&pid=ImgRaw&r=0',
          categoryId: 3),
      Product(
          id: 24,
          name: 'Cuisinart Toaster',
          description: 'A stylish 4-slice toaster with a bagel function, multiple shade settings, and extra-wide slots for a variety of breads, bagels, and pastries. Features a high-lift lever for easy removal of smaller items and a slide-out crumb tray for easy cleaning. Perfect for making breakfast quickly and easily every day.',
          price: 59.99,
          imageUrl: 'https://th.bing.com/th/id/R.52d6a1c87cd9120e7b3d9937ebaed139?rik=i4lIX15YNGjB0Q&pid=ImgRaw&r=0',
          categoryId: 3),

      // Sports & Outdoors
      Product(
          id: 25,
          name: 'Nike Running Shoes',
          description: 'High-performance running shoes designed with a breathable mesh upper for enhanced airflow, keeping your feet cool and comfortable during long runs. Features a cushioned midsole for responsive energy return, durable rubber outsoles for superior traction, and a lightweight design that reduces fatigue, perfect for both professional athletes and casual runners.',
          price: 89.99,
          imageUrl: 'https://th.bing.com/th/id/R.77eed415b01a3ec4f6cb7758a5a2a6d4?rik=uAVWPwlxDVm1Wg&pid=ImgRaw&r=0',
          categoryId: 4),
      Product(
          id: 26,
          name: 'Garmin Fitness Watch',
          description: 'A GPS-enabled fitness watch with heart rate monitoring and advanced activity tracking features, including step counting, sleep analysis, and calorie burn tracking. Water-resistant up to 50 meters, this watch is perfect for swimmers, runners, and outdoor enthusiasts. Syncs with a smartphone app for real-time notifications and personalized coaching.',
          price: 199.99,
          imageUrl: 'https://th.bing.com/th/id/R.20397013060755a24dcdb08cdf25de05?rik=ObiIfVHlgiOXKg&pid=ImgRaw&r=0',
          categoryId: 4),
      Product(
          id: 27,
          name: 'Coleman Tent',
          description: 'A durable and waterproof camping tent that comfortably sleeps up to four people. Features a robust frame resistant to strong winds, a rainfly for extra weather protection, and a ventilated design for improved airflow. Easy to set up and pack down, making it ideal for weekend getaways, family camping trips, and outdoor adventures.',
          price: 149.99,
          imageUrl: 'https://assets.basspro.com/image/list/fn_select:jq:first(.%5B%5D%7Cselect(.public_id%20%7C%20endswith(%22main%22)))/2385351.json',
          categoryId: 4),
      Product(
          id: 28,
          name: 'Yonex Badminton Racket',
          description: 'A high-quality badminton racket crafted from lightweight graphite for maximum agility and precision. Features an isometric head shape that expands the sweet spot, enhancing accuracy and power. Designed for both beginners and advanced players, this racket offers superior control and speed for competitive play.',
          price: 89.99,
          imageUrl: 'https://th.bing.com/th/id/R.f06b0f3afb1da42cb66ac17b4aa6fb9e?rik=ilPEJ4UL3CvHFA&pid=ImgRaw&r=0',
          categoryId: 4),
      Product(
          id: 29,
          name: 'Hydro Flask Water Bottle',
          description: 'An insulated water bottle made from high-quality stainless steel, designed to keep beverages cold for up to 24 hours or hot for up to 12 hours. Features a leak-proof lid, a slip-free powder coating, and a durable build that withstands drops and dents. Perfect for hiking, camping, workouts, or everyday hydration.',
          price: 39.99,
          imageUrl: 'https://th.bing.com/th/id/R.5fba9121d496521bf23acd82ff8f5eee?rik=q1NxyrgHeaq%2bLw&pid=ImgRaw&r=0',
          categoryId: 4),
      Product(
          id: 30,
          name: 'Under Armour Sports Bra',
          description: 'A comfortable and supportive sports bra with moisture-wicking fabric that keeps you dry and cool during intense workouts. Designed with a four-way stretch construction for unrestricted movement, breathable mesh panels for enhanced ventilation, and a secure fit to minimize bounce, making it ideal for running, gym sessions, and high-impact activities.',
          price: 34.99,
          imageUrl: 'https://th.bing.com/th/id/R.6d6b86ce3ec9ce5a5a82c57b4b049f2b?rik=8yudPo81jacKAA&riu=http%3a%2f%2fcdn.allvolleyball.com%2fimages%2fuploads%2fcategory_119_5613.png&ehk=yqGp%2buuR3UYaIwaccqmLYPLMMPBDXPkIoG3By12kVOM%3d&risl=&pid=ImgRaw&r=0',
          categoryId: 4),

    ];

    for (var product in products) {
      await dbHelper.insertProduct(product);
    }

    print("Database seeding completed successfully");
  } catch (e) {
    print("Error seeding database: $e");
  }
}
