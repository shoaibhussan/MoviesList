//
//  SeatSelectionViewController.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 16/07/2022.
//


import UIKit

class SeatSelectionViewController: UIViewController {

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    @IBOutlet weak var subTittleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var hallCollectionView: UICollectionView!
    @IBOutlet weak var seatSelectBtn: UIButton!
    
    //************************************************//
    // MARK:- Creating properties
    //************************************************//
    
    // Mark: Static datasources are used since this was UI only requirement and had no api to be implemented.
    let dateArr: [String] = ["5 Mar", "6 Mar", "7 Mar", "8 Mar", "9 Mar", "10 Mar"]
    let seatsArr: [Seats_Codable] = [
        Seats_Codable(hall: "Cinetech + hall 1", time: "12:30", duration: "From 50$ or 2500 bonus"),
        Seats_Codable(hall: "Cinetech + hall 2", time: "13:30", duration: "From 60$ or 3000 bonus"),
        Seats_Codable(hall: "Cinetech + hall 3", time: "14:30", duration: "From 80$ or 2700 bonus")
    ]
    
    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.seatSelectBtn.layer.cornerRadius = 12.0
        self.setupViews()
    }
    
    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
    
    private func setupViews(){
        self.dateCollectionView.delegate = self
        self.dateCollectionView.dataSource = self
        self.dateCollectionView.register(UINib(nibName: SelectSeatDateCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SelectSeatDateCollectionViewCell.reuseIdentifier)
        if let layout = self.dateCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 80.0, height: self.dateCollectionView.frame.height)
            layout.minimumInteritemSpacing = 10.0
            layout.sectionInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        }
        
        self.hallCollectionView.delegate = self
        self.hallCollectionView.dataSource = self
        self.hallCollectionView.register(UINib(nibName: SelectHallCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SelectHallCollectionViewCell.reuseIdentifier)
        if let layout = self.hallCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 249.0, height: self.hallCollectionView.frame.height)
            layout.minimumInteritemSpacing = 10.0
            layout.sectionInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        }
    }
    
    //************************************************//

    @IBAction func didClickBackBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    //************************************************//

    @IBAction func didClickSelectBtn(_ sender: Any){
        let vc = SeatSelectDeatailsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //************************************************//

}

//************************************************//
// MARK:- Collection view delegate and datasource
//************************************************//

extension SeatSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //************************************************//
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //************************************************//
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case self.dateCollectionView:
            return self.dateArr.count
        default:
            return self.seatsArr.count
        }
    }
        
    //************************************************//
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case self.dateCollectionView:
            let date = self.dateArr[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectSeatDateCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectSeatDateCollectionViewCell
            cell.dateBtn.setTitle(date, for: .normal)
            return cell
        default:
            let data = self.seatsArr[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectHallCollectionViewCell.reuseIdentifier, for: indexPath) as! SelectHallCollectionViewCell
            cell.setupUI(seat: data)
            return cell
        }
    }
    
    //************************************************//
}
