//
//  RealmDiary.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/08.
//

import RealmSwift

class RealmDaiary: Object {
 @objc dynamic var diaryText = ""
 @objc dynamic var dateText = ""
}
