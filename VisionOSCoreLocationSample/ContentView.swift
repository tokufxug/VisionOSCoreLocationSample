//
//  ContentView.swift
//  VisionOSCoreLocationSample
//
//  Created by Sadao Tokuyama on 1/4/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {

    private let manager: CLLocationManager = CLLocationManager()
    @State var locationData: String = ""
    
    var body: some View {
        VStack {
            Button("Start Location") {
                Task {
                   await startLocationUpdates()
                }
            }.font(.extraLargeTitle)
            Text(locationData).font(.extraLargeTitle)
        }
        .padding()
    }
    
    func startLocationUpdates() async {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
        do {
            let updates = CLLocationUpdate.liveUpdates()
            for try await update in updates {
                if let location = update.location {
                    locationData = "\(location)"
                    print(locationData)
                }
                if update.isStationary {
                    break
                }
            }
        } catch {
            print(error)
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
