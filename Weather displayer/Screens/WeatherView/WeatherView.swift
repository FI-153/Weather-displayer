//
//  ContentView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import SwiftUI

struct WeatherView: View {
	@StateObject private var vm = WeatherViewModel()
	
	var body: some View {
		ZStack {
			BackgroundView()
			
			VStack{
				
				Spacer()
				
				//title
				CityTextView(cityname: vm.cityname, provinceAndCountry: vm.provinceAndCountry)
				
				//Current weather
				if
					let conditions = 	vm.todaysWeather.icon,
					let temparature = 	vm.todaysWeather.temp,
					let description = 	vm.todaysWeather.description
				{
					MainWeatherIcon(
						imageName: 	WeatherDataIcons.icons[conditions] ?? "",
						temperature: 	temparature,
						description: 	description
					)
				}
				
				//Weather next days
				ScrollView(.horizontal, showsIndicators: false){
					HStack{
						ForEach(vm.nextDays){ day in
							
							if
								let dayOfTheWeek =	day.datetime,
								let conditions = 	day.icon,
								let temperature = 	day.temp,
								let precipitation = 	day.precip
							{
								WeatherDayView(
									dayOfWeek: dayOfTheWeek,
									imageName: WeatherDataIcons.icons[conditions] ?? "",
									temperature: temperature,
									precipitaionChance: precipitation,
									isSelected: day == vm.todaysWeather
								)
							}
							
						}
					}
				}
				.padding(.horizontal)
				
				Spacer()
				
				Button {
					
				} label: {
					WeatherButtonView(title: "Change City")
						.shadow(radius: 5)
				}
				
				Spacer()
				
			}
			#if !DEBUG
			.blur(radius: vm.blurRadius)
			.disabled(vm.isUiDisabled)
			#endif
			
			#if !DEBUG
			if vm.isLoading {
				ZStack{
					BackgroundView()
					ProgressView()
				}
			}
			#endif
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			WeatherView()
			
			WeatherView()
				.preferredColorScheme(.dark)
		}
	}
}
