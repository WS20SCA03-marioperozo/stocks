//
//  ViewController.swift
//  stocks
//
//  Created by Mario Perozo on 7/17/20.
//  Copyright © 2020 Mario Perozo. All rights reserved.
//

//This file is ViewController.swift.
import UIKit;
import SwiftSoup;

class ViewController: UIViewController {
    var stocks: [Stock] = [Stock]();   //The array is born empty.

    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        let address: String = "https://www.advfn.com/nasdaq/nasdaq.asp?companies=A";

        guard let url: URL = URL(string: address) else {
            fatalError("Could not create URL from address \"\(address)\".");
        }

        do {
            let webPage: String = try String(contentsOf: url);
            let document: Document = try SwiftSoup.parse(webPage);
            let productElements: Elements = try document.getElementsByAttributeValue("class", "ts0");

            for product: Element in productElements {

                let titles: Elements = try product.getElementsByAttributeValue("href", "https://ih.advfn.com/stock-market/NASDAQ/a-schulman-inc-delisted-SHLM/stock-price");
                let title: Element = titles[0];
                let name: String = try title.text();
                
                let titles2: Elements = try product.getElementsByAttributeValue("href", "https://ih.advfn.com/stock-market/NASDAQ/a-schulman-inc-delisted-SHLM/stock-price");
                let title2: Element = titles2[1];
                let symbol: String = try title2.text();

                

                let stock: Stock = Stock(name: name, symbol: symbol);
                stocks.append(stock);
            }
        } catch {
            print(error);
        }

    //Print the finished array.

        for stock: Stock in stocks {
            print(stock.name);
            print(stock.symbol);
            print();
        }
    }
}
