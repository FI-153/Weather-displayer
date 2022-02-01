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
      .frame(width: 280, height: 50, alignment: .center)
      .background(Color.white)
      .font(.system(size: 20, weight: .bold, design: .default))
      .cornerRadius(10)
  }
}

