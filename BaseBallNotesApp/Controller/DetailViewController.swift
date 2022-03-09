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

    }

    @IBAction private func didTapSaveButton(_ sender: Any) {
                            // Protocolの型にして適合させる
        let realmUserData: inputDelegate = RealmUserData()
        guard let diaryText = diaryTextView.text else {
            return
        }

        realmUserData.inputText(diaryText: diaryText, selectedDate: selectedDate)
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
