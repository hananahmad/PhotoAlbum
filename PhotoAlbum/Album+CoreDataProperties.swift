//
//  Album+CoreDataProperties.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        let request = NSFetchRequest<Album>(entityName: "Album")
        
//        request.propertiesToGroupBy = ["albumId", "id", "thumbnailUrl", "title", "url"]
//        request.propertiesToFetch   = ["albumId", "id", "thumbnailUrl", "title", "url"]
//        request.resultType = .dictionaryResultType
        return request
    }

    @NSManaged public var albumId: String?
    @NSManaged public var id: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

    
    //==================================
    // MARK: - Parse JSON
    //==================================
    func parseJSON(withResponse response:[String:Any]){
        self.id             = response["id"] as? String
        self.albumId        = response["albumId"] as? String
        self.thumbnailUrl   = response["thumbnailUrl"] as? String
        self.title          = response["title"] as? String
        self.url            = response["url"] as? String
    }
}
