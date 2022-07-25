//
//  CalendarView.swift
//  STS
//
//  Created by Анна Гранёва on 25.07.22.
//

import UIKit
import FSCalendar

protocol CalendarViewDelegate: AnyObject{
    func cancelAction()
    func okAction()
}

final class CalendarView: UIView{
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var currentYearLabel: UILabel!
    @IBOutlet private weak var currentDateLabel: UILabel!
    
    weak var delegate: CalendarViewDelegate?
    
    @IBOutlet weak var calendar: FSCalendar!
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            Bundle.main.loadNibNamed("\(type(of: self))", owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            calendar.delegate = self
            guard let todayDate = calendar.today else { return }
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "YYYY"
            let year = yearFormatter.string(from: todayDate)
            currentYearLabel.text = year
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "EE, dd MMM."
            let date = dateFormatter.string(from: todayDate)
            currentDateLabel.text = date
        }
    
    
    @IBAction private func cancelButtonAction(_ sender: Any) {
        delegate?.cancelAction()
    }
    
    @IBAction private func okButtonAction(_ sender: Any) {
        delegate?.okAction()
    }
}

//MARK: - FSCalendarDelegate
extension CalendarView: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd.MM.YYYY HH:mm"
        let string = formatter.string(from: date)
        print(string)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        guard let todayDate = calendar.today else { return true}
        if date > todayDate{
            return false
        }else {
            return true
        }
    }
}
