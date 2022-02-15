//
//  ContentView.swift
//  WatchIntegration WatchKit Extension
//
//  Created by Federico Imberti on 15/02/22.
//

import SwiftUI

struct WeatherView: View {
	
	@StateObject private var vm = WeatherViewModel()
	
	var body: some View {
		ScrollView(.vertical){
			VStack (spacing: 15){
				HStack{
					VStack(alignment: .leading){
						Text(vm.cityname)
							.font(.title2)
							.fontWeight(.semibold)
							.minimumScaleFactor(0.7)
						
						Text(vm.provinceAndCountry)
							.font(.title3)
							.minimumScaleFactor(0.8)
					}
					Spacer()
				}
				
				Text("\" \(vm.highlightedWeather.description!) \"")
					.font(.subheadline)
					.foregroundColor(.secondary)
				
				Image(systemName: vm.highlightedWeather.icon!)
					.resizable()
					.scaledToFit()
					.frame(height: 60)
				
				VStack(spacing: 15){
					HStack(spacing: 15){
						WeatherDataElement(title: "Max", bigValue: "10°C")
						WeatherDataElement(title: "Min", bigValue: "-1°C")
					}
					HStack(spacing: 15){
						WeatherDataElement(image: "cloud.drizzle.fill", displayedInfo: "\(vm.highlightedWeather.precip!)mm")
						WeatherDataElement(image: "wind", displayedInfo: "\(vm.highlightedWeather.windSpeed!)Km/h")
					}
					HStack(spacing: 15){
						WeatherDataElement(image: "sun.max.fill", displayedInfo: "5")
						WeatherDataElement(image: "bolt.fill", displayedInfo: "\(vm.highlightedWeather.solarEnergy!)MWh")
					}
				}
			}
		}
		.padding(.horizontal)
	}
}

struct WeatherView_Previews: PreviewProvider {
	static var previews: some View {
		WeatherView()
	}
}
