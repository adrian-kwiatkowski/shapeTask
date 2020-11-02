import UIKit

class ViewController<MainView: UIView, MainViewModel: ViewModel>: UIViewController {
    
    let mainView: MainView
    let viewModel: MainViewModel
    
    init(mainView: MainView = MainView(), viewModel: MainViewModel) {
        self.mainView = mainView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    func bindData() {}
}




