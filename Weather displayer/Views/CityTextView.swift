//
//  CityTextView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 02/02/22.
//

import SwiftUI

struct CityTextView: View {
	
	@Binding var titleText:String
	@Binding var isCityTextViewSelected:Bool
    var provinceAndCountry:String

	private let downloadDataManager = DownloadDataManager.getShared()

	var body: some View {
        VStack(alignment: .leading) {
            cityNameView
            provinceAndCountryView
        }
        .minimumScaleFactor(0.9)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
	}
}

extension CityTextView {
    private var cityNameView: some View {
        TextField("", text: $titleText)
            .textFieldStyle(.plain)
            .keyboardType(.asciiCapable)
            .font(.system(size: 35, weight: .bold))
            .submitLabel(.go)
            .onSubmit {
                isCityTextViewSelected = false
                
                Task {
                    do {
                        try await downloadDataManager.downloadWeatherData(for: titleText)
                    } catch let error{
                        print(error.localizedDescription)
                    }
                }
            }
            .onTapGesture {
                isCityTextViewSelected = true
            }
    }
    
    private var provinceAndCountryView: some View{
        Text(self.provinceAndCountry)
            .font(.title2)
            .fontWeight(.semibold)
    }
}


struct CityTextView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Dalmine"), isCityTextViewSelected: .constant(false), provinceAndCountry: "Lombardia, Italia")
			}
			
			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Cazzano Sant'Andrea"), isCityTextViewSelected: .constant(false), provinceAndCountry: "Lombardia, Italia")
			}
			
			ZStack {
				BackgroundView()
				CityTextView(titleText: .constant("Desenzano sul Borbonico borgo"), isCityTextViewSelected: .constant(false), provinceAndCountry: "Lombardia, Italia")
			}
			
		}
	}
}

