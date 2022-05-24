import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab3/Model/Recipe.dart';
import 'package:lab3/Pages/CategoryPage.dart';

class RecipePage extends StatefulWidget {
  Recipe element;
  final List<Recipe> favoriteList;
  RecipePage({Key? key, required this.element, required this.favoriteList}) : super(key: key);

  @override
  RecipePageState createState() => RecipePageState(this.element, this.favoriteList);
}

class RecipePageState extends State<RecipePage> {

  RecipePageState(this.element, this.favoriteList);

  final favoriteList;
  final element;
  Recipe recipe = Recipe();
  List<Recipe> favoriteRecipes = [];
  bool check = false;
  //final RecipeData recipeData = RecipeData();
  //List<Recipe> categoryList = [];

  @override
  void initState() {
    super.initState();
    recipe = element;
    favoriteRecipes = favoriteList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додаток з рецептами'),
        centerTitle: true,
      ) ,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Column(
                    children: [
                      Text(recipe.recipeName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Image.asset(recipe.image, fit: BoxFit.contain,),
                      ),
                    ]),
                const Padding(padding: EdgeInsets.only(top: 10),),
                Row(
                    children: const [Text('Інгредієнти: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    ]
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipe.ingredients.length,
                    itemBuilder: (BuildContext context, int i){
                      return Container(
                        child: Text(recipe.ingredients[i]),
                      );
                    }),
                const Padding(padding: EdgeInsets.only(top: 10),),
                Row(
                    children: const [Text('Кроки приготування: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    ]
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipe.cookingSteps.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        child: Text((index + 1).toString() +'. ' + recipe.cookingSteps[index]),
                      );
                    }),
                const Padding(padding: EdgeInsets.only(top: 10),),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CategoryPage(
                                    categoryName: recipe.categoryName,
                                    favoriteList: favoriteRecipes,
                                  )
                          )
                      );
                    },
                    child: Text('Повернутися до категорії'),
                ),
                const Padding(padding: EdgeInsets.only(top: 10),),
                ElevatedButton(
                  onPressed: () {
                    for(int i = 0; i < favoriteRecipes.length; i++)
                    {
                      if (favoriteRecipes[i].recipeName == recipe.recipeName)
                      {
                        check = true;
                      }
                    }
                    if(check == true)
                    {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text('Попередження!'),
                              content: const Text(
                                  'Ви вже добавили даний рецепт до улюблених!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    }
                    else {
                      favoriteRecipes.add(recipe);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              content: const Text(
                                  'Даний рецепт був добавлений до улюблених'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    }
                    },
                  child: Text('Додати рецепт до улюблених'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
