//
//  DataBaseManager.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation
import UIKit

class DataBaseManager: NSObject {
    
    class func saveAlbumsToDb(_ completionBlock : @escaping ()->()) {
        PhotoAlbumServiceManager.loadAlbums { (response, error) in
            if response != nil {
                let context = CoreDataStack.persistentContainer.viewContext
                for dictionary in response! {
                    let album = Album(context:context)
                    album.parseJSON(withResponse: dictionary as! [String : Any])
                }
                CoreDataStack.saveContext()
                completionBlock()
            }else{
                // Do nothing -  no error, response is empty
            }
            if error != nil {
                //Show error
            }
        }
    }
    
    class func loadAlbumsFromDb() -> [AlbumViewModel] {
        let context = CoreDataStack.persistentContainer.viewContext
        var viewModelArray = [AlbumViewModel]()
        do {
            let albums : [Album] = try context.fetch(Album.fetchRequest())
            if albums.count > 0{
                for album in albums{
                    let viewModel = AlbumViewModel(data: album)
                    viewModelArray.append(viewModel!)
                }
            }
        }catch {
            print("Error fetching data from CoreData")
        }
        return viewModelArray
    }
}
