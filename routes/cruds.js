module.exports = {
    agregar: (req,res)=> {
        var Nombre = req.body.username;
        var Precio = req.body.password;
        var output = 0;
        let dbrequest = new sql.Request();
        let dbquery = 'EXEC sp_AgregarArticulo @Nombre, @Precio, @output out';
        if (Nombre && Precio) {
            dbrequest.input('Nombre',sql.VarChar,Nombre);
            dbrequest.input('Precio',sql.Money,Precio);
            dbrequest.output('output', sql.Int, output);
            dbrequest.query(dbquery, function(err, results, fields) {
                if (results.output.output == 50001)
                    res.send('Error al agregar articulo');
                else {
                    /*res.send('Articulo agregado con exito');*/
                    res.redirect('/main');
                }			
                res.end();
            });
        } else {
            res.send('Porfavor introduzca datos');
            res.end();
        }
    }
}