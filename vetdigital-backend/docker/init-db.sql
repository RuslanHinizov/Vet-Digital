-- Enable required PostgreSQL extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- For fast text search

-- PostGIS for geospatial data (geofences, farm locations)
-- Note: timescaledb-ha image includes PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- TimescaleDB for GPS time-series data
CREATE EXTENSION IF NOT EXISTS timescaledb;
