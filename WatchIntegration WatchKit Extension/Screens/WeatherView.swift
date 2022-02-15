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
		ZStack{
			ScrollView(.vertical){
				VStack (spacing: 15){
					titleView
					
					weatherDescription
					
					mainIcon
					
					detailsView
				}
			}
			
			if vm.isLoading {
				loadingView
			}
		}
		.padding(.horizontal)
	}
}

extension WeatherView {
	private var titleView: some View {
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
	}
	
	private var weatherDescription: some View{
		Text("\" \(vm.highlightedWeather.description!) \"")
			.font(.subheadline)
			.foregroundColor(.secondary)
	}
	
	private var mainIcon: some View{
		Image(systemName: vm.highlightedWeather.icon!)
			.resizable()
			.scaledToFit()
			.frame(height: 60)
	}
	
	private var detailsView: some View{
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
				WeatherDataElement(image: "sun.max.fill", displayedInfo: String(vm.highlightedWeather.uvIndex!))
				WeatherDataElement(image: "bolt.fill", displayedInfo: "\(vm.highlightedWeather.solarEnergy!)MWh")
			}
		}
	}
	
	private var loadingView: some View{
		ZStack{
			Color.black.ignoresSafeArea()
			ProgressView()
		}
	}
}


struct WeatherView_Previews: PreviewProvider {
	static var previews: some View {
		WeatherView()
	}
}
