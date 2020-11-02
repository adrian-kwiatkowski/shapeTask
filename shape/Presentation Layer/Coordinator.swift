import UIKit

class Coordinator {
    
    private let cities = [City(name: "Gdańsk", lat: 54.372158, lon: 18.638306),
                          City(name: "København", lat: 55.676098, lon: 12.568337)]
    private var selectedCity: City?
    
    let rootViewController: UISplitViewController = UISplitViewController()
    
    init() {
        let primaryViewModel = CitiesViewModel(coordinator: self, cities)
        let primaryViewController = CitiesViewController(viewModel: primaryViewModel)
        
        let primaryNavigationController = UINavigationController(rootViewController: primaryViewController)
        primaryNavigationController.navigationBar.prefersLargeTitles = true
        
        rootViewController.delegate = self
        rootViewController.preferredDisplayMode = .oneBesideSecondary
        rootViewController.view.backgroundColor = .systemBackground
        rootViewController.viewControllers = [primaryNavigationController]
    }
    
    func showWeatherData(for city: City) {
        guard city != selectedCity else { return }
        selectedCity = rootViewController.isCollapsed ? nil : city
        
        let viewModel = HourlyDataViewModel(coordinator: self, city: city)
        let viewController = UINavigationController(rootViewController: HourlyDataViewController(viewModel: viewModel))
        
        rootViewController.showDetailViewController(viewController, sender: city)
    }
}

extension Coordinator: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
