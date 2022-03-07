//
//  ViewController.swift
//  BaseBallNotesApp
//
//  Created by 中野翔太 on 2022/03/07.
//
import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate {
    @IBOutlet private weak var calendar: FSCalendar!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日EEEE"
        let string = formatter.string(from: date)
        print(string)
    }
}
