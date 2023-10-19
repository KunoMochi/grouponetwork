// controllers/profiles.js
const mssql = require('mssql');

exports.findUser = (req, res, next) => {
	const db = req.app.locals.db;
	const ps = new mssql.PreparedStatement(db);

	ps.input('userid', mssql.VarChar);
	ps.prepare('EXECUTE FindUser @userid', (err) => {
		if (err) {
			return res.status(500).json({
				error: err
			});
		}

		ps.execute({
			userid: req.params.id
		  }, (err, result) => {
			if (err) {
				console.error(err)
				return res.status(500).json({ error: err })
			}
			const user = result.recordset[0]

			ps.unprepare((err) => {
				if (err) {
				  return res.status(500).json({
					error: err
				  })
				}
			  })
			
			if(user) {
				res.status(200).json(user);
			} else {
				return res.status(401).json({
					error: new Error('User not found!')
				});
			}
		})
	})
}