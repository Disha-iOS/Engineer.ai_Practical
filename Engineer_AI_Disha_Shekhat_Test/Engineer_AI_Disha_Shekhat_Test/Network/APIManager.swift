//
//  APIManager.swift
//  Engineer_AI_Disha_Shekhat_Test
//
//  Created by MAC241 on 18/12/19.
//  Copyright © 2019 MAC241. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {

    var header = ["Content-Type":"application/json"]
    
    static let shared : APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager: SessionManager
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
   
    func sendRequest(request: APIRouter, complition: @escaping(_ status:Bool, _ result: Data, _ message: String) -> Void) {
        Alamofire.request(request.path, method: request.method, parameters: request.parameters, encoding: URLEncoding.default, headers: header).responseData { (response) in
            
            DispatchQueue.main.async {
                switch response.result {
                    case .success:
                      complition(true,response.result.value ?? Data(), "")
                       break
                case .failure:
                    complition(false,Data(), response.result.error?.localizedDescription ?? "")
                    break
                }
            }
            
        }
    }
    
}
