//
//  RealmUserData.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/09.
//

import RealmSwift
import Foundation
                            // 抽象化する。
final class RealmUserData: UserDataType {

    func inputData(inputText diaryText: String, inputDate selectedDate: Date) {
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
            print("保存に失敗しました\(error.localizedDescription)")
        }
    }

    func deleteData(removeDate selectedDate: Date) {
        do {
            let realm = try Realm()                                         // 日付が同じだったら削除
            let targetDeleate = realm.objects(RealmUser.self).filter("diaryDate == %@", selectedDate)
            try realm.write({
                realm.delete(targetDeleate)
            })
        } catch {
            print("削除に失敗しました\(error.localizedDescription)")
        }
    }
}
