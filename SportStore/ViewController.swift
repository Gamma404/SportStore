//
//  ViewController.swift
//  SportStore
//
//  Created by Apple on 2018/3/14.
//  Copyright © 2018年 Gamma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var totalStockLabel: UILabel!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell {
            cell.productId = indexPath.row;
            cell.nameLabel.text = product.0;
            cell.descriptionLabel.text = product.1;
            cell.stockStepper.value = Double(product.4);
            cell.stockField.text = String(product.4);

            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = product.0
            return cell
        }
    }

    var products = [
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
        ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14),
        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
        ("Corner Flags", "Give your playing field a professional touch", "Soccer", 34.95, 1),
        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4),
        ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8),
        ("Unsteady Chair", "Secretly give your opponent a disadvantage", "Chess", 29.95, 3),
        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
        ("Bling-Bling King", "Gold-plated, diamond-studded King", "Chess", 1200.0, 4)];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stockLevelDidChange(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!;
                if let cell = currentCell as? ProductTableViewCell {
                    if let id = cell.productId {

                        var newStockLevel: Int?;

                        if let stepper = sender as? UIStepper {
                            newStockLevel = Int(stepper.value);
                        } else if let textfield = sender as? UITextField {
                            if let newValue = Int(textfield.text!) {
                                newStockLevel = newValue;
                            }
                        }

                        if let level = newStockLevel {
                            products[id].4 = level;
                            cell.stockStepper.value = Double(level);
                            cell.stockField.text = String(level);
                        }
                    }
                    break;
                }
            }
            displayStockTotal();
        }
    }

    func displayStockTotal() {
        let stockTotal = products.reduce(0,
                { (total, product) -> Int in return total + product.4 });
        totalStockLabel.text = "\(stockTotal) Products in Stock";
    }
}

