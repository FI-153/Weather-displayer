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
					.frame(height: 50)

				Text(self.provinceAndCountry)
					.font(.title2)
					.fontWeight(.semibold)
			}
			.minimumScaleFactor(0.9)
			.foregroundColor(.white)
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal)
			
		}
	}
}

struct CityTextView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			ZStack {
				BackgroundView()
				CityTextView(cityname: "Dalmine", provinceAndCountry: "Lombardia, Italia")
			}
			
			ZStack {
				BackgroundView()
				CityTextView(cityname: "Cazzano Sant'Andrea", provinceAndCountry: "Lombardia, Italia")
			}

			ZStack {
				BackgroundView()
				CityTextView(cityname: "Desenzano sul Borbonico borgo", provinceAndCountry: "Lombardia, Italia")
			}

		}
	}
}

