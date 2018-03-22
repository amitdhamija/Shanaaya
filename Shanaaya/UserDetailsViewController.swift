//
//  UserDetailsViewController.swift
//  Shanaaya
//
//  Created by Amit Dhamija on 3/19/18.
//  Copyright © 2018 Amit Dhamija. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UITextFieldDelegate {

    private var name: String?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var startButton: PinkButton!
    
    //MARK: Actions
    @IBAction func startButtonTapped(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        passwordTextField.delegate = self
        
        startButton.isEnabled = false
        incorrectPasswordLabel.isHidden = true
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        name = textField.text
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
