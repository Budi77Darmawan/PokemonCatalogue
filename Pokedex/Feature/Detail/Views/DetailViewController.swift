//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import UIKit
import RxSwift
import Lottie

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainSegmentedControl: CustomSegmentedControl! {
        didSet {
            mainSegmentedControl.setButtonTitles(buttonTitles: ["About", "Base Stats", "Moves"])
            mainSegmentedControl.selectorViewColor = .primaryColor
            mainSegmentedControl.selectorTextColor = .primaryColor
        }
    }
    @IBOutlet weak var containerBottomView: UIView!
    @IBOutlet weak var containerChildView: UIView!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var catchButton: UIButton!
    @IBOutlet weak var containerLoadingView: UIView!
    @IBOutlet weak var loadingView: LottieAnimationView!
    
    private lazy var aboutVC = AboutViewController()
    private lazy var baseStatsVC = BaseStatsViewController()
    private lazy var movesVC = MovesViewController()
    
    private let disposeBag = DisposeBag()
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initObservers()
        initCatchButton()
        mainSegmentedControl.delegate = self
        mainSegmentedControl.setIndex(index: 0)
    }
    
    private func initObservers() {
        viewModel.pokemon.drive(onNext: { [weak self] pokemon in
            self?.initView(pokemon)
            self?.aboutVC.pokemon = pokemon
            self?.baseStatsVC.statistic = pokemon?.stats ?? []
            self?.movesVC.moves = pokemon?.moves ?? []
        }).disposed(by: disposeBag)
        
        viewModel.isCatched.drive(onNext: { [weak self] isCatched in
            self?.updateCatchButton(isCatched)
        }).disposed(by: disposeBag)
    }
    
    private func initView(_ pokemon: PokemonModel?) {
        containerBottomView.setTopCorners(30)
        nameLabel.text = pokemon?.name?.capitalized
        tagLabel.text = pokemon?.tag
        pokemonImageView.loadImage(uri: pokemon?.imageUri,
                                   placeholder: getUIImage(named: "pokeball"))
    }
    
    private func initCatchButton() {
        catchButton.setCornersRadius(15)
        catchButton.addTarget(self, action: #selector(actionCatchButton(_:)), for: .touchUpInside)
    }
    
    private func updateCatchButton(_ isCatched: Bool) {
        if isCatched {
            catchButton.tag = 1
            catchButton.setTitle("Release", for: .normal)
            catchButton.setTitleColor(.primaryColor, for: .normal)
            catchButton.backgroundColor = .white
        } else {
            catchButton.tag = 0
            catchButton.setTitle("Catch", for: .normal)
            catchButton.setTitleColor(.white, for: .normal)
            catchButton.backgroundColor = .primaryColor
        }
        catchButton.layer.borderWidth = 1.5
        catchButton.layer.borderColor = UIColor.primaryColor.cgColor
    }
    
    @objc
    private func actionCatchButton(_ sender: UIButton) {
        if sender.tag == 0 {
            let catchPokemon = Bool.random()
            catchButton.disable()
            containerLoadingView.isHidden = false
            loadingView.play(fromProgress: 0, toProgress: 1, loopMode: .repeat(2)) { _ in
                self.catchButton.enabled()
                self.containerLoadingView.isHidden = true
                catchPokemon ? self.dialogSuccessCatch() : self.dialogFailedToCatch()
            }
        } else {
            self.dialogRelease()
        }
    }
    
    private func dialogSuccessCatch() {
        let dialogMessage = UIAlertController(title: "", message: "Success to catch it!.\nPlease give a nickname", preferredStyle: .alert)
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Type nickname"
        })
        let done = UIAlertAction(title: "Done", style: .default, handler: { _ in
            let nickName = dialogMessage.textFields?.first?.text ?? "-"
            self.viewModel.addToCollection(nickName: nickName)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        dialogMessage.addAction(done)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func dialogFailedToCatch() {
        let dialogMessage = UIAlertController(title: "", message: "Failed to catch it.\nPlease try again!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    private func dialogRelease() {
        let dialogMessage = UIAlertController(title: "", message: "Are you sure you want to release this pokemon?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.viewModel.deleteFromCollection()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        dialogMessage.addAction(yes)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }

}

extension DetailViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        removeChilds()
        switch index {
        case 0: addChildVC(aboutVC)
        case 1: addChildVC(baseStatsVC)
        case 2: addChildVC(movesVC)
        default: break
        }
    }
    
    private func removeChilds() {
        self.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
    
    private func addChildVC(_ viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        addChild(viewController)
        containerChildView.addSubview(viewController.view)
        viewController.view.frame = containerChildView.bounds
        viewController.didMove(toParent: self)
    }
}

