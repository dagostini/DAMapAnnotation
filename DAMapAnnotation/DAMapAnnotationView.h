//
//  DAMapAnnotation.h
//  DAMapAnnotation
//
//  Created by Dejan on 11/05/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface DAMapAnnotationView : UIView

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

/*!Sets marker and renders the text in the info view.
 *\param marker Marker to set.
 */
- (void)setMarker:(GMSMarker *)marker;

/*!Crates the annotation image from annotation view.
 *\param marker Marker from which a new annotationView will be created.
 *\param iconImage Pin image that will be displayed below the annotation view.
 */
+ (UIImage *)annotationImageWithMarker:(GMSMarker *)marker andPinIcon:(UIImage *)iconImage;

@end
