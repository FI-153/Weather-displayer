//
//  MainWeatherIconView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 02/02/22.
//

import Foundation
import SwiftUI

struct MainWeatherIcon: View {
	var imageName:		String
	var temperature:	Float
	var description:	String
	
	var body: some View {
		VStack(spacing: 0){
			mainImageView
			temperatureView
            descriptionView
		}
		.padding(.horizontal)
	}
}

extension MainWeatherIcon {
    private var mainImageView: some View {
        Image(systemName: self.imageName)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .shadow(radius: 10)
    }
    
    private var temperatureView: some View{
        Text(String(self.temperature) + "°C")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    private var descriptionView: some View{
        Text("\"" + description + "\"")
            .font(.title2)
            .fontWeight(.semibold)
            .italic()
            .minimumScaleFactor(0.7)
            .foregroundColor(.secondary)
            .frame(height: 100)
    }
}


struct MainWeatherIcon_Previews: PreviewProvider {
    static var previews: some View{
        ZStack {
            BackgroundView()
            MainWeatherIcon(imageName: "cloud.sun.fill", temperature: 12, description: "Fine and dandy weather description")
        }
    }
}

