//
//  SignUpViewController.swift
//  VisitMe
//
//  Created by Jessica Mylius on 11/7/18.
//  Copyright © 2018 Jess Mundo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var selectedImage: UIImage?
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        signUpButton.isEnabled = false
        
        handleTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func handleTextField() {
        usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            signUpButton.isEnabled = false
            return
            
        }
        signUpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signUpButton.isEnabled = true
        
    }
    
    @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
       dismiss(animated: true, completion: nil)

    }

  
    @IBAction func signUpBtn_TouchUpInside(_ sender: Any) {
    view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1) {
            AuthService.signUp(username: usernameTextField.text!, fullName: fullNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, imageData: imageData, onSuccess: {
                ProgressHUD.showSuccess("Success!")
                self.performSegue(withIdentifier: "signUpToTabbarVC", sender: nil) }, onError: { (errorString) in
                ProgressHUD.showError(errorString!)
            })
        } else {
            ProgressHUD.showError("Profile image can't be empty")
        }
    }
}


extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("did Finish Picking Media")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = image
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
        
        
    }
}
