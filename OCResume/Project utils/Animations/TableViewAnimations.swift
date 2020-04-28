//
//  TableViewAnimations.swift
//  OCResume
//
//  Created by Olivier Conan on 21/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import UIKit

typealias SingleCellAnimation = (SingleTableViewCell, IndexPath, UITableView) -> Void

final class SingleCellAnimator {

    private var hasAnimatedAllCells = false
    private let animation: SingleCellAnimation

    init(animation: @escaping SingleCellAnimation) {
        self.animation = animation
    }

    func animate(cell: SingleTableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else { return }

        animation(cell, indexPath, tableView)
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }

}

enum SingleCellAnimationFactory {

    static func makePulseAnimation(duration: TimeInterval, delayFactor: Double, color: CGColor) -> SingleCellAnimation {
        return { cell, indexPath, tableView in
            DispatchQueue.main.asyncAfter(deadline: .now() + (delayFactor * Double(indexPath.row))) {
                cell.contentView.createPulsator(point: cell.center, width: cell.frame.width / 2, color: cell.color.cgColor) {
                    cell.animate()
                }
            }
        }
    }

    static func makeFadeAnimation(duration: TimeInterval, delayFactor: Double) -> SingleCellAnimation {
        return { cell, indexPath, _ in
            cell.alpha = 0.0
            UIView.animate( withDuration: duration, delay: delayFactor * Double(indexPath.row), animations: {
                cell.alpha = 1.0
            })
        }
    }

    static func makeMoveUpWithBounce(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> SingleCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0.0, y: rowHeight)
            UIView.animate(withDuration: duration, delay: delayFactor * Double(indexPath.row), usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            })
        }
    }

    static func makeMoveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> SingleCellAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0.0, y: rowHeight / 2)
            cell.alpha = 0.0
            UIView.animate(withDuration: duration, delay: delayFactor * Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
                cell.alpha = 1.0
            })
        }
    }

    static func makeSlideIn(duration: TimeInterval, delayFactor: Double) -> SingleCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0.0)
            UIView.animate(withDuration: duration, delay: delayFactor * Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            })
        }
    }

}

extension UITableView {

    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else { return false }

        return lastIndexPath == indexPath
    }

}
