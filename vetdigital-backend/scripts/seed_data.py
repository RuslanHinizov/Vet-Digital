"""
Seed script: populates initial data for VetDigital.
Includes Kazakhstan regions (oblasts), animal species/breeds, roles/permissions.

Run with: python scripts/seed_data.py
"""
import asyncio
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from app.config import settings
from app.models.base import Base
from app.models.user import Role, Permission, RolePermission, Organization, User
from app.models.region import Region
from app.models.animal import AnimalSpecies, AnimalBreed
from app.core.permissions import ROLE_PERMISSIONS, Role as RoleEnum, Permission as PermEnum
from app.core.security import hash_password


# Kazakhstan regions (14 oblasts + 3 cities of republican significance)
KAZAKHSTAN_REGIONS = [
    # Level 1 - Oblasts
    {"name_kk": "Ақмола облысы", "name_ru": "Акмолинская область", "level": 1, "kato_code": "110000000"},
    {"name_kk": "Ақтөбе облысы", "name_ru": "Актюбинская область", "level": 1, "kato_code": "150000000"},
    {"name_kk": "Алматы облысы", "name_ru": "Алматинская область", "level": 1, "kato_code": "190000000"},
    {"name_kk": "Атырау облысы", "name_ru": "Атырауская область", "level": 1, "kato_code": "230000000"},
    {"name_kk": "Батыс Қазақстан облысы", "name_ru": "Западно-Казахстанская область", "level": 1, "kato_code": "270000000"},
    {"name_kk": "Жамбыл облысы", "name_ru": "Жамбылская область", "level": 1, "kato_code": "310000000"},
    {"name_kk": "Жетісу облысы", "name_ru": "Жетысуская область", "level": 1, "kato_code": "330000000"},
    {"name_kk": "Қарағанды облысы", "name_ru": "Карагандинская область", "level": 1, "kato_code": "350000000"},
    {"name_kk": "Қостанай облысы", "name_ru": "Костанайская область", "level": 1, "kato_code": "390000000"},
    {"name_kk": "Қызылорда облысы", "name_ru": "Кызылординская область", "level": 1, "kato_code": "430000000"},
    {"name_kk": "Маңғыстау облысы", "name_ru": "Мангистауская область", "level": 1, "kato_code": "470000000"},
    {"name_kk": "Павлодар облысы", "name_ru": "Павлодарская область", "level": 1, "kato_code": "550000000"},
    {"name_kk": "Солтүстік Қазақстан облысы", "name_ru": "Северо-Казахстанская область", "level": 1, "kato_code": "590000000"},
    {"name_kk": "Түркістан облысы", "name_ru": "Туркестанская область", "level": 1, "kato_code": "610000000"},
    {"name_kk": "Ұлытау облысы", "name_ru": "Улытауская область", "level": 1, "kato_code": "630000000"},
    {"name_kk": "Шығыс Қазақстан облысы", "name_ru": "Восточно-Казахстанская область", "level": 1, "kato_code": "630000001"},
    # Cities of republican significance
    {"name_kk": "Астана қ.", "name_ru": "г. Астана", "level": 1, "kato_code": "710000000"},
    {"name_kk": "Алматы қ.", "name_ru": "г. Алматы", "level": 1, "kato_code": "750000000"},
    {"name_kk": "Шымкент қ.", "name_ru": "г. Шымкент", "level": 1, "kato_code": "790000000"},
]

# Animal species matching iszh.gov.kz classification
ANIMAL_SPECIES = [
    {"name_kk": "Ірі қара мал", "name_ru": "Крупный рогатый скот (КРС)", "code": "cattle"},
    {"name_kk": "Ұсақ мал (қой)", "name_ru": "Мелкий рогатый скот - овцы (МРС)", "code": "sheep"},
    {"name_kk": "Ұсақ мал (ешкі)", "name_ru": "Мелкий рогатый скот - козы (МРС)", "code": "goat"},
    {"name_kk": "Жылқы", "name_ru": "Лошади", "code": "horse"},
    {"name_kk": "Түйе", "name_ru": "Верблюды", "code": "camel"},
    {"name_kk": "Маралдар", "name_ru": "Маралы (олени)", "code": "deer"},
    {"name_kk": "Құстар", "name_ru": "Птицы", "code": "poultry"},
    {"name_kk": "Ет қоректілер (ит)", "name_ru": "Плотоядные - собаки", "code": "dog"},
    {"name_kk": "Ет қоректілер (мысық)", "name_ru": "Плотоядные - кошки", "code": "cat"},
    {"name_kk": "Басқалар", "name_ru": "Другие", "code": "other"},
]

