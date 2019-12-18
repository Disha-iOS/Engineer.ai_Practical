//
//  ListModel.swift
//  Engineer_AI_Disha_Shekhat_Test
//
//  Created by MAC241 on 18/12/19.
//  Copyright © 2019 MAC241. All rights reserved.
//

import UIKit

class ListModel: Codable {

    let hits: [Hits]?
    let totalPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case hits = "hits"
        case totalPage = "nbPages"
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.hits = try value.decodeIfPresent([Hits].self, forKey: .hits)
        self.totalPage = try value.decodeIfPresent(Int.self, forKey: .totalPage)
    }
    
}

class Hits: Codable {
    
    let createdDate: String?
    let title: String?
    var isSelected: Bool = false
    
    
    enum CodingKeys: String, CodingKey {
        case createdDate = "created_at"
        case title = "title"
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.createdDate = try value.decodeIfPresent(String.self, forKey: .createdDate)
        self.title = try value.decodeIfPresent(String.self, forKey: .title)
    }
    
}
