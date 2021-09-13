//
//  HomePresenter.swift
//  for-MVVM-Practice
//
//  Created by Shinichiro Kudo on 2021/09/12.
//

import Foundation

// 入力
protocol SamplePresenterInput: AnyObject {
    var numberOfItems: Int { get }
    func item(index: Int) -> User
    func fetch()
}
// 出力
protocol SamplePresenterOutput: AnyObject {
    func update()
    func getNotice(notice: String)
}

final class SamplePresenter {

    private weak var output: SamplePresenterOutput?
    // ↓データはここで保持
    private var items: [User] = []

    init(output: SamplePresenterOutput) {
        self.output = output
    }
}

// PresenterはInputプロトコルに準拠し、入力処理を受け付ける
extension SamplePresenter: SamplePresenterInput {

    var numberOfItems: Int {
        return items.count
    }
    
    func item(index: Int) -> User {
        return items[index]
    }
    
    func fetch() {
        Webservice.shared.get { [weak self] result in
            switch result {
            case .success(let users):
                self?.items = users
                self?.output?.update()
            case .failure(let error):
                self?.output?.getNotice(notice: error.localizedDescription)
            }
        }
    }
}