# Common cattle breeds in Kazakhstan
CATTLE_BREEDS = [
    {"name_ru": "Казахская белоголовая", "name_kk": "Қазақтың ақ бастысы", "code": "kaz_whiteface"},
    {"name_ru": "Герефорд", "name_kk": "Герефорд", "code": "hereford"},
    {"name_ru": "Симментальская", "name_kk": "Симментал", "code": "simmental"},
    {"name_ru": "Казахская мясная", "name_kk": "Қазақ етті", "code": "kaz_meat"},
    {"name_ru": "Аулиекольская", "name_kk": "Әулиекөл", "code": "auliekol"},
    {"name_ru": "Алатауская", "name_kk": "Алатау", "code": "alatau"},
    {"name_ru": "Черно-пестрая", "name_kk": "Қара ала", "code": "blackwhite"},
    {"name_ru": "Смешанная/Беспородная", "name_kk": "Аралас", "code": "mixed"},
]

# Roles matching the permission system
ROLES_DATA = [
    {"name": "admin", "description_kk": "Жүйе әкімшісі", "description_ru": "Администратор системы"},
    {"name": "veterinarian", "description_kk": "Ветеринар дәрігер", "description_ru": "Ветеринарный врач"},
    {"name": "farmer", "description_kk": "Фермер/Малшы", "description_ru": "Фермер/Скотовод"},
    {"name": "inspector", "description_kk": "Мемлекеттік инспектор", "description_ru": "Государственный инспектор"},
    {"name": "lab", "description_kk": "Зертхана мамандары", "description_ru": "Сотрудник лаборатории"},
    {"name": "supplier", "description_kk": "Жеткізуші", "description_ru": "Поставщик (фармацевтика)"},
]


async def seed():
    engine = create_async_engine(settings.DATABASE_URL, echo=False)
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    async_session = async_sessionmaker(engine, expire_on_commit=False)

    async with async_session() as session:
        print("Seeding roles and permissions...")
        # Create permissions
        perm_map = {}
        for perm in PermEnum:
            p = Permission(codename=perm.value, description=perm.value)
            session.add(p)
            perm_map[perm.value] = p
        await session.flush()

        # Create roles
        role_map = {}
        for role_data in ROLES_DATA:
            r = Role(**role_data)
            session.add(r)
            role_map[role_data["name"]] = r
        await session.flush()

        # Assign permissions to roles
        for role_enum, perms in ROLE_PERMISSIONS.items():
            role = role_map.get(role_enum.value)
            if not role:
                continue
            for perm_enum in perms:
                perm = perm_map.get(perm_enum.value)
                if perm:
                    session.add(RolePermission(role_id=role.id, permission_id=perm.id))
        await session.flush()

        print("Seeding Kazakhstan regions...")
        for region_data in KAZAKHSTAN_REGIONS:
            region = Region(**region_data)
            session.add(region)
        await session.flush()

        print("Seeding animal species and breeds...")
        species_map = {}
        for sp_data in ANIMAL_SPECIES:
            sp = AnimalSpecies(**sp_data)
            session.add(sp)
            species_map[sp_data["code"]] = sp
        await session.flush()

        # Add cattle breeds
        cattle = species_map.get("cattle")
        if cattle:
            for breed_data in CATTLE_BREEDS:
                breed = AnimalBreed(species_id=cattle.id, **breed_data)
                session.add(breed)

        # Create demo admin organization
        org = Organization(
            bin="100000000004",
            name_ru="Министерство сельского хозяйства РК",
            name_kk="ҚР Ауыл шаруашылығы министрлігі",
            org_type="gov_agency",
        )
        session.add(org)
        await session.flush()

        # Create demo admin user
        admin_role = role_map.get("admin")
        admin = User(
            iin="000000000001",  # Demo IIN
            full_name_ru="Администратор Системы",
            full_name_kk="Жүйе Әкімшісі",
            role_id=admin_role.id,
            organization_id=org.id,
            password_hash=hash_password("Admin@2025!"),
            language_pref="ru",
            is_active=True,
        )
        session.add(admin)

        await session.commit()
        print("Seed data inserted successfully!")
        print("\nDemo admin credentials:")
        print("  IIN: 000000000001")
        print("  Password: Admin@2025!")
        print("  Role: admin")

    await engine.dispose()


if __name__ == "__main__":
    asyncio.run(seed())
