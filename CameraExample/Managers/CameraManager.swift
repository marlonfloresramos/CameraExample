//
//  CameraManager.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import UIKit
import AVFoundation

class CameraManager : ObservableObject {
    
    func requestPermission(completion: @escaping (Bool) -> ()) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            DispatchQueue.main.async {
                completion(accessGranted)
            }
        })
    }
}
