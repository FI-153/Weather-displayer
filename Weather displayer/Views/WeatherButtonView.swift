//
//  WeatherButtonView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import SwiftUI

struct WeatherButtonView: View {
	var title:String
	
	var body: some View {
		Text(self.title)
			.foregroundColor(.black.opacity(0.8))
			.frame(width: 200, height: 50, alignment: .center)
			.background(Color.white.opacity(0.8))
			.font(.system(size: 20, weight: .bold, design: .default))
			.cornerRadius(10)
	}
}

