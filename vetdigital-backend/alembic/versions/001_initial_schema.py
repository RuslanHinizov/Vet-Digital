"""Initial schema - all tables and seed data.

Revision ID: 001_initial_schema
Revises:
Create Date: 2024-01-01 00:00:00.000000
"""
from alembic import op
import sqlalchemy as sa

revision = "001_initial_schema"
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ------------------------------------------------------------------ #
    # 1. regions
    # ------------------------------------------------------------------ #
    op.create_table(
        "regions",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("parent_id", sa.Integer(), nullable=True),
        sa.Column("name_kk", sa.String(255), nullable=False),
        sa.Column("name_ru", sa.String(255), nullable=False),
        sa.Column("level", sa.SmallInteger(), nullable=False),
        sa.Column("kato_code", sa.String(20), nullable=True),
        sa.Column("boundary_wkt", sa.Text(), nullable=True),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["parent_id"], ["regions.id"]),
        sa.UniqueConstraint("kato_code"),
    )

    # ------------------------------------------------------------------ #
    # 2. permissions
    # ------------------------------------------------------------------ #
    op.create_table(
        "permissions",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("codename", sa.String(100), nullable=False),
        sa.Column("description", sa.String(255), nullable=True),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("codename"),
    )

    # ------------------------------------------------------------------ #
    # 3. roles
    # ------------------------------------------------------------------ #
    op.create_table(
        "roles",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("name", sa.String(50), nullable=False),
        sa.Column("description_kk", sa.Text(), nullable=True),
        sa.Column("description_ru", sa.Text(), nullable=True),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("name"),
    )

    # ------------------------------------------------------------------ #
    # 4. role_permissions
    # ------------------------------------------------------------------ #
    op.create_table(
        "role_permissions",
        sa.Column("role_id", sa.Integer(), nullable=False),
        sa.Column("permission_id", sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(["role_id"], ["roles.id"]),
        sa.ForeignKeyConstraint(["permission_id"], ["permissions.id"]),
        sa.PrimaryKeyConstraint("role_id", "permission_id"),
    )

    # ------------------------------------------------------------------ #
    # 5. organizations
    # ------------------------------------------------------------------ #
    op.create_table(
        "organizations",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("bin", sa.String(12), nullable=False),
        sa.Column("name_kk", sa.String(255), nullable=True),
        sa.Column("name_ru", sa.String(255), nullable=False),
        sa.Column("org_type", sa.String(50), nullable=False),
        sa.Column("region_id", sa.Integer(), nullable=True),
        sa.Column("address", sa.Text(), nullable=True),
        sa.Column("phone", sa.String(20), nullable=True),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("bin"),
        sa.ForeignKeyConstraint(["region_id"], ["regions.id"]),
    )

    # ------------------------------------------------------------------ #
    # 6. users
    # ------------------------------------------------------------------ #
    op.create_table(
        "users",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("iin", sa.String(12), nullable=False),
        sa.Column("email", sa.String(255), nullable=True),
        sa.Column("phone", sa.String(20), nullable=True),
        sa.Column("full_name_kk", sa.String(255), nullable=True),
        sa.Column("full_name_ru", sa.String(255), nullable=False),
        sa.Column("role_id", sa.Integer(), nullable=False),
        sa.Column("organization_id", sa.String(36), nullable=True),
        sa.Column("region_id", sa.Integer(), nullable=True),
        sa.Column("password_hash", sa.String(255), nullable=True),
        sa.Column("eds_cert_serial", sa.String(255), nullable=True),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("language_pref", sa.String(2), nullable=False, server_default="ru"),
        sa.Column("fcm_token", sa.String(512), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("iin"),
        sa.ForeignKeyConstraint(["role_id"], ["roles.id"]),
        sa.ForeignKeyConstraint(["organization_id"], ["organizations.id"]),
        sa.ForeignKeyConstraint(["region_id"], ["regions.id"]),
    )

    # ------------------------------------------------------------------ #
    # 7. animal_species
    # ------------------------------------------------------------------ #
    op.create_table(
        "animal_species",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("name_kk", sa.String(100), nullable=False),
        sa.Column("name_ru", sa.String(100), nullable=False),
        sa.Column("code", sa.String(20), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("code"),
    )

    # ------------------------------------------------------------------ #
    # 8. animal_breeds
    # ------------------------------------------------------------------ #
    op.create_table(
        "animal_breeds",
        sa.Column("id", sa.Integer(), autoincrement=True, nullable=False),
        sa.Column("species_id", sa.Integer(), nullable=False),
        sa.Column("name_kk", sa.String(100), nullable=True),
        sa.Column("name_ru", sa.String(100), nullable=False),
        sa.Column("code", sa.String(50), nullable=True),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["species_id"], ["animal_species.id"]),
    )

    # ------------------------------------------------------------------ #
    # 9. owners
    # ------------------------------------------------------------------ #
    op.create_table(
        "owners",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("user_id", sa.String(36), nullable=True),
        sa.Column("iin", sa.String(12), nullable=False),
        sa.Column("full_name_kk", sa.String(255), nullable=True),
        sa.Column("full_name_ru", sa.String(255), nullable=False),
        sa.Column("phone", sa.String(20), nullable=True),
        sa.Column("address", sa.Text(), nullable=True),
        sa.Column("region_id", sa.Integer(), nullable=True),
        sa.Column("farm_name", sa.String(255), nullable=True),
        sa.Column("farm_latitude", sa.Float(), nullable=True),
        sa.Column("farm_longitude", sa.Float(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"]),
        sa.ForeignKeyConstraint(["region_id"], ["regions.id"]),
    )
    op.create_index("ix_owners_iin", "owners", ["iin"])

    # ------------------------------------------------------------------ #
    # 10. animals
    # ------------------------------------------------------------------ #
    op.create_table(
        "animals",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("identification_no", sa.String(50), nullable=False),
        sa.Column("microchip_no", sa.String(15), nullable=True),
        sa.Column("rfid_tag_no", sa.String(50), nullable=True),
        sa.Column("species_id", sa.Integer(), nullable=False),
        sa.Column("breed_id", sa.Integer(), nullable=True),
        sa.Column("sex", sa.String(10), nullable=False),
        sa.Column("birth_date", sa.Date(), nullable=True),
        sa.Column("color_kk", sa.String(100), nullable=True),
        sa.Column("color_ru", sa.String(100), nullable=True),
        sa.Column("weight_kg", sa.Numeric(8, 2), nullable=True),
        sa.Column("photo_url", sa.String(512), nullable=True),
        sa.Column("owner_id", sa.String(36), nullable=False),
        sa.Column("region_id", sa.Integer(), nullable=True),
        sa.Column("status", sa.String(20), nullable=False, server_default="active"),
        sa.Column("iszh_synced_at", sa.String(50), nullable=True),
        sa.Column("notes", sa.Text(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("deleted_at", sa.DateTime(timezone=True), nullable=True),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("identification_no"),
        sa.ForeignKeyConstraint(["species_id"], ["animal_species.id"]),
        sa.ForeignKeyConstraint(["breed_id"], ["animal_breeds.id"]),
        sa.ForeignKeyConstraint(["owner_id"], ["owners.id"]),
        sa.ForeignKeyConstraint(["region_id"], ["regions.id"]),
    )
    op.create_index("ix_animals_microchip_no", "animals", ["microchip_no"])
    op.create_index("ix_animals_rfid_tag_no", "animals", ["rfid_tag_no"])

    # ------------------------------------------------------------------ #
    # 11. gps_devices
    # ------------------------------------------------------------------ #
    op.create_table(
        "gps_devices",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("device_serial", sa.String(100), nullable=False),
        sa.Column("device_model", sa.String(100), nullable=True),
        sa.Column("animal_id", sa.String(36), nullable=True),
        sa.Column("owner_id", sa.String(36), nullable=True),
        sa.Column("status", sa.String(20), nullable=False, server_default="active"),
        sa.Column("battery_level", sa.SmallInteger(), nullable=True),
        sa.Column("firmware_ver", sa.String(50), nullable=True),
        sa.Column("last_seen_at", sa.String(50), nullable=True),
        sa.Column("last_latitude", sa.Float(), nullable=True),
        sa.Column("last_longitude", sa.Float(), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("device_serial"),
        sa.ForeignKeyConstraint(["animal_id"], ["animals.id"]),
        sa.ForeignKeyConstraint(["owner_id"], ["owners.id"]),
    )

    # ------------------------------------------------------------------ #
    # 12. gps_readings  (TimescaleDB hypertable - partition on 'time')
    # ------------------------------------------------------------------ #
    op.create_table(
        "gps_readings",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("time", sa.String(50), nullable=False),
        sa.Column("device_id", sa.String(36), nullable=False),
        sa.Column("animal_id", sa.String(36), nullable=False),
        sa.Column("latitude", sa.Float(), nullable=False),
        sa.Column("longitude", sa.Float(), nullable=False),
        sa.Column("altitude", sa.Float(), nullable=True),
        sa.Column("speed", sa.Float(), nullable=True),
        sa.Column("heading", sa.Float(), nullable=True),
        sa.Column("accuracy", sa.Float(), nullable=True),
        sa.Column("battery", sa.SmallInteger(), nullable=True),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["device_id"], ["gps_devices.id"]),
    )
    op.create_index("ix_gps_readings_time", "gps_readings", ["time"])
    op.create_index("ix_gps_readings_animal_id", "gps_readings", ["animal_id"])

    # ------------------------------------------------------------------ #
    # 13. geofences
    # ------------------------------------------------------------------ #
    op.create_table(
        "geofences",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("name_kk", sa.String(255), nullable=True),
        sa.Column("name_ru", sa.String(255), nullable=False),
        sa.Column("owner_id", sa.String(36), nullable=True),
        sa.Column("region_id", sa.Integer(), nullable=True),
        sa.Column("fence_type", sa.String(30), nullable=False),
        sa.Column("description", sa.Text(), nullable=True),
        sa.Column("boundary_geojson", sa.Text(), nullable=False),
        sa.Column("area_sqm", sa.Float(), nullable=True),
        sa.Column("is_active", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("alert_on_exit", sa.Boolean(), nullable=False, server_default="true"),
        sa.Column("alert_on_enter", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("created_by", sa.String(36), nullable=False),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["owner_id"], ["owners.id"]),
        sa.ForeignKeyConstraint(["region_id"], ["regions.id"]),
        sa.ForeignKeyConstraint(["created_by"], ["users.id"]),
    )

    # ------------------------------------------------------------------ #
    # 14. geofence_animals
    # ------------------------------------------------------------------ #
    op.create_table(
        "geofence_animals",
        sa.Column("geofence_id", sa.String(36), nullable=False),
        sa.Column("animal_id", sa.String(36), nullable=False),
        sa.PrimaryKeyConstraint("geofence_id", "animal_id"),
        sa.ForeignKeyConstraint(["geofence_id"], ["geofences.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["animal_id"], ["animals.id"], ondelete="CASCADE"),
    )

    # ------------------------------------------------------------------ #
    # 15. geofence_alerts
    # ------------------------------------------------------------------ #
    op.create_table(
        "geofence_alerts",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("geofence_id", sa.String(36), nullable=False),
        sa.Column("animal_id", sa.String(36), nullable=False),
        sa.Column("device_id", sa.String(36), nullable=True),
        sa.Column("alert_type", sa.String(20), nullable=False),
        sa.Column("triggered_at", sa.String(50), nullable=False),
        sa.Column("latitude", sa.Float(), nullable=False),
        sa.Column("longitude", sa.Float(), nullable=False),
        sa.Column("acknowledged", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("acknowledged_by", sa.String(36), nullable=True),
        sa.Column("acknowledged_at", sa.String(50), nullable=True),
        sa.Column("created_at", sa.String(50), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["geofence_id"], ["geofences.id"]),
        sa.ForeignKeyConstraint(["device_id"], ["gps_devices.id"]),
        sa.ForeignKeyConstraint(["acknowledged_by"], ["users.id"]),
    )

    # ------------------------------------------------------------------ #
    # 16. procedure_acts
    # ------------------------------------------------------------------ #
    op.create_table(
        "procedure_acts",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("act_number", sa.String(50), nullable=False),
        sa.Column("act_date", sa.Date(), nullable=False),
        sa.Column("region_id", sa.Integer(), nullable=False),
        sa.Column("settlement_name", sa.String(255), nullable=True),
        sa.Column("veterinarian_id", sa.String(36), nullable=False),
        sa.Column("vet_position_kk", sa.String(255), nullable=True),
        sa.Column("vet_position_ru", sa.String(255), nullable=True),
        sa.Column("participants_json", sa.JSON(), nullable=True),
        sa.Column("owner_id", sa.String(36), nullable=True),
        sa.Column("procedure_type", sa.String(50), nullable=False),
        sa.Column("disease_name_kk", sa.String(255), nullable=True),
        sa.Column("disease_name_ru", sa.String(255), nullable=True),
        sa.Column("species_id", sa.Integer(), nullable=False),
        sa.Column("sex_age_group_kk", sa.String(100), nullable=True),
        sa.Column("sex_age_group_ru", sa.String(100), nullable=True),
        sa.Column("male_count", sa.Integer(), nullable=True),
        sa.Column("female_count", sa.Integer(), nullable=True),
        sa.Column("total_animal_count", sa.Integer(), nullable=False, server_default="0"),
        sa.Column("vaccine_name", sa.String(255), nullable=True),
        sa.Column("manufacturer", sa.String(255), nullable=True),
        sa.Column("production_date", sa.Date(), nullable=True),
        sa.Column("series_number", sa.String(100), nullable=True),
        sa.Column("state_control_no", sa.String(100), nullable=True),
        sa.Column("state_control_date", sa.Date(), nullable=True),
        sa.Column("injection_method", sa.String(50), nullable=True),
        sa.Column("injection_location", sa.String(100), nullable=True),
        sa.Column("dose_adult_ml", sa.Numeric(8, 2), nullable=True),
        sa.Column("dose_young_ml", sa.Numeric(8, 2), nullable=True),
        sa.Column("materials_json", sa.JSON(), nullable=True),
        sa.Column("status", sa.String(20), nullable=False, server_default="draft"),
        sa.Column("signed_at", sa.String(50), nullable=True),
        sa.Column("signed_document_url", sa.String(512), nullable=True),
        sa.Column("offline_created", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("synced_at", sa.String(50), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.UniqueConstraint("act_number"),
        sa.ForeignKeyConstraint(["region_id"], ["regions.id"]),
        sa.ForeignKeyConstraint(["veterinarian_id"], ["users.id"]),
        sa.ForeignKeyConstraint(["owner_id"], ["owners.id"]),
        sa.ForeignKeyConstraint(["species_id"], ["animal_species.id"]),
    )

    # ------------------------------------------------------------------ #
    # 17. procedure_act_animals
    # ------------------------------------------------------------------ #
    op.create_table(
        "procedure_act_animals",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("procedure_act_id", sa.String(36), nullable=False),
        sa.Column("animal_id", sa.String(36), nullable=False),
        sa.Column("owner_id", sa.String(36), nullable=False),
        sa.Column("identification_no", sa.String(50), nullable=True),
        sa.Column("species_name_kk", sa.String(100), nullable=True),
        sa.Column("species_name_ru", sa.String(100), nullable=True),
        sa.Column("sex", sa.String(10), nullable=True),
        sa.Column("age_description", sa.String(50), nullable=True),
        sa.Column("color_kk", sa.String(100), nullable=True),
        sa.Column("color_ru", sa.String(100), nullable=True),
        sa.Column("vaccination_date", sa.Date(), nullable=True),
        sa.Column("allergy_skin_measurement_mm", sa.Numeric(5, 2), nullable=True),
        sa.Column("allergy_result_reading_date", sa.Date(), nullable=True),
        sa.Column("allergy_result_mm", sa.Numeric(5, 2), nullable=True),
        sa.Column("allergy_difference_mm", sa.Numeric(5, 2), nullable=True),
        sa.Column("allergy_result", sa.String(20), nullable=True),
        sa.Column("notes", sa.Text(), nullable=True),
        sa.Column("sort_order", sa.Integer(), nullable=False, server_default="0"),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["procedure_act_id"], ["procedure_acts.id"], ondelete="CASCADE"),
        sa.ForeignKeyConstraint(["animal_id"], ["animals.id"]),
        sa.ForeignKeyConstraint(["owner_id"], ["owners.id"]),
    )

    # ------------------------------------------------------------------ #
    # 18. digital_signatures
    # ------------------------------------------------------------------ #
    op.create_table(
        "digital_signatures",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("document_type", sa.String(50), nullable=False),
        sa.Column("document_id", sa.String(36), nullable=False),
        sa.Column("signer_id", sa.String(36), nullable=False),
        sa.Column("signer_iin", sa.String(12), nullable=False),
        sa.Column("signer_name", sa.String(255), nullable=False),
        sa.Column("signature_data", sa.Text(), nullable=False),
        sa.Column("certificate_sn", sa.String(255), nullable=True),
        sa.Column("signed_at", sa.String(50), nullable=False),
        sa.Column("is_valid", sa.Boolean(), nullable=False, server_default="true"),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["signer_id"], ["users.id"]),
    )
    op.create_index("ix_digital_signatures_document_id", "digital_signatures", ["document_id"])

    # ------------------------------------------------------------------ #
    # 19. owner_consents
    # ------------------------------------------------------------------ #
    op.create_table(
        "owner_consents",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("procedure_act_id", sa.String(36), nullable=False),
        sa.Column("owner_id", sa.String(36), nullable=False),
        sa.Column("owner_full_name_kk", sa.String(255), nullable=True),
        sa.Column("owner_full_name_ru", sa.String(255), nullable=True),
        sa.Column("animal_count", sa.Integer(), nullable=True),
        sa.Column("consent_text_kk", sa.Text(), nullable=True),
        sa.Column("consent_text_ru", sa.Text(), nullable=True),
        sa.Column("signature_data", sa.Text(), nullable=True),
        sa.Column("signed_at", sa.String(50), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["procedure_act_id"], ["procedure_acts.id"]),
        sa.ForeignKeyConstraint(["owner_id"], ["owners.id"]),
    )

    # ------------------------------------------------------------------ #
    # 20. inventory_items
    # ------------------------------------------------------------------ #
    op.create_table(
        "inventory_items",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("name_kk", sa.String(255), nullable=True),
        sa.Column("name_ru", sa.String(255), nullable=False),
        sa.Column("category", sa.String(50), nullable=False),
        sa.Column("unit", sa.String(20), nullable=False),
        sa.Column("current_stock", sa.Numeric(10, 2), nullable=False, server_default="0"),
        sa.Column("min_stock_alert", sa.Numeric(10, 2), nullable=True),
        sa.Column("organization_id", sa.String(36), nullable=False),
        sa.Column("manufacturer", sa.String(255), nullable=True),
        sa.Column("batch_number", sa.String(100), nullable=True),
        sa.Column("expiry_date", sa.Date(), nullable=True),
        sa.Column("state_control_no", sa.String(100), nullable=True),
        sa.Column("created_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.Column("updated_at", sa.DateTime(timezone=True), server_default=sa.func.now(), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["organization_id"], ["organizations.id"]),
    )

    # ------------------------------------------------------------------ #
    # 21. inventory_transactions
    # ------------------------------------------------------------------ #
    op.create_table(
        "inventory_transactions",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("item_id", sa.String(36), nullable=False),
        sa.Column("transaction_type", sa.String(20), nullable=False),
        sa.Column("quantity", sa.Numeric(10, 2), nullable=False),
        sa.Column("procedure_act_id", sa.String(36), nullable=True),
        sa.Column("performed_by", sa.String(36), nullable=False),
        sa.Column("notes", sa.Text(), nullable=True),
        sa.Column("created_at", sa.String(50), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["item_id"], ["inventory_items.id"]),
        sa.ForeignKeyConstraint(["procedure_act_id"], ["procedure_acts.id"]),
        sa.ForeignKeyConstraint(["performed_by"], ["users.id"]),
    )

    # ------------------------------------------------------------------ #
    # 22. notifications
    # ------------------------------------------------------------------ #
    op.create_table(
        "notifications",
        sa.Column("id", sa.String(36), nullable=False),
        sa.Column("user_id", sa.String(36), nullable=False),
        sa.Column("title_kk", sa.String(255), nullable=True),
        sa.Column("title_ru", sa.String(255), nullable=True),
        sa.Column("body_kk", sa.Text(), nullable=True),
        sa.Column("body_ru", sa.Text(), nullable=True),
        sa.Column("notification_type", sa.String(50), nullable=False),
        sa.Column("reference_type", sa.String(50), nullable=True),
        sa.Column("reference_id", sa.String(36), nullable=True),
        sa.Column("is_read", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column("sent_at", sa.String(50), nullable=False),
        sa.PrimaryKeyConstraint("id"),
        sa.ForeignKeyConstraint(["user_id"], ["users.id"]),
    )

    # ================================================================== #
    # SEED DATA
    # ================================================================== #

    # --- Roles ---
    op.bulk_insert(
        sa.table(
            "roles",
            sa.column("id", sa.Integer),
            sa.column("name", sa.String),
            sa.column("description_kk", sa.Text),
            sa.column("description_ru", sa.Text),
        ),
        [
            {"id": 1, "name": "admin",       "description_kk": "Жүйе әкімшісі",         "description_ru": "Системный администратор"},
            {"id": 2, "name": "veterinarian","description_kk": "Ветеринарлық дәрігер",   "description_ru": "Ветеринарный врач"},
            {"id": 3, "name": "farmer",      "description_kk": "Фермер / мал иесі",       "description_ru": "Фермер / владелец скота"},
            {"id": 4, "name": "inspector",   "description_kk": "Мемлекеттік инспектор",   "description_ru": "Государственный инспектор"},
            {"id": 5, "name": "lab",         "description_kk": "Зертхана маманы",          "description_ru": "Специалист лаборатории"},
            {"id": 6, "name": "supplier",    "description_kk": "Жабдықтаушы",              "description_ru": "Поставщик"},
        ],
    )

    # --- Permissions ---
    permissions = [
        # Animals
        (1,  "animals:view",             "View animals"),
        (2,  "animals:create",           "Create animals"),
        (3,  "animals:update",           "Update animals"),
        (4,  "animals:delete",           "Delete animals"),
        # Owners
        (5,  "owners:view",              "View owners"),
        (6,  "owners:create",            "Create owners"),
        (7,  "owners:update",            "Update owners"),
        # Procedures
        (8,  "procedures:view",          "View procedure acts"),
        (9,  "procedures:create",        "Create procedure acts"),
        (10, "procedures:sign",          "Sign procedure acts"),
        (11, "procedures:cancel",        "Cancel procedure acts"),
        # Geofences
        (12, "geofences:view",           "View geofences"),
        (13, "geofences:create",         "Create geofences"),
        (14, "geofences:update",         "Update geofences"),
        (15, "geofences:delete",         "Delete geofences"),
        # GPS
        (16, "gps:view",                 "View GPS data"),
        (17, "gps:manage_devices",       "Manage GPS devices"),
        # Dashboard
        (18, "dashboard:view",           "View dashboard"),
        (19, "dashboard:full_stats",     "View full statistics"),
        # Inventory
        (20, "inventory:view",           "View inventory"),
        (21, "inventory:manage",         "Manage inventory"),
        # Users
        (22, "users:view",               "View users"),
        (23, "users:manage",             "Manage users"),
        # Organizations
        (24, "orgs:view",                "View organizations"),
        (25, "orgs:manage",              "Manage organizations"),
        # Documents
        (26, "documents:view",           "View documents"),
        (27, "documents:sign",           "Sign documents"),
        # Sync
        (28, "sync:push",                "Push offline data"),
        (29, "sync:pull",                "Pull server data"),
        # Reports
        (30, "reports:export",           "Export reports"),
    ]
    op.bulk_insert(
        sa.table(
            "permissions",
            sa.column("id", sa.Integer),
            sa.column("codename", sa.String),
            sa.column("description", sa.String),
        ),
        [{"id": pid, "codename": code, "description": desc} for pid, code, desc in permissions],
    )

    # --- Role-Permission mapping ---
    # admin (1): all permissions
    admin_perms = [{"role_id": 1, "permission_id": i} for i in range(1, 31)]

    # veterinarian (2): animals, owners, procedures, geofences, gps, dashboard, inventory, docs, sync, reports
    vet_perms_ids = [1, 2, 3, 5, 6, 7, 8, 9, 10, 12, 13, 14, 16, 18, 20, 21, 26, 27, 28, 29, 30]
    vet_perms = [{"role_id": 2, "permission_id": pid} for pid in vet_perms_ids]

    # farmer (3): own animals, own geofences, own GPS
    farmer_perms_ids = [1, 5, 8, 12, 16, 26, 28, 29]
    farmer_perms = [{"role_id": 3, "permission_id": pid} for pid in farmer_perms_ids]

    # inspector (4): view everything + full stats + reports
    inspector_perms_ids = [1, 5, 8, 12, 16, 18, 19, 26, 29, 30]
    inspector_perms = [{"role_id": 4, "permission_id": pid} for pid in inspector_perms_ids]

    # lab (5): view animals, view procedures, view reports
    lab_perms_ids = [1, 5, 8, 18, 26, 29, 30]
    lab_perms = [{"role_id": 5, "permission_id": pid} for pid in lab_perms_ids]

    # supplier (6): view inventory, manage own inventory
    supplier_perms_ids = [20, 21, 18, 29]
    supplier_perms = [{"role_id": 6, "permission_id": pid} for pid in supplier_perms_ids]

    rp_table = sa.table(
        "role_permissions",
        sa.column("role_id", sa.Integer),
        sa.column("permission_id", sa.Integer),
    )
    op.bulk_insert(rp_table, admin_perms + vet_perms + farmer_perms + inspector_perms + lab_perms + supplier_perms)

    # --- Animal species ---
    op.bulk_insert(
        sa.table(
            "animal_species",
            sa.column("id", sa.Integer),
            sa.column("name_kk", sa.String),
            sa.column("name_ru", sa.String),
            sa.column("code", sa.String),
        ),
        [
            {"id": 1, "name_kk": "Ірі қара мал",    "name_ru": "Крупный рогатый скот (КРС)", "code": "cattle"},
            {"id": 2, "name_kk": "Ұсақ мал (қой)",   "name_ru": "Мелкий рогатый скот (МРС)", "code": "sheep"},
            {"id": 3, "name_kk": "Ешкі",              "name_ru": "Коза",                       "code": "goat"},
            {"id": 4, "name_kk": "Жылқы",             "name_ru": "Лошадь",                     "code": "horse"},
            {"id": 5, "name_kk": "Түйе",              "name_ru": "Верблюд",                    "code": "camel"},
            {"id": 6, "name_kk": "Бұғы",              "name_ru": "Олень",                      "code": "deer"},
            {"id": 7, "name_kk": "Құс",               "name_ru": "Птица",                      "code": "poultry"},
            {"id": 8, "name_kk": "Ет қоректілер",     "name_ru": "Плотоядные",                 "code": "carnivore"},
            {"id": 9, "name_kk": "Басқа",             "name_ru": "Другие",                     "code": "other"},
        ],
    )

    # --- Animal breeds (main breeds for cattle and sheep) ---
    op.bulk_insert(
        sa.table(
            "animal_breeds",
            sa.column("id", sa.Integer),
            sa.column("species_id", sa.Integer),
            sa.column("name_kk", sa.String),
            sa.column("name_ru", sa.String),
            sa.column("code", sa.String),
        ),
        [
            # Cattle breeds
            {"id": 1,  "species_id": 1, "name_kk": "Қазақтың ақбас сиыры", "name_ru": "Казахская белоголовая", "code": "kaz_whitehead"},
            {"id": 2,  "species_id": 1, "name_kk": "Герефорд",              "name_ru": "Герефорд",              "code": "hereford"},
            {"id": 3,  "species_id": 1, "name_kk": "Симментал",             "name_ru": "Симментал",             "code": "simmental"},
            {"id": 4,  "species_id": 1, "name_kk": "Ала тай",               "name_ru": "Голштинская",           "code": "holstein"},
            {"id": 5,  "species_id": 1, "name_kk": "Аулиекөл",              "name_ru": "Аулиекольская",         "code": "auliekol"},
            # Sheep breeds
            {"id": 6,  "species_id": 2, "name_kk": "Қазақтың биязы жүнді",  "name_ru": "Казахский тонкорунный", "code": "kaz_finewool"},
            {"id": 7,  "species_id": 2, "name_kk": "Едільбай",              "name_ru": "Едильбаевская",         "code": "edilbay"},
            {"id": 8,  "species_id": 2, "name_kk": "Қазақтың арқарамерино", "name_ru": "Казахский архаромеринос","code": "kaz_merino"},
            # Horse breeds
            {"id": 9,  "species_id": 4, "name_kk": "Жабы",                 "name_ru": "Жабы (казахская)",      "code": "zhaby"},
            {"id": 10, "species_id": 4, "name_kk": "Адай",                  "name_ru": "Адайская",              "code": "adai"},
        ],
    )

    # --- Seed regions: Kazakhstan oblasts (level 1) ---
    op.bulk_insert(
        sa.table(
            "regions",
            sa.column("id", sa.Integer),
            sa.column("parent_id", sa.Integer),
            sa.column("name_kk", sa.String),
            sa.column("name_ru", sa.String),
            sa.column("level", sa.SmallInteger),
            sa.column("kato_code", sa.String),
            sa.column("boundary_wkt", sa.String),
        ),
        [
            {"id": 1,  "parent_id": None, "name_kk": "Қазақстан Республикасы",     "name_ru": "Республика Казахстан",     "level": 0, "kato_code": "000000000", "boundary_wkt": None},
            {"id": 2,  "parent_id": 1,    "name_kk": "Абай облысы",                 "name_ru": "Область Абай",             "level": 1, "kato_code": "100000000", "boundary_wkt": None},
            {"id": 3,  "parent_id": 1,    "name_kk": "Ақмола облысы",               "name_ru": "Акмолинская область",      "level": 1, "kato_code": "110000000", "boundary_wkt": None},
            {"id": 4,  "parent_id": 1,    "name_kk": "Ақтөбе облысы",               "name_ru": "Актюбинская область",      "level": 1, "kato_code": "150000000", "boundary_wkt": None},
            {"id": 5,  "parent_id": 1,    "name_kk": "Алматы облысы",               "name_ru": "Алматинская область",      "level": 1, "kato_code": "190000000", "boundary_wkt": None},
            {"id": 6,  "parent_id": 1,    "name_kk": "Атырау облысы",               "name_ru": "Атырауская область",       "level": 1, "kato_code": "230000000", "boundary_wkt": None},
            {"id": 7,  "parent_id": 1,    "name_kk": "Шығыс Қазақстан облысы",      "name_ru": "Восточно-Казахстанская область","level": 1, "kato_code": "270000000", "boundary_wkt": None},
            {"id": 8,  "parent_id": 1,    "name_kk": "Жамбыл облысы",               "name_ru": "Жамбылская область",       "level": 1, "kato_code": "310000000", "boundary_wkt": None},
            {"id": 9,  "parent_id": 1,    "name_kk": "Жетісу облысы",               "name_ru": "Область Жетысу",           "level": 1, "kato_code": "320000000", "boundary_wkt": None},
            {"id": 10, "parent_id": 1,    "name_kk": "Батыс Қазақстан облысы",      "name_ru": "Западно-Казахстанская область","level": 1, "kato_code": "270500000", "boundary_wkt": None},
            {"id": 11, "parent_id": 1,    "name_kk": "Қарағанды облысы",            "name_ru": "Карагандинская область",   "level": 1, "kato_code": "350000000", "boundary_wkt": None},
            {"id": 12, "parent_id": 1,    "name_kk": "Қостанай облысы",             "name_ru": "Костанайская область",     "level": 1, "kato_code": "390000000", "boundary_wkt": None},
            {"id": 13, "parent_id": 1,    "name_kk": "Қызылорда облысы",            "name_ru": "Кызылординская область",   "level": 1, "kato_code": "430000000", "boundary_wkt": None},
            {"id": 14, "parent_id": 1,    "name_kk": "Маңғыстау облысы",            "name_ru": "Мангистауская область",    "level": 1, "kato_code": "470000000", "boundary_wkt": None},
            {"id": 15, "parent_id": 1,    "name_kk": "Павлодар облысы",             "name_ru": "Павлодарская область",     "level": 1, "kato_code": "550000000", "boundary_wkt": None},
            {"id": 16, "parent_id": 1,    "name_kk": "Солтүстік Қазақстан облысы",  "name_ru": "Северо-Казахстанская область","level": 1, "kato_code": "590000000", "boundary_wkt": None},
            {"id": 17, "parent_id": 1,    "name_kk": "Түркістан облысы",            "name_ru": "Туркестанская область",    "level": 1, "kato_code": "610000000", "boundary_wkt": None},
            {"id": 18, "parent_id": 1,    "name_kk": "Ұлытау облысы",               "name_ru": "Область Ұлытау",           "level": 1, "kato_code": "620000000", "boundary_wkt": None},
            {"id": 19, "parent_id": 1,    "name_kk": "Алматы қаласы",               "name_ru": "город Алматы",             "level": 1, "kato_code": "750000000", "boundary_wkt": None},
            {"id": 20, "parent_id": 1,    "name_kk": "Астана қаласы",               "name_ru": "город Астана",             "level": 1, "kato_code": "710000000", "boundary_wkt": None},
            {"id": 21, "parent_id": 1,    "name_kk": "Шымкент қаласы",              "name_ru": "город Шымкент",            "level": 1, "kato_code": "790000000", "boundary_wkt": None},
        ],
    )


def downgrade() -> None:
    # Drop in reverse FK dependency order
    op.drop_table("notifications")
    op.drop_table("inventory_transactions")
    op.drop_table("inventory_items")
    op.drop_table("owner_consents")
    op.drop_index("ix_digital_signatures_document_id", table_name="digital_signatures")
    op.drop_table("digital_signatures")
    op.drop_table("procedure_act_animals")
    op.drop_table("procedure_acts")
    op.drop_table("geofence_alerts")
    op.drop_table("geofence_animals")
    op.drop_table("geofences")
    op.drop_index("ix_gps_readings_animal_id", table_name="gps_readings")
    op.drop_index("ix_gps_readings_time", table_name="gps_readings")
    op.drop_table("gps_readings")
    op.drop_table("gps_devices")
    op.drop_index("ix_animals_rfid_tag_no", table_name="animals")
    op.drop_index("ix_animals_microchip_no", table_name="animals")
    op.drop_table("animals")
    op.drop_index("ix_owners_iin", table_name="owners")
    op.drop_table("owners")
    op.drop_table("animal_breeds")
    op.drop_table("animal_species")
    op.drop_table("users")
    op.drop_table("organizations")
    op.drop_table("role_permissions")
    op.drop_table("roles")
    op.drop_table("permissions")
    op.drop_table("regions")
