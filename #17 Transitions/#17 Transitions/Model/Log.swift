//
//  Log.swift
//  #17 Transitions
//
//  Created by Владимир Рубис on 13.10.2022.
//

/// Для логов (по необходимости можно добавить и остальные)
enum Log: String {
    case didLoad = " module did load"
    case willAppear = " module will appear"
    case didAppear = " module did appear"
    case destroy = " module destroy"
    case deinitModule = " module deinit"
}
