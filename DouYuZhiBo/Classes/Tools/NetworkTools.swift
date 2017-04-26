//
//  NetworkTools.swift
//  DouYuZhiBo
//
//  Created by 买明 on 24/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType {
    case get
    case post
}

struct NetworkTools {
    static func request(_ method: RequestType,
                        _ urlString: String,
                        _ parameters: [String: Any]? = nil,
                        _ completion: @escaping (_ result: Any) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        let httpMethod = method == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(url,
                          method: httpMethod,
                          parameters: parameters)
                 .responseJSON { (response) in
                    guard let result = response.result.value else {
                        if let error = response.result.error {
                            print(error)
                        }
                        
                        return
                    }
                    
                    completion(result)
        }
    }
}
