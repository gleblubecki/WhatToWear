import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            Color("BgColor")
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Text("WhatToWear")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("titleColor"))
                    .padding()
                
                Spacer()

                VStack {
                    if Int(viewModel.temperature) ?? 0 > 20 {
                        Text("Summer is here,")
                            .foregroundColor(.white)
                            .font(.system(size: 23))
                            .fontWeight(.semibold)
                        Text("put on shorts and a T-shirt!")
                            .foregroundColor(.white)
                            .font(.system(size: 23))
                            .fontWeight(.semibold)
                    }
                    if Int(viewModel.temperature) ?? 0 < 17 && Int(viewModel.temperature) ?? 0 > 7  {
                            Text("Better to wear a sweater")
                                .foregroundColor(.white)
                                .font(.system(size: 23))
                                .fontWeight(.semibold)
                    }
                    if Int(viewModel.temperature) ?? 0 < 7 && Int(viewModel.temperature) ?? 0 > -10 {
                        Text("Take your down jacket with you")
                            .foregroundColor(.white)
                            .font(.system(size: 23))
                            .fontWeight(.semibold)
                    }
                    if Int(viewModel.temperature) ?? 0 < -10 {
                        Text("It's time to get the winter jacket")
                            .foregroundColor(.white)
                            .font(.system(size: 23))
                            .fontWeight(.semibold)
                    }
                    if viewModel.weatherIcon == "🌧" || viewModel.weatherIcon == "🌧" || viewModel.weatherIcon == "🌧" {
                        Text("And you'd better take an umbrella")
                            .foregroundColor(.white)
                            .font(.system(size: 23))
                            .fontWeight(.semibold)
                    }
                }
                .onAppear(perform: viewModel.refresh)
                .frame(width: 350, height: 50)
                
                VStack(spacing: 10) {
                    Text(viewModel.weatherIcon)
                        .font(.system(size: 90))
                    
                    Text(viewModel.weatherDescription)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Text(viewModel.cityName)
                        .font(.system(size: 30))
                        .foregroundColor(Color("titleColor"))
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("Now ")
                            .foregroundColor(.white)
                            .font(.system(size: 28))
                        Text("\(viewModel.temperature)")
                            .foregroundColor(Color("titleColor"))
                            .font(.system(size: 28))
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("Feels Like ")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                        Text("\(viewModel.feelsLike)")
                            .font(.system(size: 28))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("titleColor"))
                    }
                    
                    HStack {
                        Text("Wind Speed ")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                        Text("\(viewModel.windSpeed)")
                            .font(.system(size: 28))
                            .foregroundColor(Color("titleColor"))
                            .fontWeight(.semibold)
                }
                }
                .onAppear(perform: viewModel.refresh)
                .frame(width: 300, height: 350)
                .padding(.vertical, 12)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Spacer()
                
                Button("Refresh", action: viewModel.refresh)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 40)
                    .padding(.vertical, 10)
                    .background(Color("titleColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                Spacer()
                Spacer()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
