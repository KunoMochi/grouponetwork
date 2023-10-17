// routes/user.js
const express = require('express');
const router = express.Router();

const commentCtrl = require('../controllers/comments');

router.get('/findAllComments', commentCtrl.findAllComments);
router.get('/findRecentComments', commentCtrl.findRecentComments);
router.post('/findComment', commentCtrl.findComment);
router.post('/addComment', commentCtrl.addComment);
router.post('/editComment', commentCtrl.editComment);
router.post('/deleteComment', commentCtrl.deleteComment);

module.exports = router;