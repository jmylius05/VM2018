//
//  SignInViewController.swift
//  VisitMe
//
//  Created by Jessica Mylius on 11/6/18.
//  Copyright © 2018 Jess Mundo. All rights reserved.
//

import UIKit




class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        signInButton.isEnabled = false
        handleTextField()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Api.User.CURRENT_USER != nil {
            self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
        }
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signInButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            signInButton.isEnabled = false
            return
            
        }
        signInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signInButton.isEnabled = true
        
    }
    

   
    @IBAction func signInBtn_TouchUpInside(_ sender: Any) {
    view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
          ProgressHUD.showSuccess("Success!")
            self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
        }, onError: { error in
            ProgressHUD.showError(error!)
  
            
        
        })
        
        
    }
    
}
