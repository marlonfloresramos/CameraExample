//
//  HomeView.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import SwiftUI

struct HomeView: View {
    @State var albums: [Album] = Album.mockedList
    
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
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
