import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../network/recipe_model.dart';
<<<<<<< HEAD
import '../../data/models/models.dart';
import '../../data/repository.dart';
=======
>>>>>>> 4df485a (Fetch and display recipes from Edamam Recipe API)
import '../colors.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({
    Key? key,
    required this.recipe,
  }) : super(key: key);
<<<<<<< HEAD
  final Recipe recipe;
=======
  final APIRecipe recipe;
>>>>>>> 4df485a (Fetch and display recipes from Edamam Recipe API)

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CachedNetworkImage(
<<<<<<< HEAD
                        imageUrl: recipe.image ?? '',
=======
                        // TODO 1
                        imageUrl: recipe.image,
>>>>>>> 4df485a (Fetch and display recipes from Edamam Recipe API)
                        alignment: Alignment.topLeft,
                        fit: BoxFit.fill,
                        width: size.width,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: shim),
                        child: const BackButton(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
<<<<<<< HEAD
                    recipe.label ?? '',
=======
                    // TODO 2
                    recipe.label,
>>>>>>> 4df485a (Fetch and display recipes from Edamam Recipe API)
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Chip(
<<<<<<< HEAD
=======
                    // TODO 3
>>>>>>> 4df485a (Fetch and display recipes from Edamam Recipe API)
                    label: Text(getCalories(recipe.calories)),
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                    ),
                    onPressed: () {
                      repository.insertRecipe(recipe);
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icon_bookmark.svg',
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Bookmark',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
