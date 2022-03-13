//
//  DetailViewController.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/07.
//
import UIKit
import RealmSwift

final class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    // CalandarViewControllerから選択された日付を取得する(値渡し時)
    var selectedDate = Date()
    // Protocolに準拠した構造体に対応することで差し替え可能にする(Modelか呼び出し)
    private let realmUser: UserDataType = RealmUserData()

    @IBOutlet private weak var diaryTextView: UITextView!
    @IBOutlet private weak var cookingImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
            // 日付を変換したものを表示する
        navigationItem.title = changeDate(date: selectedDate)
        updateData()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    @IBAction private func didTapSaveButton(_ sender: Any) {
          // 入力された文字が空だったら早期リターン
        guard  diaryTextView.text.isEmpty == false else {
            showAlert()
            return
        }
        realmUser.inputData(inputText: diaryTextView.text, inputDate: selectedDate)
    }

    @IBAction private  func didTapPhotoLibraryButton(_ sender: Any) {
        guard  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        // 
        let imagePickerController = UIImagePickerController()

    }

    @IBAction private func didTapDeleteButton(_ sender: Any) {
        realmUser.deleteData(removeDate: selectedDate)
        // 削除されたタイミングでtextViewの中身を空にする
        diaryTextView.text = ""
    }

   private func updateData() {
        do {
            let realm = try Realm() // *注意RealmDairyクラスをインスタンス化せずにクラス名を指定             // 最後に保存したデータを取得する
            let userDataObjects = realm.objects(RealmUser.self).filter("diaryDate == %@", selectedDate).last?.value(forKey: "diaryText")
            diaryTextView.text = userDataObjects as? String ?? ""
        } catch {
            print("書き込まれたデータが存在していません\(error.localizedDescription)")
        }
    }

    // Date型をString型に変換
    private func changeDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日EEEE"
        let japaneseWeek = formatter.string(from: date)
        return japaneseWeek
    }

    private func showAlert() {
        let title = "保存に失敗しました"
        let message = "文字を入力してください"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}
