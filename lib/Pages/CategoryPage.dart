import 'package:flutter/material.dart';
import 'package:lab3/Model/Recipe.dart';
import 'package:lab3/Pages/RecipePage.dart';
import 'package:lab3/Pages/Main_screen.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  final List<Recipe> favoriteList;
  CategoryPage({Key? key, required this.categoryName, required this.favoriteList}) : super(key: key);

  @override
  CategoryPageState createState() => CategoryPageState(this.categoryName, this.favoriteList);
}

class CategoryPageState extends State<CategoryPage> {

  CategoryPageState(this.categoryName, this.favoriteList);

  final favoriteList;
  final categoryName;
  final RecipeData recipeData = RecipeData();
  Recipe emptyRecipe = new Recipe(recipeName: 'Список улюблених категорій поки що пустий');
  List<Recipe> categoryList = [];
  List<Recipe> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    favoriteRecipes = favoriteList;
    if(categoryName == 'Перші страви (супи)'){
      categoryList = recipeData.soupDataList;
    }
    else if(categoryName == 'Другі страви (каші, страви з м’яса)'){
      categoryList = recipeData.porridgeDataList;
    }
    else if(categoryName == 'Салати та закуски'){
      categoryList = recipeData.saladsAndAppetizerDataList;
    }
    else if(categoryName == 'Десерти'){
      categoryList = recipeData.dessertsDataList;
    }
    else if(categoryName == 'Напої'){
      categoryList = recipeData.drinksDataList;
    }
    else if(categoryName == 'Випічка'){
      categoryList = recipeData.bakingDataList;
    }
    else if(categoryName == 'Улюблені'){
      if(favoriteRecipes.isNotEmpty)
        categoryList = favoriteList;
      else
        categoryList.add(emptyRecipe);
    }
    else{
      categoryList = [];
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додаток з рецептами'),
        centerTitle: true,
      ),
      body:
      ListView.builder(
          shrinkWrap: true,
          itemCount: categoryList.length,
          itemBuilder: (BuildContext context, int index){
            if(categoryList[index].recipeName == emptyRecipe.recipeName)
              {
                return Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 100),),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MainScreen(favoriteList: favoriteRecipes,)
                                  )
                              );
                            },
                            child: const Text('Повернутися до списку категорій')),
                      ],
                    )
                  ],
                );
              }
            else {
              return Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    child: Column(
                        children: <Widget>[
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          Column(
                              children: [
                                Text(categoryList[index].recipeName,
                                  style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,),),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.7,
                                  child: Image.asset(categoryList[index].image,
                                    fit: BoxFit.contain,),
                                ),
                              ]
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Категорія: ', style: TextStyle(
                                  fontWeight: FontWeight.bold,),),
                                Flexible(
                                  child: Text(
                                    categoryList[index].categoryName,),
                                ),
                              ]
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Час приготування: ', style: TextStyle(
                                    fontWeight: FontWeight.bold),),
                                Text(categoryList[index].cookingTime
                                    .toString(),),
                              ]
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Складність приготування: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                Flexible(
                                  child: Text(
                                    categoryList[index].complexityCooking,),
                                ),
                              ]
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          Row(
                              children: const [
                                Text('Ціна інгредієнтів: ', style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                              ]
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: categoryList[index].ingredientsPrice
                                  .length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  child: Text(
                                      categoryList[index].ingredientsPrice[i]
                                          .keys.first + '  –  ' +
                                          categoryList[index]
                                              .ingredientsPrice[i].values.first
                                              .toString() + ' грн.'
                                  ),
                                );
                              }),
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          Row(
                              children: const [Text('Список тегів: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              ]
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: categoryList[index].tegs.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  child: Text(categoryList[index].tegs[i]),
                                );
                              }),
                          //Text('Список тегів: ' + categoryList[index].tegs.iterator.toString()),
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            RecipePage(
                                              element: categoryList[index],
                                              favoriteList: favoriteRecipes,
                                            )
                                    )
                                );
                              },
                              child: const Text('Перейти до рецепту')),
                          const Padding(padding: EdgeInsets.only(top: 10),),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MainScreen(
                                              favoriteList: favoriteRecipes,)
                                    )
                                );
                              },
                              child: const Text(
                                  'Повернутися до списку категорій')),
                          const Padding(padding: EdgeInsets.only(top: 50),),
                        ]
                    ),
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
