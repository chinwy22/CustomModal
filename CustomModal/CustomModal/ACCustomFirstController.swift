//
//  ACCustomFirstController.swift
//  CustomModal
//
//  Created by AmberChin on 2017/7/24.
//  Copyright © 2017年 AmberChin. All rights reserved.
//

import UIKit

class ACCustomFirstController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    lazy var things: [ACModel] = {
        let arr = [
            ACModel(title
                : "Thing 1", image: UIImage(named: "thing01.jpg"), overview: "Drumstick cow beef fatback turkey boudin. Meatball leberkas boudin hamburger pork belly fatback."),
            ACModel(title: "Thing 2", image: UIImage(named: "thing02.jpg"), overview: "Shank pastrami sirloin, sausage prosciutto spare ribs kielbasa tri-tip doner."),
            ACModel(title: "Thing 3", image: UIImage(named: "thing03.jpg"), overview: "Frankfurter cow filet mignon short loin ham hock salami meatloaf biltong andouille bresaola prosciutto."),
            ACModel(title: "Thing 4", image: UIImage(named: "thing04.jpg"), overview: "Pastrami sausage turkey shank shankle corned beef."),
            ACModel(title: "Thing 5", image: UIImage(named: "thing05.jpg"), overview: "Tri-tip short loin pork belly, pastrami biltong ball tip ham hock. Shoulder ribeye turducken shankle.")
        ]
        return arr
    }()

    
    var selectedIndex: IndexPath?
    
    var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 155, height: 183)
        
        collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        collection.register(ACCollectionCell.self, forCellWithReuseIdentifier: "ACCollectionCell")
        self.view.addSubview(collection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let _ = self.navigationController?.delegate {
            self.navigationController?.delegate = nil
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = collection.indexPathsForSelectedItems?.last
        let secondVc = segue.destination as! ACCustomSecondController
        secondVc.thing = things[(selectedIndexPath?.item)!]
    }
    
    // navigation
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC is ACCustomSecondController {
            return ACCustomPushAnimation()
        }
        return nil
    }
    
    // collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return things.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "ACCollectionCell", for: indexPath) as! ACCollectionCell
        cell.thing = things[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondVc = ACCustomSecondController()
        selectedIndex = indexPath
        secondVc.thing = things[indexPath.item]
        secondVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secondVc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

