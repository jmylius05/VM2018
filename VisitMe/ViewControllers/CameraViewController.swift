//
//  CameraViewController.swift
//  VisitMe
//
//  Created by Jessica Mylius on 11/9/18.
//  Copyright © 2018 Jess Mundo. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var captionText: UITextView!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    var selectedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CameraViewController.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    func handlePost() {
        if selectedImage != nil {
         self.shareButton.isEnabled = true
            self.removeButton.isEnabled = true
            self.shareButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        } else  {
            self.shareButton.isEnabled = false
            self.removeButton.isEnabled = false
            self.shareButton.backgroundColor = .lightGray
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1) {
            HelperService.uploadDataToServer(data: imageData, caption: captionText.text!, onSuccess: {
            self.clean()
            self.tabBarController?.selectedIndex = 0
            })
//            } else {
//                ProgressHUD.showError("Profile image can't be empty")
//
            
        }
}
        
    @IBAction func remove_TouchUpInside(_ sender: Any) {
        clean()
        handlePost()
    }
    func clean() {
        self.captionText.text = ""
        self.photo.image = UIImage(named: "addPhoto")
        self.selectedImage = nil
}
    
}
        
        extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                print("did Finish Picking Media")
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                    selectedImage = image
                    photo.image = image
                }
                dismiss(animated: true, completion: nil)
            }
}


