import KituraContracts
import LoggerAPI

import Foundation
import SwiftKuery

func rosterRouter(app: App) {
	app.router.get("/roster") { request, response, next in
		App.pool.getConnection() { connection, error in
			guard let connection = connection else {
				Log.error("Error connecting: \(error?.localizedDescription ?? "Unknown Error")")
				let _ = response.send(status: .internalServerError)
				return next()
			}

			let selectQuery = Select(from: App.Staff)

			connection.execute(query: selectQuery) { selectResult in
				guard let resultSet = selectResult.asResultSet else {
					Log.error("Error connecting: \(selectResult.asError?.localizedDescription ?? "Unknown Error")")
					let _ = response.send(status: .internalServerError)
					return next()
				}

				var staff = [Staff]()

				resultSet.forEach() { row, error in
					guard let row = row else {
						if let error = error {
							Log.error("Error getting row: \(error)")
							let _ = response.send(status: .internalServerError)
							return next()
						} else {
							// All rows have been processed
							let context: [String: [Staff]] = [
								"staff": staff
							]

							print("context:", context)

							do { 
								try response.render("roster.stencil", context: context)
								response.status(.OK)
							} catch {
								print("Render error: \(error)")
								response.status(.internalServerError)
							}
							
							return next()
						}
					}

					print("Row:", row)

					guard 
						let idInt32 = row[0] as? Int32,
						let forumname = row[1] as? String,
						let rank = row[2] as? Int32,
						let flag_headdev = row[3] as? Int32,
						let flag_developer = row[4] as? Int32,
						let flag_owner = row[5] as? Int32,
						let flag_legalfac = row[6] as? Int32,
						let flag_illegalfac = row[7] as? Int32
					else {
						Log.error("Unable to decode staff")
						print("Unable to decode staff")
						let _ = response.send(status: .internalServerError)
						return next()
					}

					staff.append(Staff(
						id: Int(idInt32), 
						forumname: forumname, 
						rank: Int(rank), 
						flag_headdev: Int(flag_headdev),
						flag_developer: Int(flag_developer),
						flag_owner: Int(flag_owner),
						flag_legalfac: Int(flag_legalfac),
						flag_illegalfac: Int(flag_illegalfac)
					))
				}
			}
		}
	}
}

extension App {	
	static let Staff = StaffModel()
}