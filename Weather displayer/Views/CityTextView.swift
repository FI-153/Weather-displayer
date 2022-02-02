//
//  CityTextView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 02/02/22.
//

import Foundation
import SwiftUI

struct CityTextView: View {
	var cityname:String
	
	var body: some View {
		Text(self.cityname)
			.font(.largeTitle)
			.fontWeight(.bold)
			.foregroundColor(.white)
			.padding()
	}
}

