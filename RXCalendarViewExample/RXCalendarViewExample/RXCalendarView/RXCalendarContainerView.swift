//
//  RXCalendarContainerView.swift
//  RXCalendarViewExample
//
//  Created by AlphaDog on 2018/3/16.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

@objc(RXCalendarDelegate)
public protocol RXCalendarDelegate: NSObjectProtocol {
    func calendarAction(_ dayInfo: RXDateObject)
}

@objc(RXCalendarDataSource)
public protocol RXCalendarDataSource: NSObjectProtocol {
    func signDateInMonth(view: RXCalendarView) -> [String]
}

open class RXCalendarContainerView: UIView {
    
    weak open var dataSource: RXCalendarDataSource? {
        didSet {
            guard let _ = calendarContainer.containerView else {
                return calendarContainer.containerView = self
            }
        }
    }
    weak open var delegate: RXCalendarDelegate? {
        didSet {
            guard let _ = calendarContainer.containerView else {
                return calendarContainer.containerView = self
            }
        }
    }
    
    lazy var weekView: RXCalendarWeekView = {
        let view = RXCalendarWeekView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var calendarContainer: RXCalendarScrollView = {
        let view = RXCalendarScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    ///MARK: - Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        addSubview(weekView)
        addSubview(calendarContainer)
        layout()
    }
    
    ///MARK: - Layout
    open func layout() {
        ///weekView
        addConstraint(NSLayoutConstraint(item: weekView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: weekView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: weekView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        weekView.addConstraint(NSLayoutConstraint(item: weekView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        
        ///calendarContainer
        addConstraint(NSLayoutConstraint(item: calendarContainer, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: calendarContainer, attribute: .top, relatedBy: .equal, toItem: weekView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: calendarContainer, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: calendarContainer, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    ///MARK: - Action
    
}

extension RXCalendarContainerView: RXCalendarCellDelegate, RXCalendarCellDataSource {
    
    func calendarCellAction(cellInfo: RXDateObject) {
        delegate?.calendarAction(cellInfo)
    }
    
    func signDateInCurrentMonth(view: RXCalendarView) -> [String] {
        if let arr = dataSource?.signDateInMonth(view: view) {
            return arr
        }
        return []
//        return ["2018-03-03", "2018-03-11", "2018-03-13", "2018-03-23"]
    }
    
}
