import RxSwift

protocol ViewModel {
    
    var disposeBag: DisposeBag { get }
    var coordinator: Coordinator { get }
}
