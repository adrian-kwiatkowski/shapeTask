import Foundation

struct WeatherDataNetworkService {
    
    private let session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15
        sessionConfig.timeoutIntervalForResource = 15

        return URLSession(configuration: sessionConfig)
    }()
    
    private let apiKey = ""
    
    private func buildRequest(lat: Double, lon: Double, time: Int) -> URLRequest? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.darksky.net"
        components.path = "/forecast/\(apiKey)/\(lat),\(lon),\(time)"
        
        let queryItemToken = URLQueryItem(name: "exclude", value: "currently,flags")
        let queryItemQuery = URLQueryItem(name: "units", value: "si")
        
        components.queryItems = [queryItemToken, queryItemQuery]
        
        if let url = components.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        } else {
            return nil
        }
    }
    
    func fetchData(for city: City, time: Int, onSuccess: @escaping (WeatherDataResponse) -> ( ), onError: @escaping (NetworkError) -> () ) {
        
        guard let request = buildRequest(lat: city.lat, lon: city.lon, time: time) else {
            onError(NetworkError.general)
            return
        }
        
        session.dataTask(with: request, completionHandler: { data, response, error in
            
            if error != nil {
                onError(NetworkError.general)
                return
            }
            
            if let data = data {
                do {
                    let weatherDataResponse = try JSONDecoder().decode(WeatherDataResponse.self, from: data)
                    onSuccess(weatherDataResponse)
                } catch {
                    onError(NetworkError.general)
                }
            }
        }).resume()
    }
}
