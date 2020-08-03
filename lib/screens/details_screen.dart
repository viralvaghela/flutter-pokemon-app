import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:pokemon/model/pokehub.dart';

class Details extends StatelessWidget {
  PokeHub pokemon;
  int index;

  Details({this.pokemon, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${pokemon.pokemon[index].name}"),
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  //get type
                  getType(index),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Height : ${pokemon.pokemon[index].height}   ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Weight : ${pokemon.pokemon[index].weight}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  //get weakness
                  Text(
                    "Weakness",
                    style: TextStyle(fontSize: 20),
                  ),
                  getWeakness(index),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ////get egg details
                      pokemon.pokemon[index].egg != "Not in Eggs"
                          ? Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Colors.lightBlue,
                                    Colors.yellow
                                  ]),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/egg.png",
                                            height: 70, width: 90),
                                        Text(
                                          "${pokemon.pokemon[index].egg}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      pokemon.pokemon[index].candyCount != null
                          ? Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Colors.lightBlue,
                                    Colors.yellow
                                  ]),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset("assets/candy.png",
                                            height: 70, width: 90),
                                        Text(
                                          "${pokemon.pokemon[index].candyCount}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: "${pokemon.pokemon[index].id}",
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(pokemon.pokemon[index].img))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getWeakness(index) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < pokemon.pokemon[index].weaknesses.length; i++) {
      list.add(FilterChip(
        label: Text(
          "${pokemon.pokemon[index].weaknesses[i]}",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        onSelected: (bool value) {},
      ));
    }
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.center, children: list));
  }

  getType(index) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < pokemon.pokemon[index].type.length; i++) {
      list.add(FilterChip(
        label: Text(
          "${pokemon.pokemon[index].type[i]}",
          style: TextStyle(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        onSelected: (bool value) {},
      ));
    }
    return new Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }
}
