//
//  ViewControllerViewModel.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerViewModel: NSObject {
    var items = [Any]()
    
    func refreshWith(data: Array<Any>, _ completionBlock : @escaping ()->()) {
        self.items = data
        completionBlock()
    }
}

//==================================
// MARK: - UITableViewDataSource
//==================================
extension ViewControllerViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as? AlbumTableViewCell {
            cell.item = item as? AlbumViewModel
            return cell
        }
        return UITableViewCell()
    }
}


//==================================
// MARK: - AlbumViewModel
//==================================
class AlbumViewModel: NSObject {
    var albumId     : String?
    var id          : String?
    var thumbnailUrl: String?
    var title       : String?
    var url         : String?
    
    init?(data: Album) {
        self.albumId        = data.albumId
        self.id             = data.id
        self.thumbnailUrl   = data.thumbnailUrl
        self.title          = data.title
        self.url            = data.url
    }
}
