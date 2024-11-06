const express = require("express");
const {
  createTransaction,
  getUserTransactionHistory,
  getPoolTransactionHistory,
  getRecentUserTransactionHistory,
  getRecentPoolTransactionHistory,
} = require("../controllers/transactionController");
const router = express.Router();

// Create a new transaction
router.post("/", createTransaction);

// Get user transaction history
router.get("/user/:id", getUserTransactionHistory);

// Get RECENT user transaction history
router.get("/user/:id/recent", getRecentUserTransactionHistory);

// Get pool transaction history
router.get("/pool/:id", getPoolTransactionHistory);

// Get RECENT pool transaction history
router.get("/pool/:id/recent", getRecentPoolTransactionHistory);

module.exports = router;
