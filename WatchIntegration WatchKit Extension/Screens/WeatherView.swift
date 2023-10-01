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
            BackgroundView()
            
            ZStack{
                ScrollView(.vertical){
                    VStack (spacing: 15){
                        titleView
                        mainIcon
                        weatherDescription
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
            .fontWeight(.semibold)
			.foregroundColor(.secondary)
	}
	
	private var mainIcon: some View{
		Image(systemName: vm.highlightedWeather.icon!)
            .symbolRenderingMode(.multicolor)
			.resizable()
			.scaledToFit()
			.frame(height: 60)
	}
	
	private var detailsView: some View{
		VStack(spacing: 15){
			HStack(spacing: 15){
                WeatherDataElementTile(title: "Max", bigValue: "\(vm.highlightedWeather.tempMax!)")
				WeatherDataElementTile(title: "Min", bigValue: "\(vm.highlightedWeather.tempMin!)")
			}
			
			WeatherDataElementPill(title: "Precipitations", image: "cloud.drizzle.fill", displayedInfo: "\(vm.highlightedWeather.precip!) mm")
			WeatherDataElementPill(title: "Wind speed", image: "wind", displayedInfo: "\(vm.highlightedWeather.windSpeed!) KM/H")
			WeatherDataElementPill(title: "UV Index", image: "sun.max.fill", displayedInfo: String(vm.highlightedWeather.uvIndex!))
			WeatherDataElementPill(title: "Solar energy", image: "bolt.fill", displayedInfo: "\(vm.highlightedWeather.solarEnergy!) MWh")

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
