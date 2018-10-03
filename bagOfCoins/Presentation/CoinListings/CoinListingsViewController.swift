//
//  ViewController.swift
//  bagOfCoins
//
//  Created by Daniel Hakimi on 26/09/2018.
//  Copyright © 2018 Daniel Hakimi. All rights reserved.
//

import UIKit
import SnapKit
import Bond

class CoinListingsViewController: UIViewController {

    let webApi = WebApi()

    lazy var tableView = CoinListingsTableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()

        let coinService: CoinService = CoinService(webApi: webApi)

        fetchCoinData(coinService)
    }

    func setUI() {
        navigationItem.title = "Bag of Coins"
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .white

        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.top.equalTo(view)
        }

        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.coinListingsViewController = self
    }

    func fetchCoinData(_ coinService: CoinService) {
        coinService.getAllCoins(onSuccess: { thing in
            self.tableView.reloadData(contents: thing)
        }, failure: { error in
            dump(error)
        })
    }
}

class AddToBagViewController: UIViewController {

    lazy var coin = Label()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(coin)

        coin.text = "my coin"
        coin.textColor = .black

        coin.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.top.equalTo(view)
        }
    }
}
