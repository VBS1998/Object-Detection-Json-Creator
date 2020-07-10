//
//  NamedRect.swift
//  JSONGenerator
//
//  Created by Gustavo Vilas Boas on 10/07/20.
//  Copyright © 2020 Gustavo Vilas Boas. All rights reserved.
//

import Foundation

class NamedRect{
    
    var name : String
    var rect : CGRect
    
    init(from rect : CGRect, with name : String){
        
        var x = rect.origin.x
        var y = rect.origin.y
        var w = rect.size.width
        var h = rect.size.height
        
        if w < 0 {
            x += w
            w *= -1
        }
        if h < 0{
            y += h
            h *= -1
        }
        
        self.rect = CGRect(x: x, y: y, width: w, height: h)
        self.name = name
    }
}
