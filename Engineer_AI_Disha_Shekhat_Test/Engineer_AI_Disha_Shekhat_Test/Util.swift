//
//  Util.swift
//  Engineer_AI_Disha_Shekhat_Test
//
//  Created by MAC241 on 18/12/19.
//  Copyright © 2019 MAC241. All rights reserved.
//

import UIKit

class Util {

    class func formattedDate(date: String) -> String {
        //2019-12-18T09:08:07.000Z
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "E, d MMMM yyyy HH:mm:ss a"
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }

}
