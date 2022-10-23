//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 11/10/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchView()
        initCollectionView()
        initObservers()
    }
    
    private func initSearchView() {
        searchTextField.delegate = self
        searchTextField.rx.text
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { value in
                    self.viewModel.searchPokemons(with: value)
                }
            ).disposed(by: disposeBag)
    }

    private func initCollectionView() {
        pokemonCollectionView.register(PokemonGridCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonGridCollectionViewCell.identifier)
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.refreshControl = UIRefreshControl()
        pokemonCollectionView.refreshControl?.beginRefreshing()
        pokemonCollectionView.refreshControl?.addTarget(self, action: #selector(refreshCollectionView), for: .valueChanged)
    }
    
    @objc
    private func refreshCollectionView() {
        self.viewModel.refresh()
    }
    
    private func initObservers() {
        viewModel.pokemons.drive(onNext: { [weak self] pokemon in
            if pokemon.isEmpty {
                self?.pokemonCollectionView.setBackground(imageName: "img_empty_items", messageImage: "Tidak ditemukan")
            } else {
                self?.pokemonCollectionView.clearBackground()
            }
            self?.pokemonCollectionView.reloadData()
            self?.pokemonCollectionView.refreshControl?.endRefreshing()
        }).disposed(by: disposeBag)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemonsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonGridCollectionViewCell.identifier, for: indexPath) as? PokemonGridCollectionViewCell else { return UICollectionViewCell() }
        let pokemon = viewModel.pokemon(at: indexPath.row)
        cell.configure(pokemon)
        viewModel.getNextPage(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 8.0, bottom: 5.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 2 - 5
        return CGSize(width: widthPerItem - 8, height: widthPerItem * 0.6)
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
