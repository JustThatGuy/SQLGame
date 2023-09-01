const Pool = require('pg').Pool
const pool = new Pool({
  user: 'sqlgamer',
  password: 'wachtwoord',
  host: 'localhost',
  database: 'monster',
  port: 5432,
});

const runQuery = (query) => {
  return new Promise(function(resolve, reject) {
    pool.query(query, (error, results) => {
      if (error) {
        let msg = error;
        if(error.message) {
          msg = error.message;
        }
        reject(msg);
        console.log(msg);
        return;
      }
      resolve(results.rows);
    })
  })
}

const getInventory = () => {
  return runQuery('select * from game.inventory;');
}
  
module.exports = {
  getInventory,
  runQuery
}