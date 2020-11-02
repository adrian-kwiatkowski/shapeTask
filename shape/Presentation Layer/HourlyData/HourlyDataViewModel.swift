import RxRelay
import RxSwift

struct HourlyDataViewModel: ViewModel {
    
    private let weatherDataNetworkService: WeatherDataNetworkService
    
    let hourlyData = BehaviorRelay<[HourlyData]>(value: [])
    let isPerformingNetworkOperation = BehaviorRelay<Bool>(value: false)
    let errorRelay = BehaviorRelay<Error?>(value: nil)
    let coordinator: Coordinator
    let disposeBag = DisposeBag()
    let city: City
    
    init(coordinator: Coordinator,
         city: City,
         weatherDataNetworkService: WeatherDataNetworkService = WeatherDataNetworkService()) {
        self.coordinator = coordinator
        self.city = city
        self.weatherDataNetworkService = weatherDataNetworkService
    }
    
    func fetchData(for epochTime: Int) {
        guard !isPerformingNetworkOperation.value else { return }
        
        errorRelay.accept(nil)
        isPerformingNetworkOperation.accept(true)
        hourlyData.accept([])
        
        weatherDataNetworkService
            .fetchData(for: city,
                       time: epochTime,
                       onSuccess: { fetchedWeatherData in
                        isPerformingNetworkOperation.accept(false)
                        hourlyData.accept(fetchedWeatherData.hourly)
                       },
                       onError: { error in
                        isPerformingNetworkOperation.accept(false)
                        errorRelay.accept(error)
                       })
        
    }
}
