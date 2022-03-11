//
//  DetailViewController.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/07.
//
import UIKit
import RealmSwift

final class DetailViewController: UIViewController {

    // CalandarViewControllerから選択された日付を取得する
    var selectedDate = Date()

    @IBOutlet private weak var diaryTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
            // 日付を変換したものを表示する
        navigationItem.title = changeDate(date: selectedDate)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        do {
            let realm = try Realm() // RealmDairyクラスをインスタンス化せずにクラス名を指定*注意             // 最後に保存したデータを取得する
            let userDataObjects = realm.objects(RealmUser.self).filter("diaryDate == %@", selectedDate).last?.value(forKey: "diaryText")
            diaryTextView.text = userDataObjects as? String ?? ""
        } catch {
            print("書き込まれたデータが存在していません\(error.localizedDescription)")
        }

    }

    @IBAction private func didTapSaveButton(_ sender: Any) {

        let diaryText = diaryTextView.text ?? ""
                        // Protocolに準拠した構造体に対応することで差し替え可能にする
        let realmUser: UserDataType = RealmUserData()
        realmUser.inputText(diaryText: diaryText, diaryDate: selectedDate)
    }

    // Date型をString型に変換
    private func changeDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日EEEE"
        let japaneseWeek = formatter.string(from: date)
        print(japaneseWeek)
        return japaneseWeek
    }

}
