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
    var imageURL : URL?
    
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
    
                currentRect = CGRect(origin: rectInit, size: rectSize)
                performSegue(withIdentifier: "name", sender: self)
            }
            currentRectInit = nil
            currentRect = nil
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
        
        dest.rect = self.currentRect
        dest.parentVC = self
    }
    
    @IBAction func done(_ sender: Any) {
        
        guard let imgWidth = imageView.image?.size.width else {return}
        guard let imgHeight = imageView.image?.size.height else {return}
        guard let URL = imageURL?.absoluteString.dropFirst(7) else {return} //Drop the initial "file://"
        
        let separatorIndex = URL.lastIndex(of: "/")?.utf16Offset(in: URL) ?? 0
        
        //let filePath = URL.dropLast(URL.count - separatorIndex - 1)
        let fileName = URL.dropFirst(separatorIndex + 1)
        
        var JSONFinalString = "[\n\t{\n\t\t\"image\": \"" + fileName + "\",\n"
        JSONFinalString += "\t\t\"annotations\": ["
        
        for rect in rects{
            JSONFinalString += "\t\t\t{\n"
            JSONFinalString += "\t\t\t\t\"label\": \"" + rect.name + "\",\n"
            JSONFinalString += "\t\t\t\t\"coordinates\": {\n"
            JSONFinalString += "\t\t\t\t\t\"x\": " + String(Float(rect.rect.origin.x)) + "\n"
            JSONFinalString += "\t\t\t\t\t\"y\": " + String(Float(rect.rect.origin.y)) + "\n"
            JSONFinalString += "\t\t\t\t\t\"width\": " + String(Float(rect.rect.size.width)) + "\n"
            JSONFinalString += "\t\t\t\t\t\"height\": " + String(Float(rect.rect.size.height)) + "\n"
            JSONFinalString += "\t\t\t\t}\n"
            JSONFinalString += "\t\t\t}"
            if rects.last?.rect != rect.rect || rects.last?.name != rect.name{
                JSONFinalString += ","
            }
            JSONFinalString += "\n"
        }
        
        JSONFinalString += "\t\t]\n"
        JSONFinalString += "\t}\n"
        JSONFinalString += "]"
        
        
        
        /*
        //HEADER----
        var JSONFinalString = "<annotation>\n\t<folder>"+filePath+"</folder>\n\t<filename>"+fileName+"</filename>\n\t<source>\n\t\t<database>ImageNet database</database>\n\t</source>\n\t<size>\n\t\t<width>"
        
        JSONFinalString += String(Float(imgWidth)) + "</width>\n\t\t<height>"
        
        JSONFinalString += String(Float(imgHeight)) + "</height>\n\t\t<depth>3</depth>\n\t</size>\n\t<segment>0</segment>\n"
        //-----------
        
        for rect in rects{
            JSONFinalString += "\t<object>\n\t\t<name>"
            JSONFinalString += rect.name
            JSONFinalString += "</name>\n\t\t<pose>Unspecified</pose>\n\t\t<truncated>0</truncated>\n"
            JSONFinalString += "\t\t<bndbox>\n"
            
            JSONFinalString += "\t\t\t<xmin>" + String(Float(rect.rect.origin.x)) + "</xmin>\n"
            JSONFinalString += "\t\t\t<ymin>" + String(Float(rect.rect.origin.y)) + "</ymin>\n"
            JSONFinalString += "\t\t\t<xmax>" + String(Float(rect.rect.origin.x + rect.rect.size.width)) + "</xmax>\n"
            JSONFinalString += "\t\t\t<ymax>" + String(Float(rect.rect.origin.y + rect.rect.size.height)) + "</ymax>\n"
                
            JSONFinalString += "\t\t</bndbox>\n"
            JSONFinalString += "\t</object>\n"
        }
        
        JSONFinalString += "</annotation>"
 */
        
        do{
            try JSONFinalString.write(toFile: "/Users/gustavovbs/Desktop/out.json", atomically: true, encoding: .ascii)
        }catch{
            print(error)
        }
    }
}
