//
//  HomeView.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import SwiftUI

struct HomeView: View {
    @State var albums: [Album] = Album.mockedList
    @State var presentAddAlbum = false
    @State var newAlbumName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Albums")
                    .font(.title)
                List(albums, id: \.self) { album in
                    NavigationLink {
                        AlbumView()
                    } label: {
                        Text(album.name)
                    }
                }
                Spacer()
                    .frame(height: 20)
                Button {
                    presentAddAlbum = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 60, height: 60)
                            .shadow(radius: 2)
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
        .alert("Add Album", isPresented: $presentAddAlbum, actions: {
            TextField("Name", text: $newAlbumName)
            Button("Add", action: {
                albums.append(Album(name: newAlbumName))
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Write the new album name")
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
