//
//  IndexCVC.swift
//  Halcyon6Index
//
//  Created by Louis Tur on 9/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import PureLayout

class IndexCVC: UICollectionViewController {
  private let reuseIdentifier: String = AppKeys.IndexCVCCellIdentifier
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView?.setCollectionViewLayout(self.flowLayout, animated: false)

    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    // Configure the cell
    let testView: UIView = UIView()
    testView.backgroundColor = UIColor.red
    cell.contentView.addSubview(testView)
//    testView.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: AppLayout.MinimumCellSize))
    testView.autoPinEdgesToSuperviewEdges()
//    testView.autoCenterInSuperview()
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
   return true
   }
   */
  
  /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
   return false
   }
   
   override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
   
   }
   */
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Inits
  internal lazy var flowLayout: UICollectionViewFlowLayout = {
    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - (AppLayout.StandardMargin * 2), height: AppLayout.MinimumCellSize)
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = AppLayout.StandardMargin
    flowLayout.minimumInteritemSpacing = AppLayout.StandardMargin
    flowLayout.sectionInset = UIEdgeInsets(top: AppLayout.StandardMargin, left: AppLayout.StandardMargin, bottom: AppLayout.StandardMargin, right: AppLayout.StandardMargin)
    return flowLayout
  }()
  
}
