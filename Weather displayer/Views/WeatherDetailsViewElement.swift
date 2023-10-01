//
//  WeatherDetailsViewElement.swift
//  Weather displayer
//
//  Created by Federico Imberti on 11/02/22.
//

import SwiftUI

/**
 Shows the detailed informations of the selected day's weather.
 It can either be used in 2 configurations
    1. `title` + `bigValue` to show a tyle useful for displayng purely numerical info such as the temperature
    2. `title` + `image` + `displayedInfo` to show a tile with rich informations correlated with an image in the middle
 */
struct WeatherDetailsViewElement: View {
	var title:String
	var image:String?
	var displayedInfo:String?
	var bigValue:String?
	
    var body: some View {
		ZStack {
			backgroundView
            
			VStack{
				titleView
				
				if
					let image = image,
					let displayedInfo = displayedInfo
				{
					imageAndInfoView(image, displayedInfo)
				} else if
					let bigValue = bigValue
				{
					showBigValue(bigValue)
                } else {
                    // Incorrected combination of parameters or neither image, displayedInfo or bigValue have been provided
                    imageAndInfoView("exclamationmark.icloud.fill", "No data")
                        .foregroundColor(.red.opacity(0.8))
                }
			}
		}
		.frame(width: 150, height: 150)
	}
}

extension WeatherDetailsViewElement {
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.secondary.opacity(0.3))
    }
    
    private var titleView: some View{
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
    }
    
    private func imageAndInfoView(_ image:String, _ displayedInfo:String) -> some View {
        return Group {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.multicolor)
                .frame(width: 50, height: 50)
            
            Text(displayedInfo)
                .font(.headline)
        }
    }
    
    private func showBigValue(_ bigValue: String) -> some View{
        Text(bigValue)
            .font(.largeTitle)
            .bold()
            .minimumScaleFactor(0.7)
            .padding()
    }
}

struct WeatherDetailsViewElement_Previews: PreviewProvider {
	static var previews: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    WeatherDetailsViewElement(title: "Max", bigValue: "21°C")
                    WeatherDetailsViewElement(title: "Min", bigValue: "-1°C")
                }
                
                HStack {
                    WeatherDetailsViewElement(title: "Precipitation", image: "cloud.drizzle.fill", displayedInfo: "12 mm")
                    WeatherDetailsViewElement(title: "Wind Speed", image: "wind", displayedInfo: "34 KM/h")
                }
                
                HStack {
                    WeatherDetailsViewElement(title: "Spaghetti")
                    WeatherDetailsViewElement(title: "Meatballs")
                }
            }
        }
	}
}
