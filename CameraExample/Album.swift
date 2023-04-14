//
//  Album.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 13/04/23.
//

import Foundation

struct Album: Hashable {
    let name: String
    
    static var mockedList = [
        Album(name: "Album Name 1"),
        Album(name: "Album Name 2"),
        Album(name: "Album Name 3")
    ]
}
