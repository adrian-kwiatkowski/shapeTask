import RxSwift
import RxRelay

struct CitiesViewModel: ViewModel {
    
    let disposeBag = DisposeBag()
    let coordinator: Coordinator
    let cities: [City]
    
    init(coordinator: Coordinator, _ cities: [City]) {
        self.coordinator = coordinator
        self.cities = cities
    }
    
    func cityTapped(_ city: City) {
        coordinator.showWeatherData(for: city)
    }
}
