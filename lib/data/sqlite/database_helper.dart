import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

import '../models/models.dart';

// This class will handle all the SQLite database operations
class DatabaseHelper {
  static const _databaseName = 'MyRecipes.db';
  static const _databaseVersion = 1;

  static const recipeTable = 'Recipe';
  static const ingredientTable = 'Ingredient';
  static const recipeId = 'recipeId';
  static const ingredientId = 'ingredientId';

  // SQLBrite database instance
  static late BriteDatabase _streamDatabase;

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static var lock = Lock();

  // only have a single app-wide reference to the database
  static Database? _database;

  // SQL code to create the database tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $recipeTable (
        $recipeId INTEGER PRIMARY KEY,
        label TEXT,
        image TEXT,
        url TEXT,
        calories REAL,
        totalWeight REAL,
        totalTime REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE $ingredientTable (
        $ingredientId INTEGER PRIMARY KEY,
        $recipeId INTEGER,
        name TEXT,
        weight REAL
      )
    ''');
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _databaseName);
    // TODO: Remember to turn off debugging before deploying app to stores.
    Sqflite.setDebugModeOn(true);
    // Create and store the database file in path
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Open and create the database, if it hasn't been created before
  Future<Database> get database async {
    if (_database != null) return _database!;
    // use this object to prevent concurent access to the data
    await lock.synchronized(() async {
      // lazily instantiate the db the first time it is accessed
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  // use this for the stream methods in the repository,
  // as well as to insert and delete data
  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<Recipe> parseRecipes(List<Map<String, dynamic>> recipeList) {
    final recipes = <Recipe>[];
    for (var recipeMap in recipeList) {
      final recipe = Recipe.fromJson(recipeMap);
      recipes.add(recipe);
    }
    return recipes;
  }

  List<Ingredient> parseIngredients(List<Map<String, dynamic>> ingredientList) {
    final ingredients = <Ingredient>[];
    for (var ingredientMap in ingredientList) {
      final ingredient = Ingredient.fromJson(ingredientMap);
      ingredients.add(ingredient);
    }
    return ingredients;
  }
}
