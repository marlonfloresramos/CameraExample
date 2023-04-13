//
//  ContentView.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var cameraManager = CameraManager()
    @State var presentCameraView = false
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                presentCameraView = true
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 60, height: 60)
                        .shadow(radius: 2)
                    Image(systemName: "camera.fill")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                }
            }
        }
        .padding()
        .fullScreenCover(isPresented: $presentCameraView) {
            CameraView(cancelPressed: {
                presentCameraView = false
            })
                .ignoresSafeArea()
        }
        .onAppear {
            cameraManager.requestPermission()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
