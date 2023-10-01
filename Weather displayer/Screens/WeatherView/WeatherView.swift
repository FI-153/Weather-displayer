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
            
            ScrollView{
                Spacer()
                cityNameView
                Group {
                    mainWeatherView
                    weatherNextDaysView
                    Spacer()
                    buttonsView
                    Spacer()
                }
                .blur(radius: vm.blurRadiusForchangingCity)
            }
#if !DEBUG
            .blur(radius: vm.blurRadiusForLoading)
            .disabled(vm.isUiDisabled)
#endif
            .sheet(isPresented: $vm.isSheetShown) {
                weatherDetailsView
            }
            
#if !DEBUG
            if vm.isLoading { loadingView }
#endif
        }
    }
    
}

extension WeatherView {

    private var cityNameView: some View{
        CityTextView(
            titleText: $vm.titleString,
            isCityTextViewSelected: $vm.isCityTextViewFocused,
            provinceAndCountry: vm.provinceAndCountry
        )
    }
    
    private var mainWeatherView: some View{
        if
            let conditions = vm.highlightedWeather.icon,
            let temparature = vm.highlightedWeather.temp,
            let description = vm.highlightedWeather.description
        {
            return MainWeatherIcon(
                imageName: conditions,
                temperature: temparature,
                description: description
            )
            .frame(width: 350, height: 350)
        } else {
            return MainWeatherIcon(
                imageName: "conditions",
                temperature: 0.0,
                description: "description"
            )
            .frame(width: 350, height: 350)
        }
    }
    
    private var weatherNextDaysView: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(vm.nextDays){ day in
                    if
                        let dayOfTheWeek = day.datetime,
                        let conditions = day.icon,
                        let temperature = day.temp,
                        let precipitation = day.precipProb
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
        .padding([.horizontal, .bottom])
    }
    
    private var buttonsView: some View{
        HStack{
            Group{
                Button {
                    vm.isSheetShown = true
                } label: {
                    Text("Show More")
                        .fontWeight(.semibold)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "location.fill")
                }
            }
            .buttonStyle(.bordered)
            .tint(.white)
            .font(.title)
        }
    }
    
    private var weatherDetailsView: some View{
        ZStack{
            BackgroundView()
            WeatherDetailsView(vm: WeatherDetailsViewModel(isSheetShown: $vm.isSheetShown, day: vm.highlightedWeather))
        }
    }
    
    private var loadingView: some View{
        ZStack{
            BackgroundView()
            ProgressView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView()
        }
    }
}
