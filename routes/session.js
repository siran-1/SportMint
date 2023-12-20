var express = require('express');
var router = express.Router();
const pool = require('../public/javascripts/databaseconnection');

function queryDatabase(query, values) {
    return pool.query(query, values)
        .then(([results]) => results)
        .catch((error) => { throw error; });
}

router.post('/', async function (req, res, next) {
    const account = req.body.address;
    try {
        const selectQuery = 'SELECT * FROM sportmint.users WHERE useraccount = ?';
        const insertQuery = 'INSERT INTO sportmint.users(useraccount) VALUES (?)';
        const values = [account];

        const selectResult = await queryDatabase(selectQuery, values);
        if (selectResult.length > 0) {
            const user = selectResult[0];
            req.session.useraccount = user.useraccount;
            res.json({ success: true, message: "User exists, session created." });
        } else {
            const insertvalue = [account];
            const insertResult = await queryDatabase(insertQuery, insertvalue);
            if (insertResult.affectedRows > 0) {
                req.session.useraccount = account;
                res.json({ success: true, message: "New user created, session created." });
            } else {
                res.json({ success: false, message: "Failed to create new user." });
            }
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: "Server error." });
    }
});

module.exports = router;
