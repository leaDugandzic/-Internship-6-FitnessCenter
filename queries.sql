SELECT 
    t.FirstName, 
    t.LastName, 
    CASE 
        WHEN t.Gender = 'Male' THEN 'MALE'
        WHEN t.Gender = 'Female' THEN 'FEMALE'
        ELSE 'OTHER' 
    END AS Gender,
    c.Name AS CountryName, 
    c.AverageSalary
FROM Trainer t
JOIN Country c ON t.CountryID = c.CountryID;
