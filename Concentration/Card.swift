//
//  Card.swift
//  Concentration
//
//  Created by CSHeum on 20/09/2018.
//  Copyright © 2018 CSHeum. All rights reserved.

import Foundation

struct Card: Hashable {
  //hashable features
  var hashValue: Int {return identifier}
  static func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.identifier == rhs.identifier
  }
  
  var isFaceUp = false  // 앞면 or 뒷면
  var isMatched = false // match or dismatch
  private var identifier: Int // which card is this
  
  private static var identifierFactory = 0  // making identifier
  private static func getUniqIdentifier() -> Int {
      identifierFactory += 1
      return identifierFactory
  }
  
  init(){
      self.identifier = Card.getUniqIdentifier()  //card 생성시 uniq id 생성
  }
  
}
