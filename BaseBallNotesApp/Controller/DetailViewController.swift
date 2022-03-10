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
    var selectedDate = ""

    @IBOutlet private weak var diaryTextView: UITextView!

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationItem.title = selectedDate
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        do {
            let realm = try Realm() // RealmDairyクラスをインスタンス化せずにクラス名を指定*注意             // 最後に保存したデータを取得する
            let userDataObjects = realm.objects(RealmUser.self).filter("diaryDate == %@", selectedDate).last?.value(forKey: "diaryText")
            diaryTextView.text = userDataObjects as? String

        } catch {
            print("エラー\(error.localizedDescription)")
        }
    }

    @IBAction private func didTapSaveButton(_ sender: Any) {

        guard let diaryText = diaryTextView.text else {
            return
        }
                        // Protocolに準拠した構造体に対応することで差し替え可能にする
        let realmUser: UserDataType = RealmUserData()
        realmUser.inputText(diaryText: diaryText, diaryDate: selectedDate)
                  // キーボードの非表示
        diaryTextView.resignFirstResponder()
    }
    private func showAlert() {
        let title = "エラー"
        let message = "保存に失敗しました"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }



}
