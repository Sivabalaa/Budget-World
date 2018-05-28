//
//  AddTransactionController.swift
//  Budget World
//
//  Created by Eugene Lu on 2018-05-26.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class AddTransactionController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGradientWithColor(primary: UIColor.rgb(red: 52, green: 232, blue: 158), secondary: UIColor.rgb(red: 15, green: 52, blue: 67))
        setupBarItems()
        setupViews()
        transactionView.delegate = self
        recurringPicker.delegate = self
        recurringPicker.dataSource = self
    }
    var transaction: TransactionType? = nil
    let recurringPeriods = ["Never", "Weekly", "Bi-Weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-Annually", "Annually"]
    
    let recurringPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        return picker
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = .clear
        picker.datePickerMode = .date
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        picker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        return picker
    }()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy"
        return df
    }()
    
    let transactionView: AddTransactionView = {
        let view = AddTransactionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

//MARK: Setup
extension AddTransactionController {
    fileprivate func setupViews() {
        navigationItem.title = transaction == .income ? "Income" : "Expense"
        view.addSubview(transactionView)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        transactionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        transactionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        transactionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        transactionView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
    }
    
    fileprivate func setupBarItems() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        cancelItem.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = cancelItem
        
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        doneItem.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = doneItem
    }
}

//MARK: Events
extension AddTransactionController {
    @objc func cancelButtonPressed() {
        let mainController = SlideMenuController(mainViewController: MainController(), leftMenuViewController: SlideOptionsController())
        mainController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(mainController, animated: true, completion: nil)
    }
    
    @objc func doneButtonPressed() {
        let mainController = SlideMenuController(mainViewController: MainController(), leftMenuViewController: SlideOptionsController())
        mainController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(mainController, animated: true, completion: nil)
    }
    
    @objc func dateValueChanged() {
        transactionView.dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
}

//MARK: Transaction view delegate
extension AddTransactionController: AddTransactionViewDelegate {
    
    func categoryFieldPressed() {
        guard let transactionType = transaction else {return}
        let categoryController = CategoryController()
        categoryController.transactionType = transactionType
        categoryController.delegate = self
        self.navigationController?.pushViewController(categoryController, animated: true)
    }
    
    func dateFieldPressed() {
        transactionView.dateTextField.inputView = UIView()
        transactionView.dateTextField.inputAccessoryView = datePicker
        transactionView.dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func repeatingFieldPressed() {
        transactionView.recurringTextField.inputView = UIView()
        transactionView.recurringTextField.inputAccessoryView = recurringPicker
    }
}

//MARK: Category controller delegate
extension AddTransactionController: CategoryDelegate {
    func categorySelected(category: String) {
        self.navigationController?.popViewController(animated: true)
        transactionView.categoryTextField.text = category
    }
}

//MARK: Recurring picker delegate and data source
extension AddTransactionController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = recurringPeriods[row]
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        transactionView.recurringTextField.text = recurringPeriods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recurringPeriods.count
    }
}
