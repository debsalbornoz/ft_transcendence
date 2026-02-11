import { getPool } from "../../lib/db";

export default async function handler(req, res) {
  try {
    const pool = await getPool();
    const result = await pool.request().query("SELECT 1 AS ok");

    return res.status(200).json({
      status: "ok",
      db: result.recordset?.[0]?.ok === 1 ? "ok" : "unknown",
    });
  } catch (err) {
    return res.status(500).json({
      status: "error",
      db: "error",
      message: err?.message || String(err),
    });
  }
}
