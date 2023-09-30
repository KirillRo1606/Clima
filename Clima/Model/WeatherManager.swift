import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=59f9996770a76730834141f4795515c4&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performReqest(with: urlString)
    }
    
    func fetchWeather(cityName : String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performReqest(with: urlString)
    }
    
    func performReqest(with urlString: String) {
        // 1.Create URL
        
        if let url = URL(string: urlString) {
            
            // 2. Create URLSession
            
            let session = URLSession(configuration: .default)
            
            // 3. Give the sesson task
            
            let task = session.dataTask(with: url) { (data, responce, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            
            // 4. Strat the task
            
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
//
//            print(weather.conditionName)
//            print(weather.temperatureString)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
    

        
    
      
    
}
