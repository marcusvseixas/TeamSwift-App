//  SecondViewController.swift
//  TeamSwift-App
//  This program will handle the scanning of barcodes and detecting cameras on devices
//  The code here was adapted from a tutorial found at http://www.appcoda.com/qr-code-reader-swift/

import UIKit
import AVFoundation

var meals = [Meal]()
var isPressed = false
class SecondViewController: UIViewController,UIImagePickerControllerDelegate, AVCaptureMetadataOutputObjectsDelegate, UITextFieldDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var foodName: UITextField!
    @IBOutlet weak var foodDesc: UITextField!
    @IBOutlet weak var foodPic: UIImageView!

    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        isPressed = true
        viewDidLoad()
    }
    
    @IBOutlet var addFoodView: UIView!
    
    @IBAction func selectPhoto(sender: AnyObject) {
        foodName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    let defaultImage = UIImage(named: "defaultPhoto")

    @IBAction func addFood(sender: AnyObject) {
        if foodName.text?.characters.count > 0 && foodDesc.text?.characters.count > 0{
            let meal = Meal(name: foodName.text!,photo: (foodPic?.image)! ,desc: foodDesc.text!)!
            meals.append(meal)
            foodName.text = ""
            foodDesc.text = ""
            foodPic.image = defaultImage
            MealTableViewController().saveMeals()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // Set photoImageView to display the selected image.
        foodPic.image = selectedImage
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //UITableDelete
    
    override func viewDidAppear(animated: Bool) {
        self.reloadInputViews()
        isPressed = false
        //view.removeFromSuperview()
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isPressed == true{
            let vc = storyboard!.instantiateViewControllerWithIdentifier("Scanner") as! ThirdViewController
        
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

