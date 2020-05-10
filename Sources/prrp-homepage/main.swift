import Kitura
import KituraStencil

import SwiftKuery
import SwiftKueryMySQL

public class App {
	let port: Int = 3000
	let router = Router()

	static let poolOptions = ConnectionPoolOptions(initialCapacity: 1, maxCapacity: 5)
	static let pool = MySQLConnection.createPool(user: "root", password: "", database: "prrp_game", poolOptions: poolOptions)

	func postInit() throws {
		homeRouter(app: self)
		newsRouter(app: self)
		donationRouter(app: self)
		rosterRouter(app: self)
	}

	public func run() throws {
		try postInit()
		Kitura.addHTTPServer(onPort: port, with: router)
		router.all("/", middleware: StaticFileServer(path: "./public"))
		router.add(templateEngine: StencilTemplateEngine())
		
		print("PRRP homepage running on port", port)
		Kitura.run()
	}
}

do {
	let app = App()
	try app.run()
} catch let error {
	print(error.localizedDescription)
}