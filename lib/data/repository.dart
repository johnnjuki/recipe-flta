// This is a repository interface that provides methods
// to add and delete recipes and ingredients.

import 'models/models.dart';

abstract class Repository {
  // Watch for any changes to the list of recipes.
  // For example, if the user did a new search, it updates the list of recipes
  // and notifies listeners accordingly.
  Stream<List<Recipe>> watchAllRecipes();
  // Listen for changes in the ingredients list displayed on the Groceries screen.
  Stream<List<Ingredient>> watchAllIngredients();

  // Find recipes and ingredients
  Future<List<Recipe>> findAllRecipes();

  Future<Recipe> findRecipeById(int id);

  Future<List<Ingredient>> findAllIngredients();

  Future<List<Ingredient>> findRecipeIngredients(int recipeId);

  // Add recipes and ingredients
  Future<int> insertRecipe(Recipe recipe);

  Future<List<int>> insertIngredients(List<Ingredient> ingredients);

  // Delete unwanted recipes and ingredients
  Future<void> deleteRecipe(Recipe recipe);

  Future<void> deleteIngredient(Ingredient ingredient);

  Future<void> deleteIngredients(List<Ingredient> ingredients);

  Future<void> deleteRecipeIngredients(int recipeId);

  // Initialize and close the repository
  Future init();

  void close();
}
