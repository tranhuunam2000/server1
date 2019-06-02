const MySQL = require('../server/mysql.js');
const Logger = require('../server/logger.js');
const Profiler = require('../server/profiler.js');
const parseSettings = require('../server/settings.js');
const { prepareQuery, typeCast, safeInvoke } = require('../server/utils.js');

let logger = null;
let profiler = null;
let mysql = null;
let config = {};

global.exports('mysql_execute', (query, parameters, callback) => {
  const invokingResource = global.GetInvokingResource();
  const sql = prepareQuery(query, parameters);
  mysql.execute({ sql, typeCast }, invokingResource).then((result) => {
    safeInvoke(callback, (result) ? result.affectedRows : 0);
  });
});

global.exports('mysql_fetch_all', (query, parameters, callback) => {
  const invokingResource = global.GetInvokingResource();
  const sql = prepareQuery(query, parameters);
  mysql.execute({ sql, typeCast }, invokingResource).then((result) => {
    safeInvoke(callback, result);
  });
});

global.exports('mysql_fetch_scalar', (query, parameters, callback) => {
  const invokingResource = global.GetInvokingResource();
  const sql = prepareQuery(query, parameters);
  mysql.execute({ sql, typeCast }, invokingResource).then((result) => {
    safeInvoke(callback, (result && result[0]) ? Object.values(result[0])[0] : null);
  });
});

global.exports('mysql_insert', (query, parameters, callback) => {
  const invokingResource = global.GetInvokingResource();
  const sql = prepareQuery(query, parameters);
  mysql.execute({ sql, typeCast }, invokingResource).then((result) => {
    safeInvoke(callback, (result) ? result.insertId : 0);
  });
});

let isReady = false;
global.on('onServerResourceStart', (resourcename) => {
  if (resourcename === 'mysql-async') {
    const trace = global.GetConvarInt('mysql_debug', 0);
    const slowQueryWarningTime = global.GetConvarInt('mysql_slow_query_warning', 200);

    logger = new Logger(global.GetConvar('mysql_debug_output', 'console'));
    profiler = new Profiler(logger, { trace, slowQueryWarningTime });

    // needs to move to a new file
    const connectionString = global.GetConvar('mysql_connection_string', 'Empty');
    if (connectionString === 'Empty') {
      logger.Error('Empty mysql_connection_string detected.');
      throw new Error('Empty mysql_connection_string detected.');
    }
    config = parseSettings(connectionString);

    mysql = new MySQL(config, logger, profiler);
    global.emit('onMySQLReady'); // avoid ESX bugs
    isReady = true;
  }
  if (isReady) {
    global.emit('MySQLReady'); // avoid ESX bugs
  }
});

global.onNet('mysql-async:request-data', () => {
  if (isReady) {
    const src = global.source;
    global.emitNet('mysql-async:update-resource-data', src, profiler.profiles.resources);
    global.emitNet('mysql-async:update-time-data', src, profiler.profiles.executionTimes);
    global.emitNet('mysql-async:update-slow-queries', src, profiler.profiles.slowQueries);
  }
});
