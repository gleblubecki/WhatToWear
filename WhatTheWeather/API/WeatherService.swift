// 1* NSObject — корневой класс большинства иерархий классов Objective-C, от которого подклассы наследуют базовый интерфейс к системе выполнения и способность вести себя как объекты Objective-C

// 2* Получаем данные о геолокации

// 3* Отправляем запрос на сайт с API, используя координаты, чтобы получить необходимые данные

// 4* В этом методе мы попытаемся получить первое местоположение в списке CLLocation, и если нам удастся его получить, мы отправим запрос, используя метод makeDataRequest

// 5* Если что-то пойдет не так, то будет вызван этот метод, который напечатает ошибку

import CoreLocation
import Foundation

class WeatherService: NSObject { // 1*
    
    private let locationManager = CLLocationManager() // Получение местонахождения пользователя для определения города
    private let API_KEY = "e36b9ee6c1a96a03925205361636c72c" // Ключ для получения всех данных
    private var completionHandler: ((Weather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) { // 2*
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) { // 3*
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
             .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
         guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error  == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

extension WeatherService: CLLocationManagerDelegate { // Создаем дополнение для класса WeatherService
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // 4*
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { // 5*
        print("Что-то пошло не так: \(error.localizedDescription)")
    }
}

struct APIResponse: Decodable { // Собираем все в одну структуру
    let name: String
    let main: ApiMain
    let wind: ApiWind
    let weather: [APIWeather]
}

struct ApiMain: Decodable { // Получаем температутру
    let temp: Double
    let feels_like: Double
}

struct ApiWind: Decodable { // Получаем данные о ветре
    let speed: Double
}

struct APIWeather: Decodable { // Получаем данные о том, какая погода (солнечная, облачная и тд)
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
