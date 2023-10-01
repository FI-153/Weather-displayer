//
//  WeatherViewModel.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
	
	@Published var titleString:String = WeatherData.mockData.cityname!
	@Published var provinceAndCountry:String = WeatherData.mockData.provinceAndCountry!
	@Published var highlightedWeather:Day = Day.mockData.first!
	@Published var nextDays:[Day] = Day.mockData
	@Published var isLoading:Bool = true
	@Published var isCityTextViewFocused:Bool =	false
	@Published var isSheetShown:Bool = false
	
	init(){
		addSubscriberToWeatherDataArray()
		addSubscriberToIsLoading()
	}
	
	private let downloadDataManager = DownloadDataManager.getShared()
    private var cancellables = 	Set<AnyCancellable>()
    func addSubscriberToWeatherDataArray(){
        downloadDataManager
            .$downloadedData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedWeather in
                
                guard let self = self else { return }
                
                self.titleString = receivedWeather.cityname!
                self.provinceAndCountry = receivedWeather.provinceAndCountry!
                self.highlightedWeather = receivedWeather.days!.first!
                self.nextDays = receivedWeather.days!
                
            }
            .store(in: &cancellables)
	}
    
    private func addSubscriberToIsLoading(){
        downloadDataManager
            .$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                
                self.isLoading = isLoading
            }
            .store(in: &cancellables)
    }
    
	func setTodaysWeather(to day : Day) {
		self.highlightedWeather = day
	}
	
	func changeHighlightedWeater(to day : Day) {
		self.highlightedWeather = day
	}
	
	var blurRadiusForLoading: CGFloat {
		isLoading ? 20 : 0
	}
	
	var blurRadiusForchangingCity: CGFloat {
		isCityTextViewFocused ? 20 : 0
	}
	
	var isUiDisabled: Bool {
		isLoading
	}
	
}
