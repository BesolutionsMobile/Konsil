//
//  ProfileInfoViewController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/19/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import Photos

class ProfileInfoViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var name: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.name, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.name.frame.height/2)
        }
    }
    @IBOutlet weak var email: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.email, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.email.frame.height/2)
        }
    }
    @IBOutlet weak var password: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.password, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.password.frame.height/2)
        }
    }
    @IBOutlet weak var phone: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.phone, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.phone.frame.height/2)
        }
    }
    @IBOutlet weak var photo: DesignableUITextField!{
        didSet{
            Rounded.roundedCornerTextField(textField: self.photo, borderColor: #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1), radius: self.photo.frame.height/2)
        }
    }
    @IBOutlet weak var patientHistoryTV: UITextView!{
        didSet{
            patientHistoryTV.layer.cornerRadius = 10
            patientHistoryTV.layer.borderColor = #colorLiteral(red: 0.01960784314, green: 0.4549019608, blue: 0.5764705882, alpha: 1)
            patientHistoryTV.layer.borderWidth = 1.5
            patientHistoryTV.delegate = self
            patientHistoryTV.text = "Enter Patient History Here".localized
        }
    }
    @IBOutlet weak var patientHistoryLabel: UILabel!{
        didSet{
            patientHistoryLabel.text = "Patient History".localized
        }
    }
    @IBOutlet weak var submit: UIButton!{
        didSet{
            self.submit.layer.cornerRadius = self.submit.frame.height/2
        }
    }
    @IBOutlet weak var redView: UIView!{
        didSet{
            self.redView.layer.cornerRadius = 60
        }
    }
    @IBOutlet weak var blueView: UIView!{
        didSet{
            self.blueView.layer.cornerRadius = 58
            self.blueView.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMinXMaxYCorner]
        }
    }
    
    //MARK:- Variables
    
    let imagePicker = UIImagePickerController()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBackBut()
    }
    
    @IBAction func uploadProfileImage(_ sender: UIButton) {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    //MARK:- Methodes
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.patientHistoryTV.text = ""
    }
    
    
}

//MARK:- Image Picker Delegates
extension ProfileInfoViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITextViewDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: imagePicker, didFinishPickingMediaWithInfo: info) { (uploaded) in
            if uploaded {
                if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset{
                    if let fileName = asset.value(forKey: "filename") as? String{
                        self.photo.text = fileName
                    }
                }
            }
        }
    }
    
}
