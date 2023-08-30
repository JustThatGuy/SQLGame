const express= require(`express`)
const bodyParser= require(`body-parser`)
const database = require('./database')
// const cors= require(`cors`)

// set express env
const app= express()
const PORT = process.env.PORT || 8080;

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

app.use(express.json())
app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers');
  next();
});

// request all inventory data
app.get('/inventory', (req, res) => {
  database.getInventory()
  .then(response => {
    res.status(200).send(response);
  })
  .catch(error => {
    res.status(500).send(error);
  })
})

// get whatever the user specifies in the request query.
app.get('/sqlQuery', async (req,res) => {
  try {
    // set query to body
    const {query} = req.body;
    // await for a request
    const queryText = await database.sqlQuery(
      //has to just be whatever user put in
      "(query)",
      [query]
    );
    
    // set response json to all rows
    res.json(queryText.rows)
  // just in case
  } catch (err) {
    console.error(err.message);
  }
});

// simple route
app.get("/", (req, res) => {
  res.json({ message: "Welcome to the api server!" });
});

// set port, listen for requests
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});