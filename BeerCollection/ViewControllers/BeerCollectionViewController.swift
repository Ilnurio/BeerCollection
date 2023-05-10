//
//  ViewController.swift
//  BeerCollection
//
//  Created by Ilnur on 10.05.2023.
//

import UIKit

class BeerCollectionViewController: UIViewController {
    
    private var beers: [Beer] = []
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var taglineLabel: UILabel!
    @IBOutlet var abvLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBeerCollection()
        configure()
        // Do any additional setup after loading the view.
    }

 // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let beerCollectionVC = segue.destination as? DescriptionViewController else { return }
//        beerCollectionVC.
//    }
}

 // MARK: - NetWorking
extension BeerCollectionViewController {
    func fetchBeerCollection() {
        let baseUrl = URL(string: "https://api.punkapi.com/v2/beers")!
        URLSession.shared.dataTask(with: baseUrl) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self?.beers = try decoder.decode([Beer].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

 // MARK: - ConfigureLabels
extension BeerCollectionViewController {
    private func configure() {
        for beer in beers {
            nameLabel.text = "Наименование: \(beer.name)"
            taglineLabel.text = beer.tagline
            abvLabel.text = "Градус: \(beer.abv)"
            
            DispatchQueue.global().async { [weak self] in
                guard let imageData = try? Data(contentsOf: beer.image_url) else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}

