//
//  WeatherViewModel.swift
//  WatchIntegration WatchKit Extension
//
//  Created by Federico Imberti on 15/02/22.
//

import UIKit
import Combine

class WeatherViewModel: ObservableObject {
	
	@Published var cityname:String = 			WeatherData.mockData.cityname!
	@Published var provinceAndCountry:String =	WeatherData.mockData.provinceAndCountry!
	@Published var highlightedWeather:Day = 	Day.mockData.first!
	@Published var isLoading:Bool = 			true
	
	private let downloadDataManager = 	DownloadDataManager.getShared()
	private var cancellables = 			Set<AnyCancellable>()
	
	init(){
		addSubscriberToWeatherData()
		addSubscriberToIsLoading()
	}
	
	func addSubscriberToWeatherData(){
		downloadDataManager.$downloadedData.sink { [weak self] receivedWeather in
			
			guard let self = self else { return }
			
            if
                let cityname = receivedWeather.cityname,
                let provinceAndCountry = receivedWeather.provinceAndCountry,
                let days = receivedWeather.days
            {
                self.cityname = 			cityname
                self.provinceAndCountry = 	provinceAndCountry
                self.highlightedWeather =	days.first!
            } else {
                self.cityname =             "Network error"
                self.provinceAndCountry =   "Network error"
            }

		}
		.store(in: &cancellables)
	}

	private func addSubscriberToIsLoading(){
		downloadDataManager.$isLoading.sink { [weak self] isLoading in
			guard let self = self else { return }
			
			self.isLoading = isLoading
		}
		.store(in: &cancellables)
	}

}
