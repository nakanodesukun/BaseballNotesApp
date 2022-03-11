//
//  Protocol.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/09.
//

import Foundation

protocol UserDataType: AnyObject {
    // ユーザーからの入力イベントを受け取る  // model側にViewがControllerが処理をdelegateを使って行いたいがやり方がわからない。
    func inputText(diaryText: String, diaryDate: Date)
}
