const mssql = require('mssql')

exports.findAllComments = (req, res, next) => {
	const db = req.app.locals.db;

  db.query('EXECUTE FindAllComments', function(err, result) {
    if (err) {
      console.error(err)
      return res.status(500).json({ error: err })
    }
    res.status(200).json(result.recordset)
  });
}

exports.findRecentComments = (req, res, next) => {
	const db = req.app.locals.db;

  db.query('EXECUTE FindRecentComments', function(err, result) {
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

  ps.prepare('EXECUTE AddComment @userid, @title, @postContent, @timestamp', err => {
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
}

exports.editComment = (req, res, next) => {
    const db = req.app.locals.db;
    const ps = new mssql.PreparedStatement(db)

    ps.input('commentid', mssql.Int)
    ps.input('userid', mssql.Int)
    ps.input('content', mssql.VarChar)

    ps.prepare('EXECUTE EditComment @commentid, @userid, @content', err => {
      if (err) {
        console.error(err)
            res.status(500).json({
              error: error
            })
            return
      }

      ps.execute({
        commentid: req.body.commentid,
        userid: req.body.userid,
        content: req.body.content
      }, (err, result) => {
          if (err) {
            console.error(err)
            res.status(500).json({
              error: error
            })
            return
          }
          res.status(200).json(result.recordset)
          
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
  const ps = new mssql.PreparedStatement(db);

  ps.input('commentid', mssql.Int);
  ps.input('userid', mssql.Int);

  ps.prepare('EXECUTE DeleteComment @commentid, @userid', err => {
		  if (err) {
		    console.error(err)
        return res.status(500).json({
          error: error
        })
      }

      ps.execute({
          commentid: req.body.commentid,
          userid: req.body.userid
        }, (err, result) => {
          if (err) {
            console.error(err)
            res.status(500).json({
              error: error
            })
            return
          }
          res.status(200).json(result.recordset[0])
          
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