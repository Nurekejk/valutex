//
//  MapViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 15.07.2023.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController {
    
    // MARK: - UI
    private lazy var googleMapView: GMSMapView = {
        return GMSMapView(frame: view.bounds,
                                  camera: camera)
    }()
    
    private lazy var camera: GMSCameraPosition = {
            return GMSCameraPosition(latitude: -33.86,
                                     longitude: 151.20,
                                      zoom: 7)
      }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(googleMapView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        googleMapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
