//
//  MapKitTestViewController.swift
//  JKSwiftExtension_Example
//
//  Created by 小冲冲 on 2023/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import MapKit

class MapKitTestViewController: UIViewController {
    
    lazy var request: MKLocalSearch.Request = {
        let request = MKLocalSearch.Request()
        // 搜索关键字
        request.naturalLanguageQuery = "烤肉"
        // 搜索范围
        request.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        if #available(iOS 13.0, *) {
            request.resultTypes = .pointOfInterest
        }
        return request
    }()
    
    lazy var search: MKLocalSearch = {
        let search = MKLocalSearch(request: request)
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        search.start { (response, error) in
            guard let response = response else {
                debugPrint("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let randomMapItem = response.mapItems.randomElement() {
                print(randomMapItem.name ?? "Unknown name")
                print(randomMapItem.placemark.coordinate)
            } else {
                debugPrint("No nearby places found.")
            }
        }
        
        
    }
    
}
