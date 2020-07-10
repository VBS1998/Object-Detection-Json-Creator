//
//  RectingViewController.swift
//  JSONGenerator
//
//  Created by Gustavo Vilas Boas on 09/07/20.
//  Copyright © 2020 Gustavo Vilas Boas. All rights reserved.
//

import Cocoa

class RectingViewController: NSViewController {

    var image : NSImage?
    
    var rects : [NamedRect] = []
    var currentRectInit : CGPoint?
    var currentRect : CGRect?
  
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var rectableView: RectableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        imageView.image = image
    
        rectableView.addGestureRecognizer(NSPanGestureRecognizer(target: self, action: #selector(pan(_:))))
    }
    
    @objc func pan(_ recognizer: NSPanGestureRecognizer){
        if recognizer.state == .began{
            currentRectInit = recognizer.location(in: imageView)
        }
        else if recognizer.state == .ended{
            let endPoint = recognizer.location(in: imageView)
            
            guard let rectInit = currentRectInit else {return}
    
            let distance = rectInit.distance(to: endPoint)
    
            if distance > 10{
    
                let rectSize = CGSize(width: (endPoint.x - rectInit.x), height: (endPoint.y - rectInit.y))
    
                let rect = CGRect(origin: rectInit, size: rectSize)
                
                rects.append(NamedRect(from: rect, with: "Insira Um Nome"))
            }
            currentRectInit = nil
            addRects()
        }
        
        else if recognizer.state == .cancelled || recognizer.state == .failed{
            currentRectInit = nil
        }
    }
    
    func addRects(){
        rectableView.update(with: rects)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard let dest = segue.destinationController as? NameRequestViewController else {return}
        
//        dest.rect =
    }
    
}
