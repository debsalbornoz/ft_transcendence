import * as sql from "mssql";

let pool;

function getConfig() {
  const port = Number(process.env.DB_PORT || 1433);

  return {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_HOST,
    port,
    database: process.env.DB_NAME,
    options: {
      encrypt: false,
      trustServerCertificate: true,
    },
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000,
    },
  };
}

export async function getPool() {
  if (pool) return pool;
  pool = await sql.connect(getConfig());
  return pool;
}
