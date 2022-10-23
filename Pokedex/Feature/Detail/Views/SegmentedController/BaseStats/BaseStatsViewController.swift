//
//  BaseStatsViewController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import UIKit

class BaseStatsViewController: UIViewController {

    @IBOutlet weak var statsTableView: UITableView!
    
    var statistic = [Stat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statsTableView.register(StatisticTableViewCell.nib(), forCellReuseIdentifier: StatisticTableViewCell.identifier)
        statsTableView.dataSource = self
    }
    
}

extension BaseStatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statistic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticTableViewCell.identifier) as? StatisticTableViewCell else { return UITableViewCell() }
        let baseStat = statistic.map { $0.baseStat ?? 0 }.sorted().last ?? 0
        cell.configure(statistic[indexPath.row], baseStat)
        return cell
    }
}
