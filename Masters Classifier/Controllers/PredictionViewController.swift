//
//  PredictionViewController.swift
//  Masters Classifier
//
//  Created by Rithik Vardhan on 03/02/22.
//

import UIKit

class PredictionViewController: UIViewController {

    @IBOutlet weak var univView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    var nameField = ""
    var college = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameField
        univView.layer.cornerRadius = 25
        universityLabel.text = college
    }


    @IBAction func tryAgainPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
