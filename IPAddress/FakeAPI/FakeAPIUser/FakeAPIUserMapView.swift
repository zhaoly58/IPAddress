//
//  FakeAPIUserMapView.swift
//  IPAddress
//
//  Created by Jimmy Zhao on 2024/05/21.
//

import SwiftUI
import MapKit

//struct MapView: View {
//    var coordinate: CLLocationCoordinate2D
//
//    var body: some View {
//        Map(position: .constant(.region(region)))
//    }
//
//    private var region: MKCoordinateRegion {
//        MKCoordinateRegion(
//            center: coordinate,
//            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
//        )
//    }
//}





//struct MapView: View {
//    var coordinate: CLLocationCoordinate2D
//
//    var body: some View {
//        Map(coordinateRegion: .constant(region))
//    }
//
//    private var region: MKCoordinateRegion {
//        MKCoordinateRegion(
//            center: coordinate,
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        )
//    }
//}
//
//#Preview {
//    MapView(coordinate: CLLocationCoordinate2D(latitude: 10.3456, longitude: 20.6419))
//}


struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )))
    }
}


#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: 59.3456, longitude: 34.6419))
}
