//
//  FileRequestViewController.swift
//  JSONGenerator
//
//  Created by Gustavo Vilas Boas on 09/07/20.
//  Copyright © 2020 Gustavo Vilas Boas. All rights reserved.
//

import Cocoa
import ADragDropView

class FileRequestViewController: NSViewController {

    @IBOutlet weak var dragAndDropView: ADragDropView!
    @IBOutlet weak var centralLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isHidden = true
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.imageAlignment = .alignCenter
        imageView.imageFrameStyle = .none
        
        dragAndDropView.delegate = self
        dragAndDropView.acceptedFileExtensions = ["png", "jpg"]
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard let dest = segue.destinationController as? RectingViewController else {return}
        
        dest.image = self.imageView.image
    }
}

extension FileRequestViewController : ADragDropViewDelegate{
    func dragDropView(_ dragDropView: ADragDropView, droppedFileWithURL URL: URL) {
        centralLabel.stringValue = URL.absoluteString
        imageView.isHidden = false
        imageView.image = NSImage(contentsOf: URL)
    }
    
    func dragDropView(_ dragDropView: ADragDropView, droppedFilesWithURLs URLs: [URL]) {
        self.dragDropView(dragDropView, droppedFileWithURL: URLs[0])
    }
}
