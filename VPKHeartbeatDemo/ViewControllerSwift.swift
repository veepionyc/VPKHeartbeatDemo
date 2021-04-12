//
//  ViewControllerSwift.swift
//  VPKHeartbeatDemo
//
//  Created by jonathan on 15/10/2018.
//  Copyright © 2018 jonathan. All rights reserved.
//
    
import UIKit
import AdobeMediaSDK
import AdobeMobileSDK

@objc class ViewControllerSwift: ViewController ,VPKPreviewPassThroughDelegate {
    
    
    
    
     func vpkPreview(_ preview:VPKPreview, handledTap tapGestureRecognizer: UITapGestureRecognizer) {
        var sampleMetadata =  [String:String]()
         sampleMetadata ["TestMetadaKey"] = "TestMetadaValue"
        VPKHeartbeatProvider.createSession(
            preview,
            mediaObject: self.mediaObject,
            metadata: sampleMetadata
        )
        
    }
    
}
