//
//  ContentView.swift
//  Weather App
//
//  Created by Ilmari Lehmusjärvi on 31.1.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selected = 0
    @ObservedObject var weather = CurrentWeatherViewModel()
    @State var city: String = ""
    
    var body: some View {
        
        VStack() {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            TextField("Enter A City Name", text: $city, onCommit: {
                self.weather.fetch(by: self.city)
                
            }).padding(.horizontal)
            
            CurrentWeather(weather: self.weather.current)
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
