//
//  PlaceMapTableViewCell.swift
//  Places
//
//  Created by  Buxlan on 5/21/21.
//

import UIKit
import MapKit

class PlaceMapTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet var mapView: MKMapView!
    
    func configure(data: Place) {
        
        let coordinate =  CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
        
        isUserInteractionEnabled = true
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Невский"
        annotation.subtitle = "проспект"
        mapView.addAnnotation(annotation)
        
        mapView.showsScale = true
        
        mapView.isScrollEnabled = true
        mapView.setCenter(coordinate, animated: false)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
