// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../widgets/cards_grid_view.dart';

class BlackJackScreen extends StatefulWidget {
  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool isGameStarted = false;
  List<Image> playerCards = [];
  List<Image> dealersCards = [];

  String? dealersFirstCard;
  String? dealersSecondCard;

  String? playersFirstCard;
  String? playersSecondCard;
  int playerScore = 0;
  int dealerScore = 0;

  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };

  Map<String, int> playingCards = {};

  @override
  void initState() {
    super.initState();

    playingCards.addAll(deckOfCards);
  }

  void changeCards() {
    setState(() {
      isGameStarted = true;
    });
    playingCards = {};
    playingCards.addAll(deckOfCards);
    playerCards = [];
    dealersCards = [];

    Random random = Random();
    String cardOneKey = playingCards.keys.elementAt(random
        .nextInt(playingCards.length)); //from 1 to playingCards.length включая
    playingCards.removeWhere((key, value) =>
        key ==
        cardOneKey); // Making sure cards are unique and remove cardOneKey from playingCards

    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));

    playingCards.removeWhere((key, value) => key == cardThreeKey);

    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));

    playingCards.removeWhere((key, value) => key == cardFourKey);

    dealersFirstCard = cardOneKey;
    dealersSecondCard = cardTwoKey;
    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;
    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));
    dealerScore =
        deckOfCards[dealersFirstCard]! + deckOfCards[dealersSecondCard]!;

    playerCards.add(Image.asset(playersFirstCard!));
    playerCards.add(Image.asset(playersSecondCard!));
    playerScore =
        deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!;

    if (dealerScore <= 14) {
      String thirdDealersCardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == thirdDealersCardKey);
      dealersCards.add(Image.asset(thirdDealersCardKey));
      dealerScore += deckOfCards[thirdDealersCardKey]!;
    }
  }

  void addCard() {
    Random random = Random();
    if (playingCards.length > 0) {
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere(((key, value) => key == cardKey));
      setState(() {
        playerCards.add(
          Image.asset(cardKey),
        );
      });
      playerScore = playerScore + deckOfCards[cardKey]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGameStarted
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    //Dealers cards
                    Column(
                      children: [
                        Text(
                          "Счет дилера: $dealerScore",
                          style: TextStyle(
                              color: dealerScore <= 21
                                  ? Colors.green
                                  : Colors.red[900]),
                        ),
                        SizedBox(height: 20),
                        CardsGridView(cards: dealersCards),
                      ],
                    ),
                    //Players cards
                    Column(
                      children: [
                        Text(
                          "Ваш счет: $playerScore",
                          style: TextStyle(
                              color: playerScore <= 21
                                  ? Colors.green
                                  : Colors.red[900]),
                        ),
                        SizedBox(height: 20),
                        CardsGridView(cards: playerCards),
                      ],
                    ),
                    //2 buttons
                    IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MaterialButton(
                            child: Text("Взять карту"),
                            color: Colors.greenAccent,
                            onPressed: addCard,
                          ),
                          MaterialButton(
                            child: Text("Следующий раунд"),
                            color: Colors.greenAccent,
                            onPressed: changeCards,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: MaterialButton(
                onPressed: changeCards,
                child: Text("Start Game"),
                color: Colors.greenAccent,
              ),
            ),
    );
  }
}
