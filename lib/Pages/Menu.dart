import 'package:flutter/material.dart';
import 'package:lab3/Pages/Main_screen.dart';
import 'package:lab3/Model/Recipe.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  List<Recipe> favoriteRecipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Додаток з рецептами'),
          centerTitle: true,
        ),
        body: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MainScreen(favoriteList: favoriteRecipes,)
                      )
                  );
                },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                  ),
                  child: Text('На головну'),)
              ],
            )
          ],
        )
    );
  }
}
