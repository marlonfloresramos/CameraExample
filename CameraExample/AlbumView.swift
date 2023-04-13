//
//  ContentView.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import SwiftUI

struct AlbumView: View {
    @StateObject var cameraManager = CameraManager()
    @State var presentCameraView = false
    @State var images: [UIImage] = []
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        VStack {
            Text("Example Album")
                .font(.headline)
                .fontWeight(.bold)
            if images.count > 0 {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
            }
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
        .fullScreenCover(isPresented: $presentCameraView) {
            CameraView(cancelPressed: {
                presentCameraView = false
            }, getImage: { image in
                images.append(image)
                presentCameraView = false
            })
            .ignoresSafeArea()
        }
        .onAppear {
            cameraManager.requestPermission()
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
