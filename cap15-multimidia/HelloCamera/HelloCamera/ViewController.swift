//
//  ViewController.swift
//  HelloCamera
//
//  Created by Ricardo Lecheta on 7/5/14.
//  Copyright (c) 2014 Ricardo Lecheta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,
UIImagePickerControllerDelegate {
    
    @IBOutlet var btnCamera : UIButton!
    @IBOutlet var imageView : UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override init() {
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.delegate = self
        
        let isCameraDisponivel = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if(!isCameraDisponivel) {
            // Esconde o botão da câmera
            self.btnCamera.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func escolherFoto () {
        println("escolherFoto")
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated:true, completion: nil)
    }
    
    @IBAction func tirarFoto () {
        println("tirarFoto")
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated:true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        println("didFinishPickingMediaWithInfo")
        var image = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        self.imageView.image = image
        self.imagePicker.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        println("imagePickerControllerDidCancel")
        self.imagePicker.dismissViewControllerAnimated(true, completion:nil)
    }
}

