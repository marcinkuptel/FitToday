//
//  HomePageViewBuilder.swift
//  FitToday
//
//  Created by Marcin Kuptel on 21/02/15.
//  Copyright (c) 2015 Marcin Kuptel. All rights reserved.
//

import Foundation

protocol HomePageViewBuilder
{
    func buildViewAndCoordinator() -> (UIView, HomePageCoordinator)
}