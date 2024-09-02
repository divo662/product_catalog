import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:product_catalog_app/providers/product_provider.dart';
import 'package:product_catalog_app/sql/data_seeding_function.dart';
import 'package:product_catalog_app/sql/database_helper.dart';
import 'package:provider/provider.dart';
import 'core/res/app_strings.dart';
import 'core/routes/app_routing_logic.dart';
import 'core/widgets/widgets_components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  final dbHelper = DatabaseHelper();
  bool isSeeded = await dbHelper.isDatabaseSeeded();
  if (!isSeeded) {
    await seedDatabase(dbHelper);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const ProductCatalog(),
    ),
  );
}

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({
    super.key,
  });

  @override
  _ProductCatalogState createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          title: AppStrings.appName,
        );
      },
    );
  }
}

Future<bool> _requestPermissions() async {
  if (await Permission.storage.isGranted) {
    return true;
  }

  final status = await Permission.storage.request();

  if (status.isGranted) {
    return true;
  } else if (status.isPermanentlyDenied) {
    return false;
  } else {
    return false;
  }
}
