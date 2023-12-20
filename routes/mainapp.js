var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    if(req.session && req.session.useraccount){
        console.log("account id: "+req.session.useraccount);

        res.render('index', { title: 'SportMint',useraccount:req.session.useraccount});
    }
    else{
        res.redirect('/');
    }
});

module.exports = router;
