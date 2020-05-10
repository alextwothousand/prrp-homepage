import KituraContracts
import LoggerAPI

import Foundation
import SwiftKuery

func newsRouter(app: App) {
	app.router.get("/news") { request, response, next in
		App.pool.getConnection() { connection, error in
			guard let connection = connection else {
				Log.error("Error connecting: \(error?.localizedDescription ?? "Unknown Error")")
				let _ = response.send(status: .internalServerError)
				return next()
			}

			let selectQuery = Select(from: App.News)

			connection.execute(query: selectQuery) { selectResult in
				guard let resultSet = selectResult.asResultSet else {
					Log.error("Error connecting: \(selectResult.asError?.localizedDescription ?? "Unknown Error")")
					let _ = response.send(status: .internalServerError)
					return next()
				}

				var news = [News]()

				resultSet.forEach() { row, error in
					guard let row = row else {
						if let error = error {
							Log.error("Error getting row: \(error)")
							let _ = response.send(status: .internalServerError)
							return next()
						} else {
							// All rows have been processed
							let context: [String: [News]] = [
								"articles": news
							]

							do { 
								try response.render("news.stencil", context: context)
								response.status(.OK)
							} catch {
								print("Render error: \(error)")
								response.status(.internalServerError)
							}
							
							return next()
						}
					}

					guard 
						let idInt32 = row[0] as? Int32,
						let headline = row[1] as? String,
						let author = row[2] as? String,
						let date = row[3] as? String,
						let text = row[4] as? String
					else {
						Log.error("Unable to decode news")
						print("Unable to decode news")
						let _ = response.send(status: .internalServerError)
						return next()
					}

					news.append(News(id: Int(idInt32), headline: headline, author: author, text: text, date: date))
				}
			}
		}
	}
}

extension App {	
	static let News = NewsModel()
}