//
//  StatisticTableViewCell.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    
    public static let identifier = "StatisticTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "StatisticTableViewCell",
                     bundle: nil)
    }

    @IBOutlet weak var barStatisticProgressView: UIProgressView!
    @IBOutlet weak var scoreStatisticLabel: UILabel!
    @IBOutlet weak var titleStatisticLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ statistic: Stat, _ baseStat: Int?) {
        titleStatisticLabel.text = statistic.stat?.name?.capitalized
        scoreStatisticLabel.text = "\(statistic.baseStat ?? 0)"
        
        let maxStat = (baseStat ?? 0) + 20
        let resultStat = Float(statistic.baseStat ?? 0) / Float(maxStat)
        barStatisticProgressView.progress = resultStat
        barStatisticProgressView.tintColor = resultStat > 0.6 ? .green : .red
    }
    
}
