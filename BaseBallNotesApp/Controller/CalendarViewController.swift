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
    private (set) var selectDate = Date()
    // タイプミス防止
    private let toDetaileViewController = "DetaileViewController"

    @IBOutlet private weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
        changeOfDay()
    }

    // 画面が表示された直後に再描画する
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendar.reloadData()
    }

    // 曜日の表示を変換するメソッド
    private func changeOfDay() {
        let japaneseWeek = ["日", "月", "火", "水", "木", "金", "土"]
        for countNumber in 0..<japaneseWeek.count {
            calendar.calendarWeekdayView.weekdayLabels[countNumber].text = japaneseWeek[countNumber]
        }
    }

    @IBAction private func edit(segue: UIStoryboardSegue) {
    }
}

extension CalendarViewController: FSCalendarDataSource {
                        // マルポチを表示する
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        dateaa(date: date)
}
    func dateaa(date: Date) -> Int {
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(RealmUser.self)
                                // fscalendarと保存したデータの日付が同じか判定
            let date = realmObjects.filter("diaryDate == %@", date).count
            return date
        } catch {
            return 0
        }
    }
}
extension CalendarViewController: FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDate = date
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
