// controllers/user.js
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const mssql = require('mssql');

exports.signup = (req, res, next) => {
	const db = req.app.locals.db;

	// console.log('username: ' + req.body.username + ', password: ' + req.body.password)
	// res.status(500).json('success!')

	// db.query('SELECT * FROM Users WHERE username = \'' + req.body.username + '\'', ((err, result) => {
	// 		if (err) {
	// 			console.error(err);
	// 			return res.status(500).json({error: err});
	// 		}
	// 		console.log(result.recordset[0]);
	// 		res.status(200).json({ message: 'Success!'});
	// 	})
	// )

	db.query('SELECT UserName FROM Users WHERE UserName = \'' + req.body.username + '\'', (err, result) => {
		if (result.recordset[0]) {
			return res.status(409).json({
				error: new Error('User already exists!')
			});
		}
		bcrypt.hash(req.body.password, 10).then(
				(hash) => {
					db.query('INSERT INTO Users (UserName, Password) VALUES (\'' + req.body.username + '\', \'' + hash + '\')', function(err) {
						if (err) {
							console.error(err)
							return res.status(500).json({
								error: err
							});
						}
						res.status(200).json({ message: 'User added!' })
					})
				}
			).catch(
				(error) => {
					res.status(500).json({
						error: error
					});
				}
			);
		});
};

exports.login = (req, res, next) => {
	const db = req.app.locals.db;

	db.query('SELECT UserName FROM Users WHERE UserName = ' + req.body.username, (err) => {
			if (err) {
				console.error(err)
				return res.status(401).json({
					error: new Error('User not found!')
				});
			}
		})
	db.query('SELECT Password FROM Users WHERE UserName = ' + req.body,username, function(err, result) {
		if (err) {
			console.error(err)
			return res.status(500).json({ error: err })
		}
		bcrypt.compare(req.body.password, result.recordset[0].Password).then(
			(valid) => {
				if (!valid) {
					return res.status(401).json({
						error: new Error('Incorrect password!')
					});
				}
				const token = jwt.sign(
					{ userId: user._id },
					'RANDOM_TOKEN_SECRET',
					{ expiresIn: '24h' });
				res.status(200).json({
					userId: user._id,
					token: token
				});
			}
		).catch(
			(error) => {
				res.status(500).json({
					error: error
				});
			}
		);
	})
};