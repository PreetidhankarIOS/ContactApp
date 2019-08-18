//
//  UIViewControllerExtension.swift
//  ContactApp
//
//  Created by Pawan Kumar on 18/08/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit
import AssetsLibrary
import AVFoundation
import Photos
import PhotosUI

extension UIViewController{
    
    ///Adds Child View Controller to Parent View Controller
    func add(childViewController:UIViewController){
        
        self.addChild(childViewController)
        let frame = self.view.bounds
        
        childViewController.view.frame = frame
        self.view.addSubview(childViewController.view)
        
        childViewController.didMove(toParent: self)
    }
    
    ///Removes Child View Controller From Parent View Controller
    var removeFromParentVC:Void{
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
        
    }
    
    ///Updates navigation bar according to given values
    func updateNavigationBar(withTitle title:String? = nil, leftButton:UIBarButtonItem? = nil, rightButton:UIBarButtonItem? = nil, tintColor:UIColor? = nil, barTintColor:UIColor? = nil, titleTextAttributes: [NSAttributedString.Key : Any]? = nil){
        
        self.navigationController?.isNavigationBarHidden = false
        if let tColor = barTintColor{
            self.navigationController?.navigationBar.barTintColor = tColor
        }
        if let tColor = tintColor{
            self.navigationController?.navigationBar.tintColor = tColor
        }
        if let button = leftButton{
            self.navigationItem.leftBarButtonItem = button;
        }
        if let button = rightButton{
            self.navigationItem.rightBarButtonItem = button;
        }
        if let ttle = title{
            self.title = ttle
        }
        if let ttleTextAttributes = titleTextAttributes{
            self.navigationController?.navigationBar.titleTextAttributes =   ttleTextAttributes
        }
    }
    
    ///function to pop the target from navigation Stack
    
    func popToController(_ viewController:UIViewController? = nil, animated:Bool = true) {
        
        var navigationVC:UINavigationController?
        if let navVC = self as? UINavigationController{
            navigationVC = navVC
        }
        else{
            navigationVC = self.navigationController
        }
        
        if let vc = viewController{
            _ = navigationVC?.popToViewController(vc, animated: animated)
        }
        else{
            _ = navigationVC?.popViewController(animated: animated)
        }
    }
    
    func popToController(atIndex index:Int, animated:Bool = true) {
        
        var navigationVC:UINavigationController?
        if let navVC = self as? UINavigationController{
            navigationVC = navVC
        }
        else{
            navigationVC = self.navigationController
        }
        
        if let navVc = navigationVC, navVc.viewControllers.count > index{
            
            _ = navVc.popToViewController(navVc.viewControllers[index], animated: animated)
        }
    }
    
    func popToRootController(animated:Bool = true) {
        
        var navigationVC:UINavigationController?
        if let navVC = self as? UINavigationController{
            navigationVC = navVC
        }
        else{
            navigationVC = self.navigationController
        }
        _ = navigationVC?.popToRootViewController(animated: animated)
    }
    
