//
//  DetailViewController.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/07.
//

import UIKit
import RealmSwift

final class DetailViewController: UIViewController {

    @IBOutlet private weak var diaryTextView: UITextView!
    // CalandarViewControllerから選択された日付を取得する
    var selectedDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = selectedDate
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    @IBAction private func didTapSaveButton(_ sender: Any) {
        // try!を使わないようにdo-catch文を使う
        do {
            let realmDaiary = RealmDaiary()
            let realm = try Realm()
            try realm.write({
                realmDaiary.diaryText = diaryTextView.text
                realm.add(realmDaiary)
            })
        } catch {
            showAlert()
        }               // キーボードの非表示
        diaryTextView.resignFirstResponder()
    }

    private  func showAlert() {
        let title = "エラー"
        let message = "保存に失敗しました"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
