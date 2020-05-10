import SwiftKuery

/*
rank
flag_headdev
flag_developer
flag_owner
flag_legalfac
flag_illegalfac
*/

class StaffModel: Table {
	let tableName = "staff"
	let id = Column("id", Int32.self, primaryKey: true)

	let forumname = Column("forumname", String.self)
	let rank = Column("rank", Int32.self)

	let flag_headdev = Column("flag_headdev", Int32.self)
	let flag_developer = Column("flag_developer", Int32.self)

	let flag_owner = Column("flag_owner", Int32.self)
	let flag_legalfac = Column("flag_legalfac", Int32.self)

	let flag_illegalfac = Column("flag_illegalfac", Int32.self)
}

struct Staff: Codable {
	let id: Int
	let forumname: String

	let rank: Int
	let flag_headdev: Int

	let flag_developer: Int
	let flag_owner: Int

	let flag_legalfac: Int
	let flag_illegalfac: Int
}