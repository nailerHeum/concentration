//
//  ViewController.swift
//  Concentration
//
//  Created by CSHeum on 16/09/2018.
//  Copyright © 2018 CSHeum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    //UIViewController is the super class
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
  var numberOfPairsOfCards: Int { // view의 cardButton의 갯수로 알아낸 카드쌍갯수
    get {
      return (cardButtons.count + 1) / 2
    }
  }
  
  private(set) var flipCount = 0 {         // didset을통해 filpCount의 값에 변화가 있을 경우 filpCountLabel을 변경한다.
    didSet{
      updateFlipCountLabel()
    }
  }
  private func updateFlipCountLabel() {
    let attributes: [NSAttributedString.Key:Any] = [
      .strokeColor : #colorLiteral(red: 0.9994240403, green: 0.7636020136, blue: 0, alpha: 1),
      .strokeWidth : 5.0
    ]
    let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
    flipCountLabel.attributedText = attributedString
  }
  @IBOutlet private var cardButtons: [UIButton]!
  @IBOutlet private weak var flipCountLabel: UILabel! {
    didSet{
      updateFlipCountLabel()
    }
  }
  @IBAction private func touchCard(_ sender: UIButton) {//모든 argument에 이름이 두개 붙는다.
    //print("agh! a ghost!")              //내부에서 사용할 이름과 외부에서 사용할 이름 두개
    //flipCard(withEmoji: "👻", on: sender)   //_(underbar)는 argument가 없다는 뜻이다.
    flipCount += 1  // flipCount의 값 변경 -> didSet 발동
    // unwrapping optional type
    if let cardNumber = cardButtons.index(of: sender) {  // 선택한 cardButton의 index를 갖고옴
      game.chooseCard(at: cardNumber) // card 선택 method
      updateViewFromModel()   // model에서 갖고온 정보를 view에 반영

    } else {
        print("Chosen card was not in cardButtons");
    }   // 예외의 경우
  
  }

//  func flipCard(withEmoji emoji: String, on button: UIButton){  // 카드 뒤집기
//      if button.currentTitle == emoji {
//          button.setTitle("", for: UIControl.State.normal)
//          button.backgroundColor = #colorLiteral(red: 1, green: 0.7615830881, blue: 0.03281438917, alpha: 1)
//      } else {
//          button.setTitle(emoji, for: UIControl.State.normal)
//          button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//      }
//  }

  private func updateViewFromModel() {
      for index in cardButtons.indices {
          let button = cardButtons[index]
          let card = game.cards[index]
          if card.isFaceUp{   // 카드가 앞면일 경우 그림 보여줌
              button.setTitle(emoji(for: card), for: UIControl.State.normal)
              button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          } else {    // 뒷면이면 가림
              button.setTitle("", for: UIControl.State.normal)
              button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.7603067952, blue: 0.008288363956, alpha: 0) : #colorLiteral(red: 0.9994240403, green: 0.7636020136, blue: 0, alpha: 1) // isMatched 일경우 투명하게, 아니라면 뒷면을 보여줌
          }
      }
  }
  
  //private var emojiChoices = ["🦇", "😱", "🙀", "👿", "🎃", "👻", "🍭", "🍬", "🍎"]
  private var emojiChoices = "🦇😱🙀👿🎃👻🍭🍬🍎"
  private var emoji = [Card : String]()
  private func emoji(for card: Card) -> String {
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }     // same code with below
      if emoji[card] == nil, emojiChoices.count > 0{
        let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
          emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
          // remove method가 해당 index의 이모지를 array에서 삭제하며 return시킴
      }
      return emoji[card] ?? "?"
      // ??으로 해당 emoji가 nil일 경우 ? return 
  }
}

extension Int {
  var arc4random : Int {
    if self > 0{
      return Int(arc4random_uniform(UInt32(self)))
    } else if self < 0 {
      return -Int(arc4random_uniform(UInt32(self)))
    } else {
      return 0
    }
  }
}
