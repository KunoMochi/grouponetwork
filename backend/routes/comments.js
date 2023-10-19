// routes/comments.js
const express = require('express');
const router = express.Router();

const commentCtrl = require('../controllers/comments');

router.get('/findAllTopics', commentCtrl.findAllTopics);
router.get('/findRecentTopics', commentCtrl.findRecentTopics);
router.get('/findAllComments', commentCtrl.findAllComments);
router.get('/findRecentComments', commentCtrl.findRecentComments);
router.get('/findComment/:id', commentCtrl.findComment);
router.get('/findChildComments/:id', commentCtrl.findChildComments);
router.post('/addComment', commentCtrl.addComment);
router.post('/editComment', commentCtrl.editComment);
router.post('/deleteComment', commentCtrl.deleteComment);

module.exports = router;