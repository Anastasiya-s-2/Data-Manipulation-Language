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
VALUES (1, 'knife', 'right thumb – suspect A');
-- =====================================================================
-- CЦЕНА 3: Уточнення виду зброї
--======================================================================
UPDATE Evidence
SET weapon_type = 'axe'
WHERE evidence_id = 1;
--======================================================================
--СЦЕНА 4:SELECT і MERGE — перевірка та узгодження фактів
--======================================================================
--Перевірка на узгодження даних
SELECT witness_id, weapon_type, fingerprint, date_submitted
FROM Evidence;
-- MERGE приклад
MERGE INTO Evidence
USING (VALUES (1, 'axe', 'left thumb – suspect A'))
ON Evidence.witness_id = 1
WHEN MATCHED THEN
  UPDATE SET fingerprint = 'left thumb – suspect A'
WHEN NOT MATCHED THEN
  INSERT (witness_id, weapon_type, fingerprint)
  VALUES (1, 'axe', 'left thumb – suspect A');
-- ======================================================================
-- СЦЕНА 5. DELETE доказу
-- ======================================================================
DELETE FROM Evidence
WHERE evidence_id = 1;
-- ======================================================================
-- СЦЕНА 6. Додаткова справа з наркотиками
-- ======================================================================
--Сворення таблиці для зберігання cправи про наркотики
-- ======================================================================
CREATE TABLE DrugCases (
    case_id SERIAL PRIMARY KEY,
    case_name VARCHAR(255) NOT NULL,
    suspect VARCHAR(100) NOT NULL,
    evidence VARCHAR(255) NOT NULL,
    search_result VARCHAR(255),
    confiscated_items VARCHAR(255),
    cpc_article VARCHAR(50),
    prosecutor_note VARCHAR(255)
);
-- ======================================================================
-- Створено запис про обшук, підозрюваного та речові докази.
-- ======================================================================
INSERT INTO DrugCases (case_name, suspect, evidence, search_result, confiscated_items, cpc_article)
VALUES ('Обшук у квартирі Хапка Р.C.', 'Хапко Р.C.', 'Пакет із порошком', 'Ймовірно наркотики', 'Пакет із порошком', 'ст. 234 КПК');
-- =======================================================================
--Результат оновлено відповідно до експертизи
-- =======================================================================
UPDATE DrugCases
SET search_result = 'Наркотики підтверджені', 
    prosecutor_note = 'Експертиза підтвердила заборонену речовину'
WHERE suspect = 'Хапко Р.C.';
--=========================================================================
--SELECT для перевірки допустимості даних
--==========================================================================
SELECT suspect, evidence, search_result, prosecutor_note, cpc_article
FROM DrugCases
WHERE suspect = 'Хапко Р.C.';
--===========================================================================
--Додаємо оновлені дані через MERGE
--===========================================================================
MERGE INTO DrugCases
USING (VALUES ('Хапко Р.C.', 'Пакет із таблетками')) AS src(suspect, evidence)
ON DrugCases.suspect = src.suspect
WHEN MATCHED THEN
  UPDATE SET evidence = src.evidence
WHEN NOT MATCHED THEN
  INSERT (case_name, suspect, evidence, cpc_article)
  VALUES ('Додатковий обшук', src.suspect, src.evidence, 'ст. 236 КПК');
-- ======================================================================
--Видаляємо непотрібний запис--
-- ======================================================================
DELETE FROM DrugCases
WHERE search_result = 'Ймовірно наркотики';*/
-- ======================================================================
-- СЦЕНА 7. Вирок
-- ======================================================================
CREATE TABLE Cases (
    case_id INT PRIMARY KEY,
    case_date DATE NOT NULL,
    plaintiff VARCHAR(100) NOT NULL,
    defendant VARCHAR(100) NOT NULL,
    verdict VARCHAR(255)
);
-- ======================================================================
--Вставляємо дані в таблицю
-- ======================================================================
INSERT INTO Cases (case_id, case_date, plaintiff, defendant, verdict)
VALUES (321, '2025-10-20', 'Прокурор', 'Підсудний', NULL);
-- ======================================================================
--Вносимо рішення суду
-- ======================================================================
UPDATE Cases
SET verdict = 'Винний за ч.1 ст.115 КК. Вирок набрав чинності'
WHERE case_id = 321;
-- ======================================================================
--Вирок
-- ======================================================================
SELECT * FROM Cases;