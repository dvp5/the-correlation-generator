const Pool = require('pg').Pool
const pool = new Pool({
  user: 'me',
  host: 'localhost',
  database: 'corrgen',
  password: 'password',
  port: 8888,
})

const getAll = (req, res) => {
        pool.query('SELECT * FROM Nation', (error, results) => {
                if(error) {
                        throw error
                }
                res.status(200).json(results.rows)
        })
}

module.exports = {
        getAll,
}
