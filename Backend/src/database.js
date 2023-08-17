const Pool = require('pg').Pool
const pool = new Pool({
  user: 'my_user',
  host: 'localhost',
  database: 'Monster',
  password: 'SQLDevPwd01!',
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