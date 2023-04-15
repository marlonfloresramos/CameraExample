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
    var album: Album
    
    @EnvironmentObject var manager: DataManager
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(album.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                if manager.filteredImages.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(manager.filteredImages) { photo in
                                NavigationLink {
                                    DetailView(image: photo.photo)
                                } label: {
                                    Image(uiImage: photo.photo)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                            }
                        }
                    }
                }
                Spacer()
                Button {
                    cameraManager.requestPermission { hasAccess in
                        presentCameraView = hasAccess
                    }
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
                    manager.addPhoto(in: album, image: image)
                    presentCameraView = false
                })
                .ignoresSafeArea()
            }
            .onAppear {
                manager.filterImages(with: album)
            }
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(album: Album())
    }
}
