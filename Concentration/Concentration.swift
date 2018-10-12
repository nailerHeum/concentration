//
//  Concentration.swift
//  Concentration
//
//  Created by CSHeum on 20/09/2018.
//  Copyright © 2018 CSHeum. All rights reserved.
//

import Foundation
struct Concentration {
  private(set) var cards = [Card]()
  private var indexOfOneAndOnlyFaceUpCard: Int? {
    get {
      return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
    }
    set {
      for index in cards.indices {
        cards[index].isFaceUp = (index == newValue)
      }
    }
  }

  mutating func chooseCard(at index: Int) { //변경가능하게 만들기
    assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not  in the cards ")
    if !cards[index].isMatched {
      
      if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
        
        if cards[matchIndex] == cards[index] {
          
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
        }
        cards[index].isFaceUp = true
        
      } else {
        indexOfOneAndOnlyFaceUpCard = index
      }
    }
  }

  init(numberOfPairsOfCards: Int){
    assert(numberOfPairsOfCards > 0, "Concentration.index(at: \(numberOfPairsOfCards)): you must have at least 1 pair of cards. ")

    for _ in 0..<numberOfPairsOfCards {
        let card = Card()
        cards += [card, card]
    }
    cards.shuffle()
  }
  // TODO: suffle the cards > HOMEWORk
}

extension Collection {
  var oneAndOnly: Element? {
    return count == 1 ? first : nil
  }
}

// line 13 >>> closure로 대체된 것
//return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil

//      var foundIndex: Int?
//      for index in cards.indices {
//        if cards[index].isFaceUp {
//          if foundIndex == nil {
//            foundIndex = index
//          } else {
//            return nil
//          }
//        }
//      }
//      return foundIndex         Closure의 강력함

