//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import UIKit
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
    
    var pokemon: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initCatchButton()
        mainSegmentedControl.delegate = self
        mainSegmentedControl.setIndex(index: 0)
        
        aboutVC.pokemon = pokemon
        baseStatsVC.statistic = pokemon?.stats ?? []
        movesVC.moves = pokemon?.moves ?? []
    }
    
    private func initView() {
        containerBottomView.setTopCorners(30)
        nameLabel.text = pokemon?.name?.capitalized
        tagLabel.text = pokemon?.tag
        pokemonImageView.loadImage(uri: pokemon?.imageUri,
                                   placeholder: getUIImage(named: "pokeball"))
    }
    
    private func initCatchButton() {
        catchButton.setCornersRadius(15)
        catchButton.addTarget(self, action: #selector(actionCatchButton), for: .touchUpInside)
    }
    
    @objc
    private func actionCatchButton() {
        let catchPokemon = Bool.random()
        catchButton.disable()
        containerLoadingView.isHidden = false
        loadingView.play(fromProgress: 0, toProgress: 1, loopMode: .repeat(2)) { _ in
            self.catchButton.enabled()
            self.containerLoadingView.isHidden = true
            catchPokemon ? self.dialogSuccessCatch() : self.dialogFailedToCatch()
        }
    }
    
    private func dialogSuccessCatch() {
        let dialogMessage = UIAlertController(title: "", message: "Success to catch it!.\nPlease give a nickname", preferredStyle: .alert)
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Type nickname"
        })
        let done = UIAlertAction(title: "Done", style: .default, handler: { _ in
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

