//
//  ValuesViewController.swift
//  Masters Classifier
//
//  Created by Rithik Vardhan on 03/02/22.
//

import UIKit
import RSSelectionMenu

class ValuesViewController: UIViewController {
    
    @IBOutlet weak var toeflOrIelts: UISegmentedControl!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var greView: UIView!
    @IBOutlet weak var greField: UITextField!
    @IBOutlet weak var toeflOrIeltsView: UIView!
    @IBOutlet weak var toeflOrIeltsField: UITextField!
    @IBOutlet weak var toeflOrIeltsLabel: UILabel!
    @IBOutlet weak var sopView: UIView!
    @IBOutlet weak var sopField: UITextField!
    @IBOutlet weak var lorView: UIView!
    @IBOutlet weak var lorField: UITextField!
    @IBOutlet weak var percView: UIView!
    @IBOutlet weak var percField: UITextField!
    @IBOutlet weak var workExView: UIView!
    @IBOutlet weak var workExField: UITextField!
    @IBOutlet weak var predictButton: UIButton!
    @IBOutlet weak var greButton: UIButton!
    @IBOutlet weak var toeflOrIeltsButton: UIButton!
    @IBOutlet weak var sopButton: UIButton!
    @IBOutlet weak var lorButton: UIButton!
    @IBOutlet weak var percButton: UIButton!
    @IBOutlet weak var workExButton: UIButton!
    
    
    let ieltsModel = GreIeltsClassifier()
    let toeflModel = GreToeflClassifier()
    var values = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DETAILS"
        greView.layer.cornerRadius = 20
        toeflOrIeltsView.layer.cornerRadius = 20
        sopView.layer.cornerRadius = 20
        lorView.layer.cornerRadius = 20
        percView.layer.cornerRadius = 20
        workExView.layer.cornerRadius = 20
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        greField.text = ""
        toeflOrIeltsField.text = ""
        sopField.text = ""
        lorField.text = ""
        percField.text = ""
        workExField.text = ""
        nameField.text = ""
        nameField.becomeFirstResponder()
    }
    
    @IBAction func toeflOrIeltsControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            toeflOrIeltsLabel.text = "IELTS Score"
        } else {
            toeflOrIeltsLabel.text = "TOEFL Score"
        }
    }
    
    @IBAction func greFieldTapped(_ sender: UIButton) {
        values = []
        for i in 260...340 {
            values.append("\(i)")
        }
        selectionMenu(values: values, textField: greField)
    }
    
    @IBAction func toeflOrIeltsFieldTapped(_ sender: UIButton) {
        values = []
        if toeflOrIelts.selectedSegmentIndex == 0 {
            values = ["4","4.5","5","5.5","6","6.5","7","7.5","8","8.5","9"]
        } else {
            for i in 50...120 {
                values.append("\(i)")
            }
        }
        selectionMenu(values: values, textField: toeflOrIeltsField)
    }
    
    @IBAction func sopFieldTapped(_ sender: UIButton) {
        values = []
        for i in 1...5 {
            values.append("\(i)")
        }
        selectionMenu(values: values, textField: sopField)
    }
    
    @IBAction func lorFieldTapped(_ sender: UIButton) {
        values = []
        for i in 1...5 {
            values.append("\(i)")
        }
        selectionMenu(values: values, textField: lorField)
    }
    
    @IBAction func percFieldTapped(_ sender: UIButton) {
        values = []
        for i in 40...100 {
            values.append("\(i)")
        }
        selectionMenu(values: values, textField: percField)
    }
    
    @IBAction func workExFieldTapped(_ sender: UIButton) {
        values = []
        for i in 0...60 {
            values.append("\(i)")
        }
        selectionMenu(values: values, textField: workExField)
    }
    
    
    @IBAction func predictPressed(_ sender: UIButton) {
        var univ = ""
        if greField.text?.isEmpty == true {
            greFieldTapped(greButton)
            return
        } else if toeflOrIeltsField.text?.isEmpty == true {
            toeflOrIeltsFieldTapped(toeflOrIeltsButton)
            return
        } else if sopField.text?.isEmpty == true {
            sopFieldTapped(sopButton)
            return
        } else if lorField.text?.isEmpty == true {
            lorFieldTapped(lorButton)
            return
        } else if percField.text?.isEmpty == true {
            percFieldTapped(percButton)
            return
        } else if workExField.text?.isEmpty == true {
            workExFieldTapped(workExButton)
            return
        } else if nameField.text?.isEmpty == true {
            nameField.becomeFirstResponder()
            return
        }
        if toeflOrIelts.selectedSegmentIndex == 0 {
            univ = predictionForIelts(gre: NSString(string: greField.text!).doubleValue, workEx: NSString(string: workExField.text!).doubleValue, ielts: NSString(string: toeflOrIeltsField.text!).doubleValue, sop: NSString(string: sopField.text!).doubleValue, lor: NSString(string: lorField.text!).doubleValue, perc: NSString(string: percField.text!).doubleValue)
        } else {
            univ = predictionForToefl(gre: NSString(string: greField.text!).doubleValue, workEx: NSString(string: workExField.text!).doubleValue, toefl: NSString(string: toeflOrIeltsField.text!).doubleValue, sop: NSString(string: sopField.text!).doubleValue, lor: NSString(string: lorField.text!).doubleValue, perc: NSString(string: percField.text!).doubleValue)
        }
        
        let vc = PredictionViewController()
        vc.nameField = nameField.text ?? ""
        vc.college = univ
        present(vc, animated: true, completion: nil)
        
        
    }
    
    func predictionForIelts(gre: Double, workEx: Double, ielts: Double, sop: Double, lor: Double, perc: Double) -> String {
        var univ = ""
        let ieltsClassification = GreIeltsClassifierInput(GRE: gre, WORK_EX: workEx, IELTS: ielts, SOP: sop, LOR: lor, PERCENTAGE: perc)
        do {
            let collegesObtained = try ieltsModel.prediction(input: ieltsClassification)
            univ = collegesObtained.University
        } catch {
            print(error)
        }
        return univ
    }
    
    func predictionForToefl(gre: Double, workEx: Double, toefl: Double, sop: Double, lor: Double, perc: Double) -> String {
        var univ = ""
        let toeflClassification = GreToeflClassifierInput(GRE: gre, TOEFL: toefl, WORK_EX: workEx, SOP: sop, LOR: lor, PERCENTAGE: perc)
        
        do {
            let collegesObtained = try toeflModel.prediction(input: toeflClassification)
            univ = collegesObtained.University
        } catch {
            print(error)
        }
        return univ
    }
    
    func selectionMenu(values: [String], textField: UITextField) {
        let selectionMenu = RSSelectionMenu(dataSource: values) { (cell, item, indexPath) in
            cell.textLabel?.text = item
        }
        selectionMenu.setSelectedItems(items: []) { (item, index, isSelected, selectedItems) in
            textField.text = selectedItems[0]
        }
        selectionMenu.maxSelectionLimit = 1
        selectionMenu.show(style: .actionSheet(title: nil, action: "Done", height: nil), from: self)
    }
}
