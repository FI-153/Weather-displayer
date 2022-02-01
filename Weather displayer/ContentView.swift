//
//  ContentView.swift
//  Weather displayer
//
//  Created by Federico Imberti on 01/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            backgroundView()
            
            VStack{
                
                //title
                cityTextView(cityname: "Cupertino, CA")
                
                //Current weather
                mainWeatherIcon(imageName: "cloud.sun.fill", temperature: 76)
                
                
                //Weather day by day
                HStack(spacing: 20){
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 80)
                    WeatherDayView(dayOfWeek: "THU", imageName: "wind.snow", temperature: 76)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.bolt.fill", temperature: 76)
                    WeatherDayView(dayOfWeek: "SAT", imageName: "snow", temperature: 76)
                    WeatherDayView(dayOfWeek: "SUN", imageName: "sunset.fill", temperature: 76)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    WeatherButtonView(title: "Change city")
                        .shadow(radius: 5)
                }
                
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    var dayOfWeek:String;
    var imageName:String;
    var temperature:Int;
    
    var body: some View {
        VStack{
            Text(self.dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Image(systemName: self.imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text(String(self.temperature) + "°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct backgroundView: View {
    
    var body: some View {
        LinearGradient(colors: [.blue, Color("lightBlue")],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
        
    }
}

struct cityTextView: View {
    var cityname:String
    
    var body: some View {
        Text(self.cityname)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct mainWeatherIcon: View {
    var imageName:String
    var temperature:Int
    
    var body: some View {
        VStack(spacing: 8){
            Image(systemName: self.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text(String(self.temperature) + "°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
