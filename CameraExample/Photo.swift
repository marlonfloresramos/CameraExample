//
//  Photo.swift
//  CameraExample
//
//  Created by Marlon Gabriel Flores Ramos on 14/04/23.
//

import UIKit
import CoreData

@objc(Photo)
public class Photo: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var image: UIImage
    @NSManaged public var album: Album?
    @NSManaged public var id: UUID
}
