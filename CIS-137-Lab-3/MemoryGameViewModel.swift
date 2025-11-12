/*
 *  Noa Tomas Mandorf
 *  November 11, 2025
 */

import SwiftUI

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGameModel = CreateMemoryGame()
    
    static let flowers = Bundle.main.decode([Flower].self, from: "flowers.json")
    
    static func CreateMemoryGame() -> MemoryGameModel {
        return MemoryGameModel(numberOfPairs: 5, contentFactory: makeContent)
    }
    
    static func makeContent(index: Int) -> Flower {
        return flowers[index]
    }
    
    var cards: Array<MemoryGameModel.Card> {
        model.cards
    }
    
    var pairs: Int {
        model.numberOfPairs
    }
    
    func choose(card: MemoryGameModel.Card) {
        model.chooseCard(card: card)
    }
    var complete: Double {
        model.matechedPair
    }
}
