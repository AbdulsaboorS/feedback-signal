-- Create feedback table
CREATE TABLE IF NOT EXISTS feedback (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  text TEXT NOT NULL,
  source TEXT NOT NULL,
  user_type TEXT,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  confidence TEXT,
  theme TEXT,
  labels TEXT
);-- Database schema