    // Take image from gallery or Camera
    func captureImage(delegate:(UIImagePickerControllerDelegate & UINavigationControllerDelegate)?,
                      photoGallary:Bool = true,
                      camera:Bool = true,
                      optionsColor:UIColor = AppColors.themeGreen,
                      cameraDevice: UIImagePickerController.CameraDevice = .rear) {
        
        let alertController = UIAlertController(title: "Choose from options", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        if photoGallary {
            
            let alertActionGallery = UIAlertAction(title: "Photo Library", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                self.checkAndOpenLibrary(delegate: delegate)
            }
            
            alertActionGallery.setValue(optionsColor, forKey: "titleTextColor")
            alertController.addAction(alertActionGallery)
        }
        
        if camera{
            let alertActionCamera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                
                !UIDevice.isSimulator ? self.checkAndOpenCamera(delegate: delegate, cameraDevice: cameraDevice):self.checkAndOpenLibrary(delegate: delegate)
            }
            
            alertActionCamera.setValue(optionsColor, forKey: "titleTextColor")
            alertController.addAction(alertActionCamera)
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (action:UIAlertAction) in
            
        }
        
        alertActionCancel.setValue(optionsColor, forKey: "titleTextColor")
        alertController.addAction(alertActionCancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkAndOpenCamera(delegate:(UIImagePickerControllerDelegate & UINavigationControllerDelegate)?, cameraDevice: UIImagePickerController.CameraDevice = .rear) {
        
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == AVAuthorizationStatus.authorized {
            let image_picker = UIImagePickerController()
            image_picker.delegate = delegate
            let sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
            
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                image_picker.sourceType = sourceType
                if image_picker.sourceType == UIImagePickerController.SourceType.camera {
                    image_picker.allowsEditing = true
                    image_picker.showsCameraControls = true
                }
                
                if UIImagePickerController.isCameraDeviceAvailable(cameraDevice) {
                    image_picker.cameraDevice = cameraDevice
                }
                else {
                    image_picker.cameraDevice = .rear
                }
                self.present(image_picker, animated: true, completion: nil)
            }
            else if !UIDevice.isSimulator{
                
                self.showAlert(title: "", message: "Camera not available", buttonTitle: "OK", onCompletion: nil)
            }
        }
        else {
            if authStatus == AVAuthorizationStatus.notDetermined {
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {(granted: Bool) in                DispatchQueue.main.async(execute: {                    if granted {
                    let image_picker = UIImagePickerController()
                    image_picker.delegate = delegate
                    let sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
                    if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                        image_picker.sourceType = sourceType
                        if image_picker.sourceType == UIImagePickerController.SourceType.camera {
                            image_picker.allowsEditing = true
                            image_picker.showsCameraControls = true
                        }
                        self.present(image_picker, animated: true, completion: nil)
                    }
                    else if !UIDevice.isSimulator{
                        self.showAlert(title: "", message: "Camera not available", buttonTitle: "OK", onCompletion: nil)
                    }
                    }
                    
                })
                    
                })
            }
            else {
                if authStatus == AVAuthorizationStatus.restricted {
                    
                    let alertController = UIAlertController(title: "", message: "You have been restricted from using the camera on this device Without camera access this feature wont work", preferredStyle: UIAlertController.Style.alert)
                    
                    let alertActionSettings = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                        UIApplication.openSettingsApp
                    }
                    let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(alertActionSettings)
                    alertController.addAction(alertActionCancel)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    
                    let alertController = UIAlertController(title: "", message: "Please change your privacy setting from the Settings app and allow access to camera", preferredStyle: UIAlertController.Style.alert)
                    
                    let alertActionSettings = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                        UIApplication.openSettingsApp
                    }
                    let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                    }
                    alertController.addAction(alertActionSettings)
                    alertController.addAction(alertActionCancel)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func checkAndOpenLibrary(delegate:(UIImagePickerControllerDelegate & UINavigationControllerDelegate)?) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            
            let image_picker = UIImagePickerController()
            image_picker.delegate = delegate
            let sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
            image_picker.sourceType = sourceType
            image_picker.allowsEditing=true
            self.present(image_picker, animated: true, completion: nil)
            
        //handle authorized status
        case .denied:
            
            let alertController = UIAlertController(title: "", message: "Please change your privacy setting from the Settings app and allow access to library", preferredStyle: UIAlertController.Style.alert)
            
            let alertActionSettings = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                UIApplication.openSettingsApp
            }
            let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
            }
            alertController.addAction(alertActionSettings)
            alertController.addAction(alertActionCancel)
            self.present(alertController, animated: true, completion: nil)
            
        case .restricted :
            
            let alertController = UIAlertController(title: "", message: "You have been restricted from using the library on this device Without camera access this feature wont work", preferredStyle: UIAlertController.Style.alert)
            
            let alertActionSettings = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
                UIApplication.openSettingsApp
            }
            let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
            }
            alertController.addAction(alertActionSettings)
            alertController.addAction(alertActionCancel)
            self.present(alertController, animated: true, completion: nil)
            
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { status in
                self.checkAndOpenLibrary(delegate: delegate)
            }
        @unknown default:
            printDebug("permission not defined")
        }
    }
    
    func showAlert(title:String, message: String , successButtonTitle:String, cancelButtonTitle:String , onCompletion completion: @escaping (Bool)->Void){
        
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title:successButtonTitle, style: .default) { (_) -> Void in
            completion(true)
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .destructive) { (_) in
            completion(false)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil);
    }
    
    func showAlert(title:String, message: String , buttonTitle:String, onCompletion completion: (()->Void)?){
        
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title:buttonTitle, style: .cancel) { (_) -> Void in
            completion?()
        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil);
    }
    
    func showActionSheet(title: String, btnTitleArray: [String], completion: @escaping (_ btnTag: Int) -> ()) {
        let alert = UIAlertController.init(title: title, message: nil, preferredStyle: .actionSheet)
        
        for titleString in btnTitleArray {
            
            let alertAction = UIAlertAction.init(title: titleString, style: .default, handler: { (action) in
                
                for i in 0..<btnTitleArray.count {
                    
                    if titleString == btnTitleArray[i] {
                        completion(i)
                    }
                }
            })
            
            alert.addAction(alertAction)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

