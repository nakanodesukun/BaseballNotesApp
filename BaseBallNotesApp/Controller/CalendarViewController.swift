//
//  ViewController.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/07.
//
import UIKit
import FSCalendar
import RealmSwift

final class CalendarViewController: UIViewController {
        // 値渡しで保持する
    var selectDate = ""
    // タイプミス防止
    private let toDetaileViewController = "DetaileViewController"
    private let realmUserData = RealmUserData()

    @IBOutlet private weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        changeOfDay()

    }
    // 曜日の表示を変換するメソッド
    private func changeOfDay() {
        let japaneseWeek = ["日", "月", "火", "水", "木", "金", "土"]
        // forEachに変更してもいいかも
        for countNumber in 0..<japaneseWeek.count {
            calendar.calendarWeekdayView.weekdayLabels[countNumber].text = japaneseWeek[countNumber]
        }
    }

    @IBAction private func edit(segue: UIStoryboardSegue) {
    }
    
}
extension CalendarViewController: FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日EEEE"
        let japaneseWeek = formatter.string(from: date)
        selectDate = japaneseWeek
        do {
            let realm = try Realm() // RealmDairyクラスをインスタンス化せずにクラス名を指定*注意
            let diaryDate = selectDate
                                                                                //
            let userDataObjects = realm.objects(RealmUser.self).filter("diaryDate == %@", selectDate)
            print(userDataObjects)
        } catch {
            print("エラー\(error.localizedDescription)")
        }

        performSegue(withIdentifier: toDetaileViewController, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case toDetaileViewController:
            guard let navigationController = segue.destination as? UINavigationController,
                  let deatileViewController = navigationController.topViewController as? DetailViewController else {
                      return
                  }
            // DetaileViewControllerへ値渡し
            deatileViewController.selectedDate = selectDate
        default:
            break
        }
    }
}
