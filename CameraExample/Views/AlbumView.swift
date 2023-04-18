//
//  ContentView.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import SwiftUI

struct AlbumView: View {
    @State var album: Album
    @StateObject var cameraManager = CameraManager()
    @State var presentCameraView = false
    @State var presentAlbumOptions = false
    @State var presentChangeAlbumName = false
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.dismiss) private var dismiss
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
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
            .navigationTitle(album.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentAlbumOptions = true
                    } label: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    }
                }
            }
            .actionSheet(isPresented: $presentAlbumOptions) {
                ActionSheet(title: Text("Select an option"), message: nil, buttons: [
                    .default(Text("Edit Name"), action: {
                        presentChangeAlbumName = true
                    }),
                    .destructive(Text("Delete Album"), action: {
                        manager.deleteAlbum(album: album)
                        dismiss()
                    }),
                    .cancel()
                ]
                )
            }
            .alert("Update Album", isPresented: $presentChangeAlbumName, actions: {
                TextField("Name", text: $album.name)
                Button("Save", action: {
                    manager.updateAlbum(album: album)
                })
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("Write the new album's name")
            })
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(album: Album())
    }
}
