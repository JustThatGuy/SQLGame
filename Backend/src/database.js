const Pool = require('pg').Pool
const pool = new Pool({
  user: 'sqlgamer',
  password: 'wachtwoord',
  host: 'localhost',
  database: 'monster',
  port: 5432,
});

// not sure if we need these as of right now
const getQuest = () => {
    return new Promise(function(resolve, reject) {
      pool.query('SELECT * FROM Quests ORDER BY id ASC', (error, results) => {
        if (error) {
          reject(error)
        }
        resolve(results.rows);
      })
    })
  }

//might just be doing double the work.
const sqlQuery = (body) => {
  return new Promise(function(resolve, reject) {
    const { userQuery } = body
    pool.query('(userQuery)', [userQuery], (error, results) => {
      if (error) {
        reject(error)
      }
      resolve(`${results.rows}`)
    })
  })
}
  
module.exports = {
  sqlQuery,
  getQuest,
  pool
}