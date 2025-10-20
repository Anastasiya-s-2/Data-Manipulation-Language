--====================================================================
--СЦЕНА 1
--Cтворення таблиці, що міститиме дані про свідка
--====================================================================
/*CREATE TABLE Witness (
    witness_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    initials VARCHAR(10) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    date_of_birth DATE NOT NULL
);
-- ====================================================================
-- Перший INSERT (дані про свідка). Помилка прокурора
-- =====================================================================
INSERT INTO Witness (full_name, phone, date_of_birth)
VALUES ('Пендерецька Інна', '0671112233', '26 червня');
-- =====================================================================
-- Змінений INSERT (дані про свідка)
-- =====================================================================
INSERT INTO Witness (initials, full_name, phone, date_of_birth)

VALUES ('I.O', 'Пендерецька Інна Олегівна', '0671112233', '2006-06-26');
-- =====================================================================
--СЦЕНА 2
-- =====================================================================
CREATE TABLE Evidence (
    evidence_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    witness_id INT NOT NULL REFERENCES Witness(witness_id),
    weapon_type VARCHAR(50),
    fingerprint VARCHAR(100) not null,
    date_submitted DATE DEFAULT CURRENT_DATE
);
-- =====================================================================
-- INSERT (дані про доказ)
-- =====================================================================
INSERT INTO Evidence (witness_id, weapon_type, fingerprint)
VALUES (1, 'knife', 'right thumb – suspect A');*/
-- =====================================================================
-- Cцена 3: Уточнення виду зброї
--======================================================================
UPDATE Evidence
SET weapon_type = 'axe'
WHERE evidence_id = 1;
