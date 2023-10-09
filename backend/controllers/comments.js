const mssql = require('mssql')

exports.findAllComments = (req, res, next) => {
	const db = req.app.locals.db;

    db.query('SELECT * FROM Comments', function(err, recordset) {
		if (err) {
		  console.error(err)
		  res.status(500).send('SERVER ERROR')
		  return
		}
		res.status(200).json(recordset)
	  });
    }

exports.findComment = (req, res, next) => {
    const db = req.app.locals.db;
    const ps = new mssql.PreparedStatement(db)

    ps.input('param', mssql.VarChar)
    ps.prepare('SELECT @param FROM Comments', err => {
		if (err) {
		  console.error(err)
		  res.status(500).send('SERVER ERROR')
		  return
		}

        ps.execute({ param: req.body.search}, (err, result) => {
            if (err) {
              console.error(err)
              res.status(500).json({
                error: error
              })
              return
            }
		    res.status(200).json(result)

            ps.unprepare(err => {
                if (err) {
                  console.error(err)
                  res.status(500).json({
                    error: error
                  })
                  return
                }
            })
        })
    })
}

exports.addComment = (req, res, next) => {
	const db = req.app.locals.db;

    db.query('SELECT UserName FROM Users WHERE UserName = ' + req.body.username, function(err, recordset) {
		if (err) {
		  console.error(err)
          res.status(500).json({
            error: error
          })
          return
		}
		res.status(200).json({ message: 'Comment Added!' })
	  });
    }

exports.editComment = (req, res, next) => {
    const db = req.app.locals.db;
    const ps = new mssql.PreparedStatement(db)

    ps.input('param', mssql.VarChar)
    ps.prepare('UPDATE Comments SET TextContent = @param', err => {
		if (err) {
		  console.error(err)
          res.status(500).json({
            error: error
          })
          return
		}

        ps.execute({ param: req.body.commentArea.value}, (err, result) => {
            if (err) {
              console.error(err)
              res.status(500).json({
                error: error
              })
              return
            }
            res.status(200).json({ message: 'Edit Successful!' })
            
            ps.unprepare(err => {
                if (err) {
                  console.error(err)
                  res.status(500).json({
                    error: error
                  })
                  return
                }
            })
        })
    })
}

exports.deleteComment = (req, res, next) => {
	const db = req.app.locals.db;

    db.query('DELETE FROM Comments WHERE CommentID = ' +
        '(SELECT CommentID FROM Comments C, Users U, Comment_assoc CA WHERE CA.UserID = ' +
            '(SELECT UserID FROM Users WHERE UserName = ' + req.body.username + ') AND' +
            'CA.CommentID = ' + req.body.commentID + ')',
        function(err, recordset) {
		if (err) {
		  console.error(err)
          res.status(500).json({
            error: error
          })
          return
		}
		res.status(200).json({ message: 'Comment Deleted!' })
	  });
    }