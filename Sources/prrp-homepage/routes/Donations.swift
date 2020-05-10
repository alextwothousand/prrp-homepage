func donationRouter(app: App) {
	app.router.get("/donations") { request, response, next in 
		try response.redirect("/")
		next()
	}
}