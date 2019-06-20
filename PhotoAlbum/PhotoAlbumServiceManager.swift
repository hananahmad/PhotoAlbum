//
//  PhotoAlbumServiceManager.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation

class PhotoAlbumServiceManager: NSObject {
    class func loadAlbums (_ completionBlock : @escaping (_ responseArray:Array<Any>?, _ errorObj : NSError?)->()) {
        
        NetworkManager.requestForType(serviceType: ServiceType.serviceLoadAlbums, params: nil) { (response, error) in
            if let error = error {
                completionBlock(nil, error)
            }else if let response = response {
                completionBlock(response, nil)
            }
        }
    }
}
