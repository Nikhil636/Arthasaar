const express = require("express");
const { verifyToken } = require("../middleware/authMiddleWare");
const { getUserHome, getPoolHome } = require("../controllers/homeController");
const router = express.Router();

router.get("/user", verifyToken, getUserHome);
router.get("/pool/:id", verifyToken, getPoolHome);

module.exports = router;
