//
//  WeatherViewModel.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit
import Combine

class WeatherViewModel: ObservableObject {
	@Published var weatherDataArray:WeatherData = WeatherData.mockData
	
	private let downloadDataManager = DownloadDataManager.shared
	private var cancellables = Set<AnyCancellable>()
	
	init(){
		addSubscriberToWeatherDataArray()
	}
	
	func addSubscriberToWeatherDataArray(){
		downloadDataManager.$downloadedData.sink { receivedWeather in
			self.weatherDataArray = receivedWeather
		}
		.store(in: &cancellables)
	}
	
}
