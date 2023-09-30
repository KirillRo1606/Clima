import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
        
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...202, 210...212, 221, 230...232:
            return "cloud.bolt.rain"
        case 300...302, 310...314, 321:
            return "cloud,drizzle"
        case 500...504, 511, 520...522, 531:
            return "cloud.rain"
        case 600...602, 611...613, 615, 616, 620...622:
            return "cloud.snow"
        case 701, 711, 721, 731, 741, 751, 761, 762, 771, 781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
        default:
            return "questionmark"
        }
        
    }
    
}
