import 'package:assignment_11/presentation/feature/recipe_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Recipes',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const RecipePage(),
    );
  }
}
