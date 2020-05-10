import SwiftKuery

class NewsModel: Table {
	let tableName = "news"
	let id = Column("id", Int32.self, primaryKey: true)
	let headline = Column("headline", String.self)
	let author = Column("author", String.self)
	let text = Column("text", String.self)
	let date = Column("date", String.self)
}

struct News: Codable {
    let id: Int
	let headline: String
    let author: String
    let text: String
    let date: String
}