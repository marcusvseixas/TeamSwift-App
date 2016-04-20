//
//  ThirdViewController.swift
//  TeamSwift-App
//
//  Created by Sam Wylock on 3/3/16.
//
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    override func viewDidLoad(){
        super.viewDidLoad()
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
            //view.bringSubviewToFront(messageLabel)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
            qrCodeFrameView?.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView!)
                view.bringSubviewToFront(qrCodeFrameView!)
            }else{ // If device has no camera or camera cannot be detected, then display a message
                //messageLabel.text = "No Camera Detected, Cannot Scan"
                return
        }
    }

}
