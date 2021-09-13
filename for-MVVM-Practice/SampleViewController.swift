//
//  HomeViewController.swift
//  for-MVVM-Practice
//
//  Created by Shinichiro Kudo on 2021/09/12.
//

import UIKit

final class SampleViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    private var presenter: SamplePresenterInput!
    func inject(presenter: SamplePresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetch()
    }
}

extension SampleViewController: SamplePresenterOutput {
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getNotice(notice: String) {
        print(notice)
    }
    
}

extension SampleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = presenter.item(index: indexPath.row)
        cell.textLabel?.text = item.name
        return cell
    }
}


extension SampleViewController: UITableViewDelegate {
    // didSelect
}
