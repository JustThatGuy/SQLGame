const Pool = require('pg').Pool
const pool = new Pool({
  user: 'sqlgamer',
  password: 'wachtwoord',
  host: 'PostgreSQL',
  database: 'monster',
  port: 5432,
});

const getInventory = () => {
  return new Promise(function(resolve, reject) {
    pool.query('select * from game.inventory;', (error, results) => {
      if (error) {
        reject(error);
        console.log(error);
        return;
      }
      resolve(results.rows);
    })
  })
}

//might just be doing double the work.
const sqlQuery = (body) => {
  return new Promise(function(resolve, reject) {
    const { userQuery } = body
    pool.query('(userQuery)', [], (error, results) => {
      if (error) {
        reject(error)
      }
      resolve(results.rows)
    })
  })
}
  
module.exports = {
  sqlQuery,
  pool,
  getInventory
}