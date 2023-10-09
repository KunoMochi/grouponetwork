// routes/user.js
const express = require('express');
const router = express.Router();

const commentCtrl = require('../controllers/comments');

router.post('/findComment', commentCtrl.findComment);
router.post('/findAllComments', commentCtrl.findAllComments);
router.post('/addComment', commentCtrl.addComment);
router.post('/editComment', commentCtrl.editComment);
router.post('/deleteComment', commentCtrl.deleteComment);

module.exports = router;