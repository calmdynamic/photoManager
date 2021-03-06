//
//  EmailCheckingViewController.swift
//  PhotoManager
//
//  Created by Jason Chih-Yuan on 2018-08-22.
//  Copyright © 2018 Jason Lai. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmailCheckingViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    var authController: AuthenticationViewController = AuthenticationViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorMessage.textColor = UIColor.magenta

        // Do any additional setup after loading the view.
    }

    @IBAction func tapBackBtn(_ sender: Any) {
        
       
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func checkEmail(_ sender: Any) {
        
        Auth.auth().fetchProviders(forEmail: self.emailTextField.text!) { (stringArray, error) in
            if error != nil{
                self.errorMessage.text = FirebaseService.authErrorMessage(error: error!, email: self.emailTextField.text!, pass: " ")
            }else{
                
                Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!, completion: { (error) in
                    if error != nil{
                        self.errorMessage.text = FirebaseService.authErrorMessage(error: error!, email: self.emailTextField.text!, pass: " ")
                    }else{
                        self.errorMessage.text = ""
                        self.performSegue(withIdentifier: "emailUnwindSegue", sender: self)
                    }
                })
                
                
            }
        }

        
    }
}
