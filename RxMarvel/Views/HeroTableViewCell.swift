//
// Created by Rafael Ferreira on 3/13/16.
// Copyright (c) 2016 Swift Yah. All rights reserved.
//

import RxSwift

class HeroTableViewCell: RxTableViewCell<HeroTableViewModel> {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroLabel: UILabel!
    
    override var rx_viewModel: AnyObserver<HeroTableViewModel> {
        return AnyObserver { [weak self] event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch event {
            case .Next(let value):
                if let strong = self {
                    strong.heroLabel.rx_text <~ value.title
                    strong.heroImageView.rx_imageURL <~ value.thumbnailPath
                }
            default:
                break
            }
        }
    }
    
}

extension HeroTableViewCell: NibProvidable { }

extension HeroTableViewCell: ReusableView { }
