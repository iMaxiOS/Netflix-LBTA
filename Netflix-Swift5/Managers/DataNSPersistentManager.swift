//
//  DataNSPersistentManager.swift
//  Netflix-Swift5
//
//  Created by Maxim Hranchenko on 14.03.2022.
//

import Foundation
import UIKit
import CoreData

let shareDataNSPersistentManager = { DataNSPersistentManager.shared }

final class DataNSPersistentManager {
    
    enum DatabaseError: Error {
        case failedToSave
        case failedToFetch
        case failedToRemove
    }
    
    static let shared = DataNSPersistentManager()
    
    func downloadMovieWith(model: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = app.persistentContainer.viewContext
        let item = MovieItem(context: context)
        
        item.id = Int64(model.id)
        item.overview = model.overview
        item.rate = model.rate ?? 0
        item.releaseDate = model.releaseDate
        item.posterImage = model.posterImage
        item.title = model.title
        item.urlImage = model.urlImage
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToSave))
        }
    }
    
    func fetchingMovieFromDatabase(completion: @escaping (Result<[MovieItem], DatabaseError>) -> Void) {
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = app.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieItem>
        request = MovieItem.fetchRequest()
        
        do {
            let movies = try context.fetch(request)
            completion(.success(movies))
        } catch {
            completion(.failure(.failedToFetch))
        }
    }
    
    func removeMovieFromDatabase(model: MovieItem, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = app.persistentContainer.viewContext
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToRemove))
        }
    }
}
