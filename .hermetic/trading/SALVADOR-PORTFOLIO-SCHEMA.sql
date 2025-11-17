-- ============================================================================
-- SALVADOR PORTFOLIO MONITOR - SUPABASE SCHEMA
-- ============================================================================
-- Purpose: Track Salvador's personal investment positions and historical snapshots
-- Hermetic Principle: Transparency - Salvador deserves full visibility into his holdings
-- Created: November 4, 2025
-- ============================================================================

-- Drop existing tables if they exist (careful - only run this on first setup!)
-- DROP TABLE IF EXISTS salvador_position_snapshots CASCADE;
-- DROP TABLE IF EXISTS salvador_positions CASCADE;

-- ============================================================================
-- TABLE: salvador_positions
-- ============================================================================
-- Stores Salvador's current investment positions
-- Each row = one position (ticker + shares + cost basis)
-- ============================================================================

CREATE TABLE IF NOT EXISTS salvador_positions (
    id BIGSERIAL PRIMARY KEY,

    -- Position Details
    ticker VARCHAR(10) NOT NULL,
    shares NUMERIC(12, 4) NOT NULL CHECK (shares >= 0),
    cost_basis NUMERIC(12, 4) NOT NULL CHECK (cost_basis >= 0), -- Price per share when bought
    total_cost NUMERIC(12, 2) NOT NULL CHECK (total_cost >= 0), -- Total $ invested (shares * cost_basis)
    purchase_date DATE NOT NULL,

    -- Position Metadata
    notes TEXT, -- Optional notes about this position (e.g., "Long-term hold", "Swing trade")
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'closed')),

    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    closed_at TIMESTAMPTZ -- When position was closed (NULL if still active)
);

-- ============================================================================
-- TABLE: salvador_position_snapshots
-- ============================================================================
-- Historical snapshots of Salvador's positions
-- Captures daily position values for performance tracking over time
-- ============================================================================

CREATE TABLE IF NOT EXISTS salvador_position_snapshots (
    id BIGSERIAL PRIMARY KEY,

    snapshot_date DATE NOT NULL DEFAULT CURRENT_DATE,
    ticker VARCHAR(10) NOT NULL,
    shares NUMERIC(12, 4) NOT NULL CHECK (shares >= 0),
    cost_basis NUMERIC(12, 4) NOT NULL CHECK (cost_basis >= 0),
    current_price NUMERIC(12, 4) NOT NULL CHECK (current_price >= 0),
    current_value NUMERIC(12, 2) NOT NULL CHECK (current_value >= 0),
    unrealized_pl NUMERIC(12, 2) NOT NULL, -- Can be negative
    unrealized_pl_pct NUMERIC(6, 2) NOT NULL, -- Can be negative

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- INDEXES
-- ============================================================================
-- Optimize queries for common access patterns

-- Find positions by ticker (for quick lookups)
CREATE INDEX IF NOT EXISTS idx_salvador_positions_ticker
ON salvador_positions(ticker);

-- Find active vs closed positions
CREATE INDEX IF NOT EXISTS idx_salvador_positions_status
ON salvador_positions(status);

-- Find snapshots by date (for historical performance queries)
CREATE INDEX IF NOT EXISTS idx_salvador_snapshots_date
ON salvador_position_snapshots(snapshot_date DESC);

-- Find snapshots by ticker and date (for per-stock historical analysis)
CREATE INDEX IF NOT EXISTS idx_salvador_snapshots_ticker
ON salvador_position_snapshots(ticker, snapshot_date DESC);

-- ============================================================================
-- TRIGGERS
-- ============================================================================
-- Automatically update the updated_at timestamp when positions are modified

CREATE OR REPLACE FUNCTION update_salvador_positions_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_salvador_positions_updated_at
    BEFORE UPDATE ON salvador_positions
    FOR EACH ROW
    EXECUTE FUNCTION update_salvador_positions_updated_at();

-- ============================================================================
-- COMMENTS (Documentation within the database)
-- ============================================================================

COMMENT ON TABLE salvador_positions IS 'Salvador''s current investment positions - tracks what he owns, cost basis, and purchase dates';
COMMENT ON TABLE salvador_position_snapshots IS 'Daily snapshots of Salvador''s positions for historical performance tracking';

COMMENT ON COLUMN salvador_positions.ticker IS 'Stock ticker symbol (e.g., NVDA, TSLA, SCHB)';
COMMENT ON COLUMN salvador_positions.shares IS 'Number of shares owned';
COMMENT ON COLUMN salvador_positions.cost_basis IS 'Price per share when purchased';
COMMENT ON COLUMN salvador_positions.total_cost IS 'Total investment amount (shares * cost_basis)';
COMMENT ON COLUMN salvador_positions.status IS 'active = currently held, closed = sold/closed';

COMMENT ON COLUMN salvador_position_snapshots.unrealized_pl IS 'Unrealized profit/loss in dollars (current_value - total_cost)';
COMMENT ON COLUMN salvador_position_snapshots.unrealized_pl_pct IS 'Unrealized profit/loss percentage ((unrealized_pl / total_cost) * 100)';

-- ============================================================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================================================
-- Uncomment to insert sample positions for testing the system

-- INSERT INTO salvador_positions (ticker, shares, cost_basis, total_cost, purchase_date, notes) VALUES
-- ('NVDA', 10.0000, 500.00, 5000.00, '2025-01-15', 'Long-term AI play - holding for growth'),
-- ('TSLA', 5.0000, 250.00, 1250.00, '2025-02-01', 'EV sector exposure'),
-- ('SCHB', 100.0000, 55.00, 5500.00, '2025-01-10', 'Core broad market ETF - stability and diversification')
-- ON CONFLICT DO NOTHING;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================
-- Run these after setup to verify everything works

-- Check that tables exist
-- SELECT table_name FROM information_schema.tables
-- WHERE table_schema = 'public'
-- AND table_name LIKE 'salvador%';

-- Check active positions
-- SELECT * FROM salvador_positions WHERE status = 'active';

-- Check indexes
-- SELECT indexname, tablename FROM pg_indexes
-- WHERE tablename LIKE 'salvador%';

-- ============================================================================
-- MAINTENANCE
-- ============================================================================

-- To close a position:
-- UPDATE salvador_positions
-- SET status = 'closed', closed_at = NOW()
-- WHERE ticker = 'TICKER_SYMBOL';

-- To update shares (if Salvador bought more):
-- UPDATE salvador_positions
-- SET shares = shares + NEW_SHARES,
--     total_cost = total_cost + (NEW_SHARES * NEW_PRICE)
-- WHERE ticker = 'TICKER_SYMBOL' AND status = 'active';

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================
-- Next steps:
-- 1. Run this SQL in Supabase SQL Editor
-- 2. Insert Salvador's initial positions
-- 3. Build Telegram webhook workflow to query these tables
-- 4. Set up daily snapshot automation
-- ============================================================================
