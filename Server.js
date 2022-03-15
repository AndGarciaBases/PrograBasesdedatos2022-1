var express = require('express');
var app = express();
var sql = require("mssql");
var session = require('express-session');
var bodyParser = require('body-parser');

app.set('view engine', 'ejs');
// database configuration
var config = {
    user: "useradmin",
    password: "password",
    server: "localhost", 
    database: "tarea 1",
    port: 1433,
    trustServerCertificate: true
};
sql.connect(config, function (err) {
    if (err) console.log(err);
    else{
        console.log('Connected to Database')
    }
    });
global.sql = sql;
app.use(express.static('public'));
const {getMainPage, auth, getLoginPage, getAgregarArticulo} = require('./routes/controller')
const {agregar} = require('./routes/cruds');

app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
app.get('/', function (req, res) {
 
    res.render('login.ejs', {root: __dirname});
});
app.post('/auth',auth);
app.post('/agregar',agregar);
app.get('/main',getMainPage);
app.get('/login',getLoginPage);
app.get('/AgregarArticulo',getAgregarArticulo);


var server = app.listen(80, function () {
    console.log('Server is running..');
});