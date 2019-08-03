//
//  ViewController.swift
//  CardSwipeApp
//
//  Created by 大嶺舜 on 2019/08/03.
//  Copyright © 2019 大嶺舜. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var baseCard: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    @IBOutlet weak var person5: UIView!
    
    // カードの中心
    var centerOfCard: CGPoint!
    
    // ユーザーカードの配列
    var people = [UIView]()
    
    // 選択されたカードの数を数える変数
    var selectedCardCount: Int = 0
    
    // ユーザーネームの配列
    let name = ["津田梅子", "ジョージワシントン", "ガリレオガリレイ", "ジョン万次郎", "板垣退助"]
    
    // いいねされた名前の配列
    var likedName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = baseCard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
        people.append(person5)
    }
    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
        if sender.state == UIGestureRecognizer.State.ended{
            if card.center.x < 50 {
                // 左に大きくスワイプしたときの処理
                UIView.animate(withDuration: 0.2, animations: {
                    // ベースカードを元の位置に戻す
                    self.baseCard.center = self.centerOfCard
                    // 該当のユーザーカードを画面外(マイナス方向)へ飛ばす
                    self.people[self.selectedCardCount].center = CGPoint(x:self.people[self.selectedCardCount].center.x - 500, y: self.people[self.selectedCardCount].center.y)
                })
                return
            } else if card.center.x > self.view.frame.width - 50 {
                // 右に大きくスワイプしたときの処理
                UIView.animate(withDuration: 0.2, animations: {
                    // ベースカードを元の位置に戻す
                    self.baseCard.center = self.centerOfCard
                    // 該当のユーザーカードを画面外(プラス方向)へ飛ばす
                    self.people[self.selectedCardCount].center = CGPoint(x:self.people[self.selectedCardCount].center.x + 500,y: self.people[self.selectedCardCount].center.y)
                })
                return
            }
            
            // 元々の位置と移動先との差
            let xfromCenter = card.center.x - view.center.x
            
            card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
            
            // ベースカードを元の位置に戻す
            baseCard.center = centerOfCard
            // ユーザーカードを元の位置に戻す
            people[selectedCardCount].center = centerOfCard
            
        }
    }
    
}

