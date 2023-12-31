// controllers/user.js
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const mssql = require('mssql');

exports.signup = (req, res, next) => {
	const db = req.app.locals.db;
	const ps = new mssql.PreparedStatement(db);

	bcrypt.hash(req.body.password, 10).then(
		(hash) => {
			ps.input('username', mssql.VarChar);
			ps.input('password', mssql.VarChar);
			ps.prepare('EXECUTE SignUp @username, @password', (err) => {
				if (err) {
					console.error(err)
					return res.status(500).json({
						error: err
					});
				}
				
				ps.execute({
					username: req.body.username,
					password: hash
				}, (err, result) => {
					if (err) {
						console.error(err)
						return res.status(500).json({
							error: err
						});
					}
					const user = result.recordset[0]

					ps.unprepare((err) => {
						if (err) {
						  return res.status(500).json({
							error: err
						  })
						}
					  })

					const token = jwt.sign(
						{ userId: user.UserID },
						'RANDOM_TOKEN_SECRET',
						{ expiresIn: '24h' });
					res.status(200).json({
						userId: user.UserID,
						token: token
					});
				})
			})
		}).catch((err) => {
				res.status(500).json({
					error: err
				});
			}
		);
};

exports.login = (req, res, next) => {
	const db = req.app.locals.db;
	const ps = new mssql.PreparedStatement(db);

	ps.input('username', mssql.VarChar);
	ps.prepare('EXECUTE QueryUser @username', (err) => {
		if (err) {
			return res.status(500).json({
				error: err
			});
		}

		ps.execute({
			username: req.body.username
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
				bcrypt.compare(req.body.password, user.Password).then(
					(valid) => {
						if (!valid) {
							return res.status(401).json({
								error: new Error('Incorrect password!')
							});
						}
						const token = jwt.sign(
							{ userId: user.UserID },
							'RANDOM_TOKEN_SECRET',
							{ expiresIn: '24h' });
						res.status(200).json({
							userId: user.UserID,
							username: user.UserName,
							token: token
						});
					}
				).catch(
					(err) => {
						res.status(500).json({
							error: err
						});
					}
				);
			} else {
				return res.status(401).json({
					error: new Error('User not found!')
				});
			}
		})
	})
};