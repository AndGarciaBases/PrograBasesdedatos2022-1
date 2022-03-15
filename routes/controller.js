module.exports = {
    getMainPage: (req, res)=>{
        var output = 0;
        let dbrequest = new sql.Request();
        let dbquery = "EXEC sp_MostrarArticulos @output out";
        dbrequest.output('output',sql.Int, output);
        dbrequest.query(dbquery,function(err,rows,fields){
            if (err) console.log(err)
            else{
                res.render('main.ejs', {"Articulos": rows});
            }
        });

    },
    getLoginPage: (req, res)=>{
        res.render('login.ejs');
    },
    auth: (req, res)=>{
        var username = req.body.username;
        var password = req.body.password;
        var output = 0;
        let dbrequest = new sql.Request();
        let dbquery = 'EXEC sp_Login @Usuario, @Contrasenna, @output out';
        if (username && password) {
            dbrequest.input('Usuario',sql.VarChar,username);
            dbrequest.input('Contrasenna',sql.VarChar,password);
            dbrequest.output('output', sql.Int, output);
            dbrequest.query(dbquery, function(error, results, fields) {
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
        },
    getAgregarArticulo: (req,res)=>{
        res.render('AgregarArticulo.ejs');
    }
    
    
}