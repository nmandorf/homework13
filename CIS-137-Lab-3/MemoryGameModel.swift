/*
 *  Noa Tomas Mandorf
 *  November 11, 2025
 */

import Foundation

struct MemoryGameModel {
    private(set) var cards: Array<Card>
    private(set) var numberOfPairs: Int
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    var matechedPair: Double = 0.0
    
    struct Card: Identifiable {
        var imageFile: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var id: String
    }
    
    mutating func chooseCard(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {

            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {

                if cards[potentialMatchIndex].imageFile == cards[chosenIndex].imageFile {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    matechedPair = matechedPair + (1/Double(numberOfPairs))
                    
                }

                cards[chosenIndex].isFaceUp = true
                indexOfTheOneAndOnlyFaceUpCard = nil

            } else {
                for index in cards.indices {
                    if !cards[index].isMatched {
                        cards[index].isFaceUp = false
                    }
                }

                cards[chosenIndex].isFaceUp = true
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairs: Int, contentFactory: (Int) -> Flower) {
        cards = []
        self.numberOfPairs = numberOfPairs
        
        for index in 0..<numberOfPairs {
            let content = contentFactory(index)
            cards.append(Card(imageFile: content.file, id: String(content.id)))
            cards.append(Card(imageFile: content.file, id: "\(content.id)-duplicate"))
        }
        cards.shuffle()
    }
}
