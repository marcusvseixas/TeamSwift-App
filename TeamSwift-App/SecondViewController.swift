//  SecondViewController.swift
//  TeamSwift-App
//  This program will handle the scanning of barcodes and detecting cameras on devices
//  The code here was adapted from a tutorial found at http://www.appcoda.com/qr-code-reader-swift/

import UIKit
import AVFoundation

var meals = [Meal]()

class SecondViewController: UIViewController,UIImagePickerControllerDelegate, AVCaptureMetadataOutputObjectsDelegate, UITextFieldDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var foodName: UITextField!
    @IBOutlet weak var foodDesc: UITextField!
    @IBOutlet weak var foodPic: UIImageView!

    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var isPressed = false
    
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
    
    override func viewDidAppear(animated: Bool) {
        self.reloadInputViews()
        isPressed = false
        //view.removeFromSuperview()
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        if(isPressed ==  true){
            //performSegueWithIdentifier("oc", sender: but)
            do {
                // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
                // as the media type parameter.
                let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
                let input = try AVCaptureDeviceInput(device: captureDevice) // Get an instance of the AVCaptureDeviceInput class using the previous device object.
                captureSession = AVCaptureSession()                         // Initialize the captureSession object.
                captureSession?.addInput(input as AVCaptureInput)           // Add and input to it
           
            } catch let error as NSError {                                  // Catch any errors that arise from this like no camera detected
                print(error)
            }
        
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
        
            // Tests to see if the device has a camera or not
            if ((captureSession?.canAddOutput(captureMetadataOutput)) != nil) {
                captureSession?.addOutput(captureMetadataOutput)
                // Set delegate and use the default dispatch queue to execute the call back
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
                // These are all of the types of codes that the device can scan
                captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode128Code]
  
                // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                
                // Start video capture.
                captureSession?.startRunning()
        
                // Move the message label to the top view
                view.bringSubviewToFront(messageLabel)
        
                // Initialize QR Code Frame to highlight the QR code
                qrCodeFrameView = UIView()
                qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
                qrCodeFrameView?.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView!)
                view.bringSubviewToFront(qrCodeFrameView!)
            }
            else{ // If device has no camera or camera cannot be detected, then display a message
                messageLabel.text = "No Camera Detected, Cannot Scan"
                return
            }
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count  == 0{
            
            qrCodeFrameView?.frame = CGRectZero
            messageLabel.text = "No QR code Detected"
        }
        
        // Run once to test for each type of metadata object, not just a QR
        for i in 0 ..< metadataObjects.count{
            // Get the metadata object
            let metadataObj  = metadataObjects[i] as! AVMetadataMachineReadableCodeObject
        
            if metadataObj.type == AVMetadataObjectTypeQRCode || metadataObj.type == AVMetadataObjectTypeEAN8Code || metadataObj.type == AVMetadataObjectTypeEAN13Code || metadataObj.type == AVMetadataObjectTypePDF417Code || metadataObj.type == AVMetadataObjectTypeUPCECode || metadataObj.type == AVMetadataObjectTypeCode128Code {
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            
                let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as!   AVMetadataMachineReadableCodeObject
            
                qrCodeFrameView?.frame = barCodeObject.bounds;
            
                if metadataObj.stringValue != nil {
                    messageLabel.text = getJSON("https://api.outpan.com/v2/products/",upc: metadataObj.stringValue,apikey:"?apikey=c6c2561760980843c06d4f5a2b435202")
                    
                    let alertController = UIAlertController(title: "Test", message:
                        getJSON("https://api.outpan.com/v2/products/",upc: metadataObj.stringValue,apikey:"?apikey=c6c2561760980843c06d4f5a2b435202"), preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    print(messageLabel.text!)
                    
                    
                }
            }
        }
    }
    
    func getJSON(outpan: String, upc: String , apikey: String) -> String{
        
        var json = NSDictionary()
        let urlToRequest: String = outpan + upc + apikey

        if let nsdata: NSData! = NSData(contentsOfURL: NSURL(string: urlToRequest)!)! {
        do {
            json = try NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions()) as! NSDictionary
            if let _ = json["error"] {
                print("deu ruim")
            }else {
                print(json["name"])
            }
        } catch {
            print(error)
        }
        } else {
            return "hueheueeh"
        }
        return json["name"] as! String
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var boardsDictionary: NSDictionary!
        do {
            boardsDictionary =  try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        } catch {
            
        }
        
        
        return boardsDictionary
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

