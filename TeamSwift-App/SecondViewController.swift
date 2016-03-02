//
//  SecondViewController.swift
//  TeamSwift-App
//
//  Created by Marcus Vinicius Seixas on 11/02/16.
//
// The code here was adapted from a tutorial found at http://www.appcoda.com/qr-code-reader-swift/
import UIKit
import AVFoundation

class SecondViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var messageLabel: UILabel!
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.

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
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code]
  
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
            messageLabel.text = "No Camera Detected, Please Use A Device With A Camera"
            return
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count  == 0{
            
            qrCodeFrameView?.frame = CGRectZero
            messageLabel.text = "No Code Detected"
            return
        }
        
        // Run once to test for each type of metadata object, not just a QR
        for i in 1 ..< metadataObjects.count{
            // Get the metadata object
            let metadataObj  = metadataObjects[i] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeEAN13Code{
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            
                let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as!   AVMetadataMachineReadableCodeObject
            
                qrCodeFrameView?.frame = barCodeObject.bounds;
            
                if metadataObj.stringValue != nil {
                    messageLabel.text = metadataObj.stringValue
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

