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
		GeometryReader { geometry in
			ZStack {
				BackgroundView()
				
				VStack{
					
					Spacer()
					
					//MARK: - City name
					CityTextView(
						titleText: $vm.titleString,
						isCityTextViewSelected: $vm.isCityTextViewFocused,
						provinceAndCountry: vm.provinceAndCountry
					)
					
					//MARK: - Highlighted weather
					Group {
						if
							let conditions = 	vm.highlightedWeather.icon,
							let temparature = 	vm.highlightedWeather.temp,
							let description = 	vm.highlightedWeather.description
						{
							MainWeatherIcon(
								imageName: 	conditions,
								temperature: 	temparature,
								description: 	description
							)
								.frame(width: 350, height: 350)
						}
						
						//MARK: - Weather next days
						ScrollView(.horizontal, showsIndicators: false){
							HStack{
								ForEach(vm.nextDays){ day in
									
									if
										let dayOfTheWeek =	day.datetime,
										let conditions = 	day.icon,
										let temperature = 	day.temp,
										let precipitation = 	day.precipProb
									{
										Button {
											vm.changeHighlightedWeater(to: day)
										} label: {
											WeatherDayView(
												dayOfWeek: dayOfTheWeek,
												imageName: conditions,
												temperature: temperature,
												precipitaionChance: precipitation,
												isSelected: day == vm.highlightedWeather
											)
										}
									}
									
								}
							}
						}
						.padding(.horizontal)

						Spacer()
						
						//MARK: - Shown More Button
						Button {
							vm.isSheetShown = true
						} label: {
							WeatherButtonView(title: "Show More")
						}
						.sheet(isPresented: $vm.isSheetShown) {
							ZStack{
								BackgroundView()
								WeatherDetailsView(isSheetShown: $vm.isSheetShown, day: vm.highlightedWeather)
							}
						}
						
						
						Spacer()
						
					}
					.blur(radius: vm.blurRadiusForchangingCity)
				}
#if !DEBUG
				.blur(radius: vm.blurRadiusForLoading)
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
