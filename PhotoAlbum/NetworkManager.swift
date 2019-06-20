//
//  NetworkManager.swift
//  PhotoAlbum
//
//  Created by Hanan on 6/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation
import Alamofire
import Reachability

enum ServiceType: URLConvertible{
    
    case serviceLoadAlbums //Add more calls when needed
    
    func asURL() throws -> URL {
        return URL.init(string: self.URLString)!
    }
    
    
    //TODO : ADD UR CONSTANTS FILE
    var URLString : String{
        switch self{
        case .serviceLoadAlbums:
            return "https://jsonplaceholder.typicode.com/photos"
        }
    }
    
    var requestMethod : Alamofire.HTTPMethod{
        switch self{
        case .serviceLoadAlbums:
            return .get
        }
    }
}

class NetworkManager: NSObject {
    static let reachability = Reachability()!
    
    private override init() {
        super.init()
        networkReachability()
    }
    
    //MARK:-NetworkReachability
    func networkReachability() {
        NetworkManager.reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if reachability.connection == .wifi {
                    
                } else {
                }
            }
        }
        NetworkManager.reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
            }
        }
        
        do {
            try NetworkManager.reachability.startNotifier()
        } catch {
        }
    }
    
    class func requestForType(serviceType : ServiceType, params:[String: Any]?, completionBlock :@escaping (_ response:Array<Any>?,_ error: NSError?) -> ()) {
        
//        if reachability.connection == .cellular || reachability.connection == .wifi {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Accept-Encoding" : "gzip"
            ]
        
            AF.request(serviceType.URLString, method: serviceType.requestMethod, parameters: nil, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    DispatchQueue.main.async() {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                        print(response)
                        switch response.result{
                        case .success(let value):
                            if value is NSNull{
                                // SERVER MESS - SENDING NOTHING INSIDE SUCCESS
                                completionBlock(["success"], nil)
                                return
                            }
                            let responseValue = value as? Array<Any>
                            completionBlock(responseValue!, nil)
                        case .failure(let error):
                            if (response.response?.statusCode == 304){
                                completionBlock(Array<Any>(), nil)
                            }else{
                                print(Error.self)
                                completionBlock(nil, error as NSError)
                                if error.localizedDescription == "cancelled" {
                                } else {
                                    DispatchQueue.main.async() {
                                        //Show error alert
                                    }
                                }
                            }
                        }
                    }
            }
//        }
    }
}
