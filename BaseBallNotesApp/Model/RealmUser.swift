//
//  RealmDiary.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/08.
//

import RealmSwift

 final class RealmUser: Object {
 @objc dynamic var diaryText = ""
 @objc dynamic var diaryDate = ""
}
