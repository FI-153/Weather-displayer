//
//  WeatherViewModel.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit
import Combine

class WeatherViewModel: ObservableObject {
	
	@Published var locationDetails:String = WeatherData.mockData.resolvedAddress!
	@Published var todayWeather:Day = Day.mockData.first!
	@Published var nextDays:[Day] = Day.mockData
	
	@Published var weatherData:WeatherData = WeatherData.mockData
	
	private let downloadDataManager = DownloadDataManager.shared
	private var cancellables = Set<AnyCancellable>()
	
	init(){
		addSubscriberToWeatherDataArray()
	}
	
	func addSubscriberToWeatherDataArray(){
		downloadDataManager.$downloadedData.sink { receivedWeather in
			
			self.weatherData = receivedWeather
			
			self.locationDetails = receivedWeather.resolvedAddress!
			self.todayWeather = receivedWeather.days!.first!
			self.nextDays = receivedWeather.days!
			
		}
		.store(in: &cancellables)
	}
	
}
