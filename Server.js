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
const {getMainPage, auth, getLoginPage} = require('./routes/controller')
const {} = require('./routes/cruds');

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
app.get('/main',getMainPage);
app.get('/login',getLoginPage);


var server = app.listen(80, function () {
    console.log('Server is running..');
});