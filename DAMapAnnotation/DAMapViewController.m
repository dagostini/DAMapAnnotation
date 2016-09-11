//
//  DAMapViewController.m
//  DAMapAnnotation
//
//  Created by Dejan on 11/05/14.
//  Copyright (c) 2014 Dejan. All rights reserved.
//

#import "DAMapViewController.h"
#import "DAMapAnnotation-Swift.h"
#import <stdlib.h>


@interface DAMapViewController () {
    NSMutableArray *places_;
    BOOL showingAnnotations_;
}

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end

@implementation DAMapViewController


#pragma mark - View Management

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    [self createPlaces];
}


#pragma mark - Map Management

- (void)createPlaces {
    if (!places_)
        places_ = [NSMutableArray new];
    
    [places_ removeAllObjects];
    
    for (int i = 0; i < kNumberOfPlaces; i++) {
        GMSMarker *place = [GMSMarker new];
        place.title = [NSString stringWithFormat:@"Dublin %d", i+1];
        place.snippet = [NSString stringWithFormat:@"Ireland %d", i+1];
        place.position = CLLocationCoordinate2DMake(53.2 + (arc4random()%100)/100.0, -6.15 + (arc4random()%100)/100.0);
        place.map = self.mapView;
        [places_ addObject:place];
    }
}

- (void)reloadPlaces {
    [self removePlacesFromMap];
    [self loadPlacesOnMap];
}

- (void)removePlacesFromMap {
    self.mapView.selectedMarker = nil;
    
    for (GMSMarker *place in places_) {
        place.map = nil;
        place.panoramaView = nil;
    }
}

- (void)loadPlacesOnMap {
    for (GMSMarker *place in places_) {
        
        if (showingAnnotations_)
            place.icon = [DAMapAnnotationView annotationImageWithMarker:place andPinIcon:[UIImage imageNamed:@"default_marker"]];
        else
            place.icon = [UIImage imageNamed:@"default_marker"];
        
        place.map = self.mapView;
    }
}

- (void)hideAllAnnotations {
    if (showingAnnotations_) {
        showingAnnotations_ = NO;
        [self reloadPlaces];
    }
}


#pragma mark - GMSMapViewDelegate

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
    DAMapAnnotationView *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"DAMapAnnotationView" owner:self options:nil] objectAtIndex:0];
    infoWindow.marker = marker;
    
    return infoWindow;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    [self hideAllAnnotations];
    
    return NO;
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [self hideAllAnnotations];
}


#pragma mark - User Actions

- (IBAction)toogleAnnotationsAction:(id)sender {
    showingAnnotations_ = !showingAnnotations_;
    [self reloadPlaces];
}


@end
