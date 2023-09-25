const mssql = require('mssql');
const express = require('express');
const app = express();
const path = require('path');

const sqlConfig = {
    user: 'GroupTestAdmin',
    password: 'ThisIs@Test',
    database: 'GroupDB',
    server: 'localhost',
    options: {
        encrypt: true,
        trustServerCertificate: true
    }
};

const appPool = new mssql.ConnectionPool(sqlConfig);

app.use('/images', express.static(path.join(__dirname, 'images')));

const userRoutes = require('./routes/user');

// try {
//     await mssql.connect(sqlConfig);
//     const result = await mssql.query`select * from Users`;
//     console.log(result);
// } catch (err) {
//     console.log('Unable to connect to database');
//     console.error(err);
// }

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    next();
});

app.use(express.json());

app.use('/api/auth', userRoutes);

appPool.connect().then(function(pool) {
    app.locals.db = pool;
    const server = app.listen(3000, function() {
        const host = server.address().address
        const port = server.address().port
        console.log('App listening at http://%s:%s', host, port)
    })
}).catch(function(err) {
    console.error('Error creating connection pool', err)
});

module.exports = app;