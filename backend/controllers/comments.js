// controllers/comments.js
const mssql = require('mssql')

exports.findAllTopics = (req, res, next) => {
	const db = req.app.locals.db;

  db.query('EXECUTE FindAllTopics', function(err, result) {
    if (err) {
      console.error(err)
      return res.status(500).json({ error: err })
    }
    res.status(200).json(result.recordset)
  });
}

exports.findRecentTopics = (req, res, next) => {
	const db = req.app.locals.db;

  db.query('EXECUTE FindRecentTopics', function(err, result) {
    if (err) {
      console.error(err)
      return res.status(500).json({ error: err })
    }
    res.status(200).json(result.recordset)
  });
}

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

  ps.input('commentid', mssql.Int)
  ps.prepare('EXECUTE FindComment @commentid', (err) => {
    if (err) {
      console.error(err)
      return res.status(500).send(err)
    }

    ps.execute({ commentid: req.params.id}, (err, result) => {
      if (err) {
        console.error(err)
        return res.status(500).json({ error: err })
      }
      res.status(200).json(result.recordset)

      ps.unprepare(err => {
        if (err) {
          console.error(err)
          return res.status(500).json({ error: err })
        }
      })
    })
  })
}

exports.findComments = (req, res, next) => {
  const db = req.app.locals.db;
  const ps = new mssql.PreparedStatement(db)

  console.log("query: " + req.query.query)
  ps.input('queryParam', mssql.VarChar)
  ps.prepare('EXECUTE FindComments @queryParam', (err) => {
    if (err) {
      console.error(err)
      return res.status(500).send(err)
    }

    ps.execute({ queryParam: req.query.query}, (err, result) => {
      if (err) {
        console.error(err)
        return res.status(500).json({ error: err })
      }
      res.status(200).json(result.recordset)

      ps.unprepare(err => {
        if (err) {
          console.error(err)
          return res.status(500).json({ error: err })
        }
      })
    })
  })
}

exports.findUserComments = (req, res, next) => {
  const db = req.app.locals.db;
  const ps = new mssql.PreparedStatement(db)

  ps.input('userid', mssql.Int)
  ps.prepare('EXECUTE FindUserComments @userid', (err) => {
    if (err) {
      console.error(err)
      return res.status(500).send(err)
    }

    ps.execute({ userid: req.params.id}, (err, result) => {
      if (err) {
        console.error(err)
        return res.status(500).json({ error: err })
      }
      res.status(200).json(result.recordset)

      ps.unprepare(err => {
        if (err) {
          console.error(err)
          return res.status(500).json({ error: err })
        }
      })
    })
  })
}

exports.findChildComments = (req, res, next) => {
  const db = req.app.locals.db;
  const ps = new mssql.PreparedStatement(db)

  ps.input('parentid', mssql.Int)
  ps.prepare('EXECUTE FindChildComments @parentid', (err) => {
    if (err) {
      console.error(err)
      return res.status(500).send(err)
    }

    ps.execute({ parentid: req.params.id}, (err, result) => {
      if (err) {
        console.error(err)
        return res.status(500).json({ error: err })
      }
      res.status(200).json(result.recordset)

      ps.unprepare(err => {
        if (err) {
          console.error(err)
          return res.status(500).json({ error: err })
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
  ps.input('parentid', mssql.Int);

  ps.prepare('EXECUTE AddComment @userid, @title, @postContent, @timestamp, @parentid', (err) => {
		  if (err) {
		    console.error(err)
        return res.status(500).json({ error: err })
      }

      ps.execute({
        userid: parseInt(req.body.userId),
        title: req.body.title,
        postContent: req.body.postContent,
        timestamp: req.body.timestamp,
        parentid: parseInt(req.body.parentId)
      }, (err) => {
        if (err) {
          console.error(err)
          return res.status(500).json({ error: err })
        }
        
        res.status(200).json({ message: 'Comment Added!' })
        ps.unprepare(err => {
          if (err) {
            console.error(err)
            return res.status(500).json({ error: err })
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

    ps.prepare('EXECUTE EditComment @commentid, @userid, @content', (err) => {
      if (err) {
        console.error(err)
        return res.status(500).json({ error: err })
      }

      ps.execute({
        commentid: req.body.commentid,
        userid: req.body.userid,
        content: req.body.content
      }, (err, result) => {
          if (err) {
            console.error(err)
            return res.status(500).json({ error: err })
          }
          res.status(200).json(result.recordset)
          
          ps.unprepare(err => {
            if (err) {
              console.error(err)
              return res.status(500).json({ error: err })
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

  ps.prepare('EXECUTE DeleteComment @commentid, @userid', (err) => {
      if (err) {
        console.error(err)
        return res.status(500).json({ error: err })
      }

      ps.execute({
          commentid: req.body.commentid,
          userid: req.body.userid
        }, (err, result) => {
          if (err) {
            console.error(err)
            return res.status(500).json({ error: err })
          }
          res.status(200).json(result.recordset[0])
          
          ps.unprepare(err => {
            if (err) {
              console.error(err)
              return res.status(500).json({ error: err })
            }
          })
      })
    })
}