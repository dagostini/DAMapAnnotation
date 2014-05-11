//
//  DAMapAnnotation.m
//  DAMapAnnotation
//
//  Created by Dejan on 11/05/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import "DAMapAnnotationView.h"


@interface DAMapAnnotationView() {
    GMSMarker *marker_;
}

@end


@implementation DAMapAnnotationView


#pragma mark - View Management

- (void)bindGUI {
    if (marker_) {
        self.title.text = marker_.title;
        self.subtitle.text = marker_.snippet;
    }
}


#pragma mark - Setters

- (void)setMarker:(GMSMarker *)marker {
    marker_ = marker;
    [self bindGUI];
}


#pragma mark - Map Icon Utility Methods

+ (UIImage *)annotationImageWithMarker:(GMSMarker *)marker andPinIcon:(UIImage *)iconImage {
    
    // Create main info window
    DAMapAnnotationView *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"DAMapAnnotationView" owner:self options:nil] objectAtIndex:0];
    [infoWindow setMarker:marker];
    
    // Create container view
    UIView *annotationImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoWindow.frame.size.width, infoWindow.frame.size.height + iconImage.size.height)];
    [annotationImage addSubview:infoWindow];
    
    // Create icon image, and center it below the view
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
    iconImageView.backgroundColor = [UIColor clearColor];
    iconImageView.frame = CGRectMake((infoWindow.frame.size.width - iconImage.size.width)/2, infoWindow.frame.size.height, iconImage.size.width, iconImage.size.height);
    [annotationImage addSubview:iconImageView];
    
    
    // Render image
    UIGraphicsBeginImageContextWithOptions(annotationImage.frame.size, NO, [UIScreen mainScreen].scale);
    [annotationImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
