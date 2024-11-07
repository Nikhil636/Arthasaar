const db = require("../config/db");

const recentPools = async (req) => {
  const userId = req.user.user_id;
  try {
    const [pools] = await db.query(
      `SELECT p.* 
       FROM pools p
       JOIN pool_members pm ON p.pool_id = pm.pool_id
       WHERE pm.user_id = ? AND p.active = 1 LIMIT 3`,
      [userId]
    );

    if (pools.length === 0) {
      return res.status(200).json({ pools: [] });
    }

    const poolIds = pools.map((pool) => pool.pool_id);
    const [members] = await db.query(
      `SELECT pm.pool_id, u.email
       FROM pool_members pm
       JOIN users u ON pm.user_id = u.user_id
       WHERE pm.pool_id IN (?)`,
      [poolIds]
    );

    const poolsWithMembers = pools.map((pool) => ({
      ...pool,
      members: members
        .filter((member) => member.pool_id === pool.pool_id)
        .map((member) => member.email),
    }));

    return poolsWithMembers;
  } catch (err) {
    console.error("Error fetching pools:", err);
    return;
  }
};

const recentTransactions = async (req) => {
  const userId = req.user.user_id;

  try {
    const [results] = await db.query(
      `SELECT * FROM transactions 
       WHERE from_user_id = ? OR to_user_id = ? 
       ORDER BY created_at DESC
       LIMIT 3`,
      [userId, userId]
    );
    return results;
  } catch (err) {
    console.error("Error fetching user transaction history:", err);
    return;
  }
};

const getUser = async (req) => {
  const userId = req.user.user_id;

  try {
    const [results] = await db.query(
      "SELECT user_id, user_name, email, balance, created_at FROM users WHERE user_id = ?",
      [userId]
    );

    if (results.length === 0) {
      return res.status(404).json({ message: "User not found" });
    }
    return results[0];
  } catch (err) {
    console.error("Error fetching user by ID:", err);
    return;
  }
};

exports.getUserHome = async (req, res) => {
  try {
    const pools = await recentPools(req);
    const transactions = await recentTransactions(req);
    const user = await getUser(req);

    res.status(200).send({ user, pools, transactions });
  } catch (error) {
    res.status(500).send({ error: "Failed to fetch pools" });
  }
};

exports.getPoolHome = async (req, res) => {
  const poolId = req.params.id;
  res.send({ poolId });
};
