//
//  MyCollectionViewController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import UIKit
import RxSwift

class MyCollectionViewController: UIViewController {

    @IBOutlet weak var pokemonsTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    var viewModel: MyCollectionViewModel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getCollection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Collection"
        initObservers()
        pokemonsTableView.register(PokemonTableViewCell.nib(), forCellReuseIdentifier: PokemonTableViewCell.identifier)
        pokemonsTableView.dataSource = self
        pokemonsTableView.delegate = self
    }
    
    private func initObservers() {
        viewModel.pokemons.drive(onNext: { [weak self] _ in
            self?.pokemonsTableView.reloadData()
        }).disposed(by: disposeBag)
    }

}

extension MyCollectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as? PokemonTableViewCell else { return UITableViewCell() }
        cell.configure(viewModel.pokemon(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let viewModel = DetailViewModel(useCase: Injection().provideDetailUeCase(),
                                        pokemon: viewModel.pokemon(at: indexPath.row))
        vc.viewModel = viewModel
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

