//
//  CustomErrors.swift
//  StudyPlayGrounds
//
//  Created by joao camargo on 30/09/21.
//

import Foundation

enum CustomErrors: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid Response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was ano error favoriting this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user."
}
