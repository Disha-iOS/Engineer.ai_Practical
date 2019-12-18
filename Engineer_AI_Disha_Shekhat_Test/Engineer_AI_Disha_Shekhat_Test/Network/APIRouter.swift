//
//  APIRouter.swift
//  Engineer_AI_Disha_Shekhat_Test
//
//  Created by MAC241 on 18/12/19.
//  Copyright © 2019 MAC241. All rights reserved.
//

import Foundation
import Alamofire

protocol Routable {
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
}

enum APIRouter: Routable {
    
    case getListData(Int)
    
}
extension APIRouter {
    
    var path: String {
        var endPoint = ""
        switch self {
        case .getListData(let pageNumber):
            endPoint = "page=" + "\(pageNumber)"
        }
        return "https://hn.algolia.com/api/v1/search_by_date?tags=story&" + endPoint
    }
}
extension APIRouter {
    
    var method: HTTPMethod {
        switch self {
        case .getListData:
            return .get
        }
    }
}

extension APIRouter {
    
    var parameters: Parameters? {
        switch self {
        case .getListData:
            return nil
        }
    }
}
