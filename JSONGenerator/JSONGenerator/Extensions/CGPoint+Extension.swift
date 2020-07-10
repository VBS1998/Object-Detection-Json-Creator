//
//  CGPoint+Extension.swift
//  JSONGenerator
//
//  Created by Gustavo Vilas Boas on 09/07/20.
//  Copyright © 2020 Gustavo Vilas Boas. All rights reserved.
//

import Foundation

extension CGPoint{
    
    func distance(to cgPoint: CGPoint) -> CGFloat{
        return sqrt( (self.x - cgPoint.x)*(self.x - cgPoint.x) + (self.y - cgPoint.y)*(self.y - cgPoint.y) )
    }
}
