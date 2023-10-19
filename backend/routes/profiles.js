// routes/profiles.js
const express = require('express');
const router = express.Router();

const profileCtrl = require('../controllers/profiles');

router.get('/findUser/:id', profileCtrl.findUser);

module.exports = router;