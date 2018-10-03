//
//  CoinCell.swift
//  bagOfCoins
//
//  Created by Daniel Hakimi on 02/10/2018.
//  Copyright © 2018 Daniel Hakimi. All rights reserved.
//

import Foundation
import UIKit

class CoinCell: UITableViewCell {

    lazy var containerView = UIView()
    lazy var coinLabel = Label()
    lazy var rank = Label()
    lazy var price = Label()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        layoutMargins = UIEdgeInsets.zero;
        preservesSuperviewLayoutMargins = false;

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        containerView.backgroundColor = .clear

        contentView.addSubview(containerView)
        containerView.addSubview(coinLabel)
        containerView.addSubview(rank)
        containerView.addSubview(price)

        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }

        coinLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        rank.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.centerX)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }

        price.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }

    func setUIFrom(coin: Coin) {
        coinLabel.text = coin.symbol
        rank.text = String(coin.cmcRank)
        price.text = coin.quote["USD"]!.formattedPrice        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        coinLabel.text = ""
        rank.text = ""
    }
}

class Label: UILabel {

    private let defaultFont = UIFont(name: "HelveticaNeue-Bold", size: 24)

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        font = defaultFont
        textColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
