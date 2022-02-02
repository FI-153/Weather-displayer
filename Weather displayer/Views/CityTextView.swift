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
	var provinceAndCountry:String
	
	var body: some View {
		VStack(alignment: .leading) {
			Group{
				Text(self.cityname)
					.font(.largeTitle)
					.fontWeight(.bold)
				
				Text(self.provinceAndCountry)
					.font(.title2)
					.fontWeight(.semibold)
			}
			.foregroundColor(.white)
			.padding(.horizontal)
			
		}
	}
}

struct CityTextView_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			BackgroundView()
			CityTextView(cityname: "Cazzano Sant'Andrea", provinceAndCountry: "Lombardia, Italia")
		}
	}
}

