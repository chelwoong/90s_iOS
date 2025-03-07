//
//  FilmViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation
import RxSwift
import RxCocoa

class FilmsViewModel : ViewModelType {
    private(set) var dependency : Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    private(set) var disposeBag = DisposeBag()
 
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func getStateData(state : FilmStateType) -> [Film]{
        var array : [Film] = []
        
        output.films
            .map { $0.filter { $0.state == state }}
            .subscribe(onNext: {
                array.append(contentsOf: $0)
            })
            .dispose()
        
        return array
    }
}


extension FilmsViewModel {
    struct Dependency {
        var filmFactory = FilmFactory()
    }
    struct Input {
        
    }
    struct Output {
        var films = BehaviorRelay<[Film]>(value: FilmFactory().createDefaultData())
    }
}
