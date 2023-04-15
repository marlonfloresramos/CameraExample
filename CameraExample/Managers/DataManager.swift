//
//  DataManager.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 14/04/23.
//

import CoreData
import UIKit

class DataManager: ObservableObject {
    let container: NSPersistentContainer
    @Published var albums = [Album]()
    @Published var filteredImages = [Photo]()
    
    init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error while fetching data: \(error)")
            } else {
                print("succes")
            }
        }
        fetchAlbums()
    }
    
    func fetchAlbums() {
        let request = NSFetchRequest<Album>(entityName: "Album")
        do {
            albums = try container.viewContext.fetch(request)
        } catch {
            print("error while fetching data: \(error)")
        }
    }
    
    func addAlbum(name: String) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Album", in: container.viewContext)
        let album = Album(entity: entityDescription!, insertInto: container.viewContext)
        
        album.id = UUID()
        album.name = name
        saveData()
        fetchAlbums()
        print("Add album succesfully")
    }
    
    func addPhoto(in album: Album, image: UIImage) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Photo", in: container.viewContext)
        let photo = Photo(entity: entityDescription!, insertInto: container.viewContext)
        let imageData = image.jpegData(compressionQuality: 1)
        photo.id = UUID()
        photo.image = imageData
        photo.album = album
        saveData()
        filterImages(with: album)
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print("error while saving data: \(error)")
        }
    }
    
    func filterImages(with album: Album) {
        guard let photos = albums.filter( { $0.id == album.id }).first?.photos?.array as? [Photo] else { return }
        filteredImages = photos
    }
}
