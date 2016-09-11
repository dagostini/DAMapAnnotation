//
//  DAMapAnnotationView.swift
//  DAMapAnnotation
//
//  Created by Dejan on 11/09/16.
//  Copyright © 2016 Dejan. All rights reserved.
//

import UIKit

@objc(DAMapAnnotationView)
class DAMapAnnotationView: UIView {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subtitle: UILabel!
    
    var marker: GMSMarker? {
        didSet {
            title.text = marker?.title
            subtitle.text = marker?.snippet
        }
    }
}


// MARK: - Annotation Factory
extension DAMapAnnotationView {
    
    static func annotationImage(withMarker marker: GMSMarker, andPinIcon icon: UIImage) -> UIImage? {
        
        // Create main info window
        guard let infoWindow = NSBundle.mainBundle().loadNibNamed(NSStringFromClass(self), owner: self, options: [:]).first as? DAMapAnnotationView else {
            return nil
        }
        
        // End image context before the methods returns
        defer {
            UIGraphicsEndImageContext();
        }
        
        infoWindow.marker = marker
        
        // Create container view
        let annotationImage = UIView.init(frame: CGRectMake(0, 0, infoWindow.frame.size.width, infoWindow.frame.size.height + icon.size.height))
        annotationImage.addSubview(infoWindow)
        
        // Create icon image, and center it below the view
        let iconImageView = UIImageView(image: icon)
        iconImageView.backgroundColor = UIColor.clearColor()
        iconImageView.frame = CGRectMake((infoWindow.frame.size.width - icon.size.width)/2, infoWindow.frame.size.height, icon.size.width, icon.size.height)
        annotationImage.addSubview(iconImageView)
        
        // Render image
        UIGraphicsBeginImageContextWithOptions(annotationImage.frame.size, false, UIScreen.mainScreen().scale)
        if let ctx = UIGraphicsGetCurrentContext() {
            annotationImage.layer.renderInContext(ctx)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        
        return nil
    }
}

