"""
Kazakhstan-specific data validators.
IIN, BIN, microchip numbers, phone numbers.
"""
import re
from typing import Optional


def validate_iin(iin: str) -> tuple[bool, Optional[str]]:
    """
    Validate Kazakhstan IIN (Individual Identification Number).
    12 digits, checksum validated.
    """
    if not iin or not iin.isdigit() or len(iin) != 12:
        return False, "IIN должен содержать 12 цифр"

    weights1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    weights2 = [3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2]

    digits = [int(d) for d in iin]
    checksum = sum(w * d for w, d in zip(weights1, digits[:11])) % 11
    if checksum == 10:
        checksum = sum(w * d for w, d in zip(weights2, digits[:11])) % 11

    if checksum != digits[11]:
        return False, "Неверная контрольная сумма ИИН"

    return True, None


def validate_bin(bin_str: str) -> tuple[bool, Optional[str]]:
    """
    Validate Kazakhstan BIN (Business Identification Number).
    12 digits, 5th digit ∈ {4,5,6}.
    """
    if not bin_str or not bin_str.isdigit() or len(bin_str) != 12:
        return False, "БИН должен содержать 12 цифр"
    if bin_str[4] not in ("4", "5", "6"):
        return False, "5-я цифра БИН должна быть 4, 5 или 6"
    return True, None


def validate_microchip(chip: str) -> tuple[bool, Optional[str]]:
    """
    Validate TROVAN/ISO 11784 microchip number.
    15-digit decimal or hex format (e.g. '643094100123456').
    """
    chip = chip.strip().upper().replace(" ", "")
    # 15-digit decimal
    if chip.isdigit() and len(chip) == 15:
        return True, None
    # Hex format (e.g. from RFID readers: '643_094100123456')
    if re.match(r"^[0-9A-F]{15}$", chip):
        return True, None
    return False, "Номер микрочипа должен содержать 15 символов (цифры или HEX)"


def validate_kz_phone(phone: str) -> tuple[bool, Optional[str]]:
    """
    Validate Kazakhstan phone number.
    Formats: +77XXXXXXXXX, 87XXXXXXXXX, 7XXXXXXXXX (11 digits).
    """
    phone = re.sub(r"[\s\-\(\)]", "", phone)
    if phone.startswith("+7"):
        phone = phone[2:]
    elif phone.startswith("8"):
        phone = "7" + phone[1:]

    if not phone.isdigit() or len(phone) != 11 or not phone.startswith("7"):
        return False, "Укажите казахстанский номер телефона (+7XXXXXXXXXX)"

    return True, None


def validate_rfid_tag(tag: str) -> tuple[bool, Optional[str]]:
    """
    Validate animal RFID ear tag number.
    Format: KZ-YYYY-XXXXXXXXX (country code + year + serial).
    """
    tag = tag.strip().upper()
    if re.match(r"^[A-Z]{2}-\d{4}-\d+$", tag):
        return True, None
    # Also accept plain numeric tags
    if tag.isdigit() and 6 <= len(tag) <= 20:
        return True, None
    return False, "Неверный формат RFID метки (ожидается KZ-YYYY-XXXXXXXXX или цифровой)"


def normalize_iin(iin: str) -> str:
    """Strip non-digits and pad to 12."""
    return re.sub(r"\D", "", iin).zfill(12)[:12]
