const Pool = require('pg').Pool
const pool = new Pool({
  user: 'sql-gamer',
  host: 'localhost',
  database: 'monster',
  password: 'wachtwoord',
  port: 5432,
});

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
  getQuest,
  sqlQuery
}