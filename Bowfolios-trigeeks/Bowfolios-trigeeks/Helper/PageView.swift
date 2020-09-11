//
//  PageView.swift
//  Bowfolios-trigeeks
//
//  Created by weirong he on 9/10/20.
//  Copyright © 2020 trigeeks. All rights reserved.
//

import SwiftUI
import UIKit

struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    @Binding var currentPage: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [controllers[currentPage]], direction: .forward, animated: true)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController

        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return nil
            }
            return parent.controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                return nil
            }
            return parent.controllers[index + 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController)
            {
                parent.currentPage = index
            }
        }
    }
}


struct PageView<Page: View>: View, Equatable {
    static func == (lhs: PageView<Page>, rhs: PageView<Page>) -> Bool {
        return true
    }
    
    var viewControllers: [UIHostingController<Page>]
    @Binding var currentPage: Int

    init(_ views: [Page], currentPage: Binding<Int>) {
        self._currentPage = currentPage
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        PageViewController(controllers: viewControllers, currentPage: $currentPage)
    }
}

#if DEBUG
struct PageView_Previews: PreviewProvider {
    @State static var page = 0
    static var previews: some View {
        PageView([Text("Hello")], currentPage: $page)
    }
}
#endif

#if DEBUG
struct PageViewController_Previews: PreviewProvider {
    @State static var currentPage = 0

    static var previews: some View {
        PageViewController(controllers: [], currentPage: $currentPage)
    }
}
#endif
