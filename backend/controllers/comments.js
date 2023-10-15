const mssql = require('mssql')

exports.findAllComments = (req, res, next) => {
	const db = req.app.locals.db;

  db.query('SELECT * FROM Comments', function(err, result) {
    if (err) {
      console.error(err)
      return res.status(500).json({ error: err })
    }
    res.status(200).json(result.recordset)
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
  const ps = new mssql.PreparedStatement(db);

  ps.input('userid', mssql.Int);
  ps.input('title', mssql.VarChar);
  ps.input('postContent', mssql.VarChar);
  ps.input('timestamp', mssql.DateTime);

  ps.prepare('EXECUTE AddTopic @userid, @title, @postContent, @timestamp', err => {
		  if (err) {
		    console.error(err)
        return res.status(500).json({
          error: error
        })
      }

      ps.execute({
        userid: parseInt(req.body.userId),
        title: req.body.title,
        postContent: req.body.postContent,
        timestamp: req.body.timestamp
      }, (err) => {
        if (err) {
          console.error(err)
          return res.status(500).json({
            error: error
          })
        }
        
        res.status(200).json({ message: 'Comment Added!' })
        ps.unprepare(err => {
          if (err) {
            console.error(err)
            return res.status(500).json({
              error: error
            })
          }
        })
      })
  });

  // Still need to link up comments with users via associative table

  // db.query('INSERT INTO Comments (Title, PostContent, Timestamp) VALUES (\'' + req.body.title + '\', \'' + req.body.postContent + '\', \'' + req.body.timestamp + '\')', function(err) {
  //   if (err) {
  //     console.error(err)
  //     return res.status(500).json({
  //       error: err
  //     });
  //   }
  //   res.status(200).json({ message: 'Comment added!' })
  // })
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