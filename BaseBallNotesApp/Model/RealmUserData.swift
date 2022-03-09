//
//  RealmUserData.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/09.
//

import RealmSwift
import Foundation
// 抽象化する。 ViewControllerからModelへdelegateを使って処理を委譲する方法がわからない。
class RealmUserData: inputDelegate {
    
    detailViewController.delegate = self

    func inputText(diaryText: String, selectedDate: String) {

        //  try!を使わないようにdo-catch文を使う
        do {
            let realmUser = RealmUser()
            let realm = try Realm()
            realmUser.diaryText = diaryText
            realmUser.diaryDate = selectedDate
            try realm.write({
                realm.add(realmUser)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
