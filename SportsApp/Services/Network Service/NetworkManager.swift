//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Slsabel Hesham on 20/05/2024.
//

import Foundation
import Alamofire

class NetworkManager{
    static func getDataFromNetwork<T: Decodable>(request: Request, handler: @escaping (T?) -> Void) {
        AF.request(request.url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try request.decode(data: data) as? T
                    handler(result)
                } catch {
                    print("\(error.localizedDescription)")
                    handler(nil)
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
                handler(nil)
            }
        }
    }
}
