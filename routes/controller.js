module.exports = {
    getMainPage: (req, res)=>{
        res.render('main.ejs');
    },
    getLoginPage: (req, res)=>{
        res.render('login.ejs');
    },
    auth: (req, res)=>{
        var username = req.body.username;
        var password = req.body.password;
        var output = 0;
        let dbrequest = new sql.Request();
        let dbquery = 'EXEC Login @Usuario, @Contrasenna, @output out';
        if (username && password) {
            dbrequest.input('Usuario',sql.VarChar,username);
            dbrequest.input('Contrasenna',sql.VarChar,password);
            dbrequest.output('output', sql.Int, output);
            dbrequest.query(dbquery, function(error, results, fields) {
                console.log({results});
                if (results.output.output == 1) {
                    req.session.loggedin = true;
                    req.session.username = username;
                    res.redirect('/main');
                } else {
                    res.send('Incorrect Username and/or Password!');
                }			
                res.end();
            });
        } else {
            res.send('Please enter Username and Password!');
            res.end();
        }
        }
    
}