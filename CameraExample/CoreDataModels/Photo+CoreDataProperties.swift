//
//  Photo+CoreDataProperties.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 14/04/23.
//
//

import UIKit
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var album: Album?
    @NSManaged public var image: Data?
    
    var photo: UIImage {
        if let image {
            return UIImage(data: image) ?? UIImage()
        } else {
            return UIImage()
        }
    }
}

extension Photo : Identifiable {

}
