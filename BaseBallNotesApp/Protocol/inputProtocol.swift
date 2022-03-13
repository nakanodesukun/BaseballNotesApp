//
//  Protocol.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/09.
//

import Foundation

protocol UserDataType: AnyObject {
    // ユーザーからの入力イベントを受け取る  
    func inputData(inputText: String, inputDate: Date)
    // ユーザから削除イベントを受け取る
    func deleteData(removeDate: Date)
}
protocol UserDateType: AnyObject {

    func scoreDate(decisionDate: Date) -> Int

}
