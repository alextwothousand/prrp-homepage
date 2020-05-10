func homeRouter(app: App) {
	app.router.get("/") { request, response, next in 
		try response.render("home.stencil", context: ["": ""])
		response.status(.OK)
		next()
	}
}