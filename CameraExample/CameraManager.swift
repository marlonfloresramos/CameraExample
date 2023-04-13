//
//  CameraManager.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import UIKit
import AVFoundation

class CameraManager : ObservableObject {
    @Published var permissionGranted = false
    
    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            DispatchQueue.main.async {
                self.permissionGranted = accessGranted
            }
        })
    }
}
