//
//  CameraExampleApp.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import SwiftUI

@main
struct CameraExampleApp: App {
    @StateObject private var manager: DataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(manager)
        }
    }
}
