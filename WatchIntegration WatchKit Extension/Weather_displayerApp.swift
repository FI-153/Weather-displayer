//
//  Weather_displayerApp.swift
//  WatchIntegration WatchKit Extension
//
//  Created by Federico Imberti on 15/02/22.
//

import SwiftUI

@main
struct Weather_displayerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
				WeatherView()
            }
        }
    }
}
