//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import UIKit

class MovesViewController: UIViewController {

    @IBOutlet weak var movesTableView: UITableView!
    private let cellReuseIdentifier = "Cell"
    
    var moves = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        movesTableView.dataSource = self
    }

}

extension MovesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else { return UITableViewCell() }
        cell.textLabel?.text = self.moves[indexPath.row].capitalized
        cell.textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return cell
    }
}
