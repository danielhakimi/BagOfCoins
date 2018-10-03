//
//  CoinListingsTableView.swift
//  bagOfCoins
//
//  Created by Daniel Hakimi on 02/10/2018.
//  Copyright © 2018 Daniel Hakimi. All rights reserved.
//

import UIKit
import Bond

class CoinListingsTableView: UITableView {

    var data = MutableObservableArray<Coin>([])
    let cellIdentifier = "CoinCell"
    let sectionFont = UIFont(name: "Helvetica Neue", size: 17)
    weak var coinListingsViewController: CoinListingsViewController?

    override init(frame: CGRect = .zero, style: UITableViewStyle = .plain) {
        super.init(frame: frame, style: style)

        backgroundColor = UIColor(hexString: "#00140c")

        delegate = self

        register(CoinCell.self, forCellReuseIdentifier: cellIdentifier)

        sectionHeaderHeight = UITableViewAutomaticDimension
        estimatedSectionHeaderHeight = 40

        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = 44

        bindData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindData() {
        data.bind(to: self, animated: true) { dataSource, indexPath, tableView in
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? CoinCell
            else { return UITableViewCell() }

            let coin = dataSource[indexPath.row]

            cell.setUIFrom(coin: coin)
            
            return cell
        }
    }

    func reloadData(contents: [Coin]) {
        self.data.removeAll()
        self.data.insert(contentsOf: contents, at: 0)
    }
}

extension CoinListingsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddToBagViewController()
        DispatchQueue.main.async {
            self.coinListingsViewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(hexString: "#4d5e57")

        let coinTitle = UILabel()
        coinTitle.text = "Coin"
        coinTitle.font = sectionFont
        coinTitle.textColor = .white
        containerView.addSubview(coinTitle)

        let holdings = UILabel()
        holdings.text = "Holdings"
        holdings.textColor = .white
        holdings.font = sectionFont
        containerView.addSubview(holdings)

        let price = UILabel()
        price.text = "Price"
        price.font = sectionFont
        price.textColor = .white
        containerView.addSubview(price)

        coinTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        holdings.snp.makeConstraints { make in
            make.leading.equalTo(coinTitle.snp.trailing).offset(64)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        price.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        return containerView
    }

}
