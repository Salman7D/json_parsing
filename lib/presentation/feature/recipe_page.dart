import 'dart:convert';
import 'package:assignment_11/Core/recipe.dart';
import 'package:assignment_11/presentation/core/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  List<Recipe> recipes = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {

      final String response =
      await rootBundle.loadString('assets/recipes.json');

      final Map<String, dynamic> data =
      jsonDecode(response);

      final List<dynamic> recipeList = data['recipes'];

      final List<Recipe> loadedRecipes = recipeList
          .map((item) => Recipe.fromJson(item))
          .toList();

      if (!mounted) return;

      setState(() {
        recipes = loadedRecipes;
        isLoading = false;
      });

    } catch (e) {

      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load recipes: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Food Recipes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : errorMessage != null
          ? Center(
        child: Text(errorMessage!),
      )

          : recipes.isEmpty
          ? const Center(
        child: Text('No recipes found!'),
      )

          : ListView.builder(
        itemCount: recipes.length,

        itemBuilder: (context, index) {

          final recipe = recipes[index];

          return RecipeCard(
            recipe: recipe,
          );
        },
      ),
    );
  }
}
