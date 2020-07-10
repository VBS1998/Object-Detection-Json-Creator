//
//  RectableImageView.swift
//  JSONGenerator
//
//  Created by Gustavo Vilas Boas on 09/07/20.
//  Copyright © 2020 Gustavo Vilas Boas. All rights reserved.
//

import Cocoa
import CoreGraphics

class RectableView: NSView {
    
    var rects : [NamedRect] = []
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        for rect in rects{

            guard let context = NSGraphicsContext.current?.cgContext else {return}

            let rawContext = NSGraphicsContext.current
            rawContext?.saveGraphicsState()

            NSColor.yellow.set()

            let origin = rect.rect.origin
            let size = rect.rect.size

            let figure = NSBezierPath(rect: NSRect(origin: origin, size: size)) // container for line(s)
            figure.lineWidth = 5
            figure.stroke()
            
            let name = rect.name
            
            let textStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            
            textStyle.alignment = .left
            textStyle.lineBreakMode = .byClipping
            let textFontAttributes = [
                NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor: NSColor.white,
                NSAttributedString.Key.backgroundColor: NSColor.clear,
                NSAttributedString.Key.baselineOffset: 0,
                NSAttributedString.Key.paragraphStyle: textStyle
                ] as [NSAttributedString.Key : Any]
            
            name.draw(in: CGRect (origin: origin, size: CGSize(width: 800, height: 20)), withAttributes: textFontAttributes)
            
            context.strokePath()
            
        }
    }
    
    func update(with rects : [NamedRect]){
        self.rects = rects
        
        self.setNeedsDisplay(self.frame)
        self.displayIfNeeded()
    }
}
