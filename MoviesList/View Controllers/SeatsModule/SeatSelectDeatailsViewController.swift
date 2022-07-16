//
//  SeatSelectDeatailsViewController.swift
//  MoviesList
//
//  Created by Shoaib Hassan on 16/07/2022.
//


import UIKit

class SeatSelectDeatailsViewController: UIViewController {

    //************************************************//
    // MARK:- Defining outlets
    //************************************************//
    
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var amountPayableView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    //************************************************//
    // MARK:- View life Cycle
    //************************************************//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.paymentBtn.layer.cornerRadius = 12.0
        self.amountPayableView.layer.cornerRadius = 12.0
    }

    //************************************************//
    // MARK:- Custom methods, actions and selectors.
    //************************************************//
    
    @IBAction func didClickBackBtn(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    //************************************************//
    
    @IBAction func didClickPayBtn(_ sender: Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //************************************************//
}
