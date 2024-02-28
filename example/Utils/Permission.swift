//
//  Permission.swift
//  tutorial
//
//  Created by Hee Seok Jung on 2/28/24.
//

import Foundation
import AVFoundation
import UIKit

enum Permission {
    case camera, microphone
}

extension Permission {
    func checkPermission() -> Bool {
        print("\(self) permission check")
        return switch self {
        case .camera:
            checkCameraPermission()
        case .microphone:
            checkMicrophonePermission()
        }
    }
    
    private func checkCameraPermission() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            return true
        case .notDetermined: // The user has not yet been asked for camera access.
            var result = false
            AVCaptureDevice.requestAccess(for: .video) { granted in
                result = granted
            }
            return result
        case .denied: // The user denied camera access.
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            return false
        default: // Combine the two other cases into the default case
            return false
        }
    }
    
    private func checkMicrophonePermission() -> Bool {
        var result = false
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            result = granted
            if !result {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        return result
    }
}

extension Permission: CustomStringConvertible {
    public var description: String {
        switch self {
        case .camera:       return "Camera"
        case .microphone:   return "Microphone"
//        @unknown default:   return "Unknown"
        }
    }
}
