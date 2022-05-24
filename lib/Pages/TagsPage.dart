import 'package:flutter/material.dart';
import 'package:lab3/Model/Recipe.dart';
import 'package:lab3/Pages/Main_screen.dart';
import 'package:lab3/Pages/TagResultPage.dart';

class TagsPage extends StatefulWidget {
  final List<Recipe> favoriteList;
  TagsPage({Key? key, required this.favoriteList}) : super(key: key);

  @override
  TagsPageState createState() => TagsPageState(this.favoriteList);
}

class TagsPageState extends State<TagsPage> {

  TagsPageState(this.favoriteList);

  final favoriteList;
  final RecipeData recipeData = RecipeData();
  List<Recipe> favoriteRecipes = [];
  List<String> tagsList = [];
  List<String> list = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    favoriteRecipes = favoriteList;
    tagsList = recipeData.tagsDataLists;
  }

  void searchTag(String query) {
    final suggestions = tagsList.where((tag) {
      final tagTitle = tag.toLowerCase();
      final input = query.toLowerCase();

      return tagTitle.contains(input);
    }).toList();
    setState(() => tagsList = suggestions);
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
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                  children: [
                    Container(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Tag title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),
                        onChanged: searchTag,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: tagsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final tag = tagsList[index];
                          return Center(
                            child: SingleChildScrollView(
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.7,
                                child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (
                                                      BuildContext context) =>
                                                      TagResultPage(
                                                        favoriteList: favoriteRecipes,
                                                        tagName: tag,
                                                      )
                                              )
                                          );
                                        },
                                        child: Center(
                                          child: Text(tag),
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ]
              );
            }
          ),
    );
  }
}
