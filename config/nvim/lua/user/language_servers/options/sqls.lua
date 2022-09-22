local database = require("user.database")

return {
  settings = {
    sqls = {
      connections = {
        {
          driver = database.config.driver,
          dataSourceName = database.config.dsn,
        },
      },
    },
  },
}
