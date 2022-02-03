//
//  WeatherViewModel.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import UIKit
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
	
	@Published var cityname:String = 			WeatherData.mockData.cityname!
	@Published var provinceAndCountry:String =	WeatherData.mockData.provinceAndCountry!
	@Published var todayWeather:Day = 		Day.mockData.first!
	@Published var nextDays:[Day] = 			Day.mockData
	@Published var isLoading:Bool = 			true
	
	private let downloadDataManager = 		DownloadDataManager.shared
	private var cancellables = 				Set<AnyCancellable>()
	
	init(){
		addSubscriberToWeatherDataArray()
		addSubscriberToIsLoading()
	}
	
	func addSubscriberToWeatherDataArray(){
		downloadDataManager.$downloadedData.sink { [weak self] receivedWeather in
			
			guard let self = self else { return }
			
			self.cityname = 			receivedWeather.cityname!
			self.provinceAndCountry = 	receivedWeather.provinceAndCountry!
			self.todayWeather =		receivedWeather.days!.first!
			self.nextDays = 			receivedWeather.days!
			
		}
		.store(in: &cancellables)
	}
	
	func addSubscriberToIsLoading(){
		downloadDataManager.$isLoading.sink { [weak self] isLoading in
			guard let self = self else { return }
			
			self.isLoading = isLoading
		}
		.store(in: &cancellables)
	}
	
	var blurRadius: CGFloat {
		isLoading ? 20 : 0
	}
	
	var isUiDisabled: Bool {
		isLoading ? true : false
	}
	
}
