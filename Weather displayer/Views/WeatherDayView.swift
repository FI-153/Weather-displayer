//
//  WeatherDayView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 02/02/22.
//

import Foundation
import SwiftUI

struct WeatherDayView: View {
	var dayOfWeek: String
	var imageName: String
	var temperature: Float
	var precipitaionChance:	Float
	
	var isSelected:Bool? = false
	
	var body: some View {
		ZStack {
				
			Color.secondary.opacity(isSelected! ? 0.4 : 0.2)
			
            VStack{
				dayOfWeekView
                dayConditionsImageView
                temperatureView
                precipitationChanceView
			}
		}
		.frame(width: 100, height: 180)
		.clipShape(RoundedRectangle(cornerRadius: 15))
	}
}

extension WeatherDayView {
    private var dayOfWeekView: some View {
        Text(self.dayOfWeek)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
    
    private var dayConditionsImageView: some View{
        Image(systemName: self.imageName)
            .symbolRenderingMode(.multicolor)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
    
    private var temperatureView: some View{
        Text(String(self.temperature) + "°C")
            .font(.title2)
            .foregroundColor(.white)
    }
    
    private var precipitationChanceView: some View{
        VStack{
            if precipitaionChance > 0 {
                Text(String(Int(self.precipitaionChance)) + "%")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 20)
    }
}


struct WeatherDayView_Previews: PreviewProvider {
	static var previews: some View {
        ZStack {
            BackgroundView()
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(Day.mockData){ day in
                        
                        if
                            let dayOfTheWeek =	day.datetime,
                            let imageName = 		day.icon,
                            let temperature = 	day.temp,
                            let precipitation = 	day.precipProb
                        {
                            WeatherDayView(
                                dayOfWeek: 		dayOfTheWeek,
                                imageName: 		imageName,
                                temperature: 		temperature,
                                precipitaionChance:	precipitation,
                                isSelected: 		false
                            )
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
