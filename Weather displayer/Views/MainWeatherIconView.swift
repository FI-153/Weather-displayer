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
		VStack(spacing: 8){
			Image(systemName: self.imageName)
				.renderingMode(.original)
				.resizable()
				.scaledToFit()
				.frame(width: 150, height: 150)
				.shadow(radius: 10)
				.padding(.bottom)
			
			Text(String(self.temperature) + "°C")
				.font(.largeTitle)
				.fontWeight(.bold)
				.foregroundColor(.white)
			
			Text("\"" + description + "\"")
				.font(.title2)
				.fontWeight(.semibold)
				.minimumScaleFactor(0.7)
				.foregroundColor(.secondary)
				.frame(height: 100)
		}
		.padding(.horizontal)
	}
}
