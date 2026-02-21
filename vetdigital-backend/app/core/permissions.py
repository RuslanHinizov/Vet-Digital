from enum import Enum


class Role(str, Enum):
    ADMIN = "admin"
    VETERINARIAN = "veterinarian"
    FARMER = "farmer"
    INSPECTOR = "inspector"
    LAB = "lab"
    SUPPLIER = "supplier"


class Permission(str, Enum):
    # Animal permissions
    ANIMAL_READ = "animal:read"
    ANIMAL_CREATE = "animal:create"
    ANIMAL_UPDATE = "animal:update"
    ANIMAL_DELETE = "animal:delete"
    ANIMAL_READ_ALL = "animal:read_all"

    # Owner permissions
    OWNER_READ = "owner:read"
    OWNER_CREATE = "owner:create"
    OWNER_UPDATE = "owner:update"
    OWNER_READ_ALL = "owner:read_all"

    # Procedure permissions
    PROCEDURE_READ = "procedure:read"
    PROCEDURE_CREATE = "procedure:create"
    PROCEDURE_SIGN = "procedure:sign"
    PROCEDURE_READ_ALL = "procedure:read_all"
    PROCEDURE_AUDIT = "procedure:audit"

    # Geofence permissions
    GEOFENCE_READ = "geofence:read"
    GEOFENCE_MANAGE = "geofence:manage"
    GEOFENCE_READ_ALL = "geofence:read_all"

    # GPS permissions
    GPS_READ = "gps:read"
    GPS_READ_ALL = "gps:read_all"
    GPS_DEVICE_MANAGE = "gps:device_manage"

    # Document permissions
    DOCUMENT_READ = "document:read"
    DOCUMENT_SIGN = "document:sign"
    DOCUMENT_READ_ALL = "document:read_all"

    # Dashboard permissions
    DASHBOARD_VIEW = "dashboard:view"
    DASHBOARD_FULL = "dashboard:full"

    # Inventory permissions
    INVENTORY_READ = "inventory:read"
    INVENTORY_MANAGE = "inventory:manage"
    INVENTORY_READ_ALL = "inventory:read_all"

    # User management
    USER_MANAGE = "user:manage"

    # Lab specific
    LAB_RESULTS_MANAGE = "lab:results_manage"
    LAB_STATS = "lab:stats"

    # Supplier specific
    SUPPLY_MANAGE = "supply:manage"
    SUPPLY_STATS = "supply:stats"


# Permission matrix: Role -> list of permissions
ROLE_PERMISSIONS: dict[Role, list[Permission]] = {
    Role.ADMIN: list(Permission),  # Admin has all permissions

    Role.VETERINARIAN: [
        Permission.ANIMAL_READ,
        Permission.ANIMAL_CREATE,
        Permission.ANIMAL_UPDATE,
        Permission.OWNER_READ,
        Permission.OWNER_CREATE,
        Permission.PROCEDURE_READ,
        Permission.PROCEDURE_CREATE,
        Permission.PROCEDURE_SIGN,
        Permission.GEOFENCE_READ,
        Permission.GEOFENCE_MANAGE,
        Permission.GPS_READ,
        Permission.DOCUMENT_READ,
        Permission.DOCUMENT_SIGN,
        Permission.DASHBOARD_VIEW,
        Permission.INVENTORY_READ,
        Permission.INVENTORY_MANAGE,
    ],

    Role.FARMER: [
        Permission.ANIMAL_READ,
        Permission.ANIMAL_UPDATE,
        Permission.OWNER_READ,
        Permission.PROCEDURE_READ,
        Permission.GEOFENCE_READ,
        Permission.GEOFENCE_MANAGE,
        Permission.GPS_READ,
        Permission.DOCUMENT_READ,
        Permission.DOCUMENT_SIGN,
    ],

    Role.INSPECTOR: [
        Permission.ANIMAL_READ,
        Permission.ANIMAL_READ_ALL,
        Permission.OWNER_READ,
        Permission.OWNER_READ_ALL,
        Permission.PROCEDURE_READ,
        Permission.PROCEDURE_READ_ALL,
        Permission.PROCEDURE_AUDIT,
        Permission.GEOFENCE_READ,
        Permission.GEOFENCE_READ_ALL,
        Permission.GPS_READ,
        Permission.GPS_READ_ALL,
        Permission.DOCUMENT_READ,
        Permission.DOCUMENT_READ_ALL,
        Permission.DOCUMENT_SIGN,
        Permission.DASHBOARD_VIEW,
        Permission.DASHBOARD_FULL,
        Permission.INVENTORY_READ,
        Permission.INVENTORY_READ_ALL,
    ],

    Role.LAB: [
        Permission.ANIMAL_READ,
        Permission.ANIMAL_READ_ALL,
        Permission.PROCEDURE_READ,
        Permission.PROCEDURE_READ_ALL,
        Permission.DOCUMENT_READ,
        Permission.DOCUMENT_SIGN,
        Permission.LAB_RESULTS_MANAGE,
        Permission.LAB_STATS,
        Permission.INVENTORY_READ,
        Permission.INVENTORY_MANAGE,
    ],

    Role.SUPPLIER: [
        Permission.INVENTORY_READ,
        Permission.INVENTORY_MANAGE,
        Permission.SUPPLY_MANAGE,
        Permission.SUPPLY_STATS,
        Permission.DOCUMENT_READ,
        Permission.DOCUMENT_SIGN,
    ],
}


def get_role_permissions(role: Role) -> list[Permission]:
    return ROLE_PERMISSIONS.get(role, [])


def has_permission(role: Role, permission: Permission) -> bool:
    return permission in get_role_permissions(role)
