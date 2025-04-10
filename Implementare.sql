--SA SE AFISEZE DOCTORII SI ATRIBUTELE LOR PENTRU DOCTORII CARE LUCREAZA INTR-UN DEPARTAMENT DINTR-UN SPITAL SPONSORIZAT DE Vidian ,
--CARE AU SALARIUL MAI MARE DECAT MEDIA DINTRE SALARIUL MINIM SI MAXIM DIN DEPARTAMENTUL DIN CARE FAC PARTE.

SELECT CONCAT(CONCAT(d.nume_doctor, ' '), d.prenume_doctor) "Nume Complet", d.cod_departament "Cod departament", d.salariu "Salariu",
d.email "Email", d.experienta "Experienta"
FROM DOCTORI d 
WHERE d.salariu > (SELECT (de.salariu_minim + de.salariu_maxim) / 2 
                   FROM DEPARTAMENTE de, SPITALE s, SPONSORIZEAZA sp
                   WHERE d.cod_departament = de.cod_departament AND de.cod_spital = s.cod_spital AND
                   s.cod_spital = sp.cod_spital AND UPPER(sp.nume_sponsor) = 'VIDIAN'
    );

--in cadrul cererii se utlizeaza o subcerere sincronizata care intervine in 3 tabele(DEPARTAMENTE,SPITALE,SPONSORIZEAZA)
--se folosesc 2 functii aplicate pe siruri de caractere(CONCAT,UPPER)


--SA SE AFISEZE TOATE DEPARTAMENTELE SI ATRIBUTELE LOR,PENTRU DEPARTAMENTELE CARE APARTIN ORICARUI SPITAL AFLAT IN CARTIERUL COLENTINA
--SAU DAMAROAIA ,CARE AU SALARIUL MINIM  2000 DE LEI SI NUMAR MAXIM DE DOCTORI PERMIS MAI MARE DECAT MEDIA TUTUROR
--DEPARTAMENTELOR CARE INDEPLINESC ACELEASI CONDITII(sa apartina unui spital din Colentina sau Damaroaia si sa aiba salariu
--minim  2000 de lei)

WITH departamente_col_dam_ AS (SELECT de.cod_departament, LOWER(de.nume_departament) AS nume_departament, de.cod_spital,
                               de.numar_maxim_doctori, de.salariu_minim, de.salariu_maxim
                               FROM  DEPARTAMENTE de, SPITALE s
                               WHERE de.cod_spital = s.cod_spital AND s.nume_cartier IN ('Colentina', 'Damaroaia')
                               AND de.salariu_minim >= 2000)
SELECT cod_departament  "Cod departament", nume_departament  "Nume departament", cod_spital  "Cod spital",
       numar_maxim_doctori  "Numar maxim de doctori", salariu_minim  "Salariu minim", salariu_maxim  "Salariu maxim"
FROM departamente_col_dam_
WHERE numar_maxim_doctori > (SELECT AVG(numar_maxim_doctori) 
                             FROM departamente_col_dam_);
                             
--se foloseste un bloc de cerere(clauza WITH)
--s-a foloseste o functie pe siruri de caractere(LOWER) si functia de grup AVG


--SA SE AFISEZE DETALIILE INTALNIRILOR DE TIP operatie SAU consultatie(atributele sale + data sa ilustreze ziua,luna,anul),
--UNDE PARTICIPA PACIENTI DE TIP MASCULIN, SI ATRIBUTELE PACIENTILOR RESPECTIVI(nume,prenume,cod si daca este Major sau Minor)
--REALIZATE DE UN DOCTOR CU EXPERIENTA DE PESTE 5 ANI

SELECT 
    aux.cod_pacient "Cod pacient", aux.nume_pacient "Nume pacient",aux.prenume_pacient "Prenume pacient",
    aux.cod_intalnire "Cod intalnire", aux.cod_doctor "Cod doctor", aux.tip_intalnire "Tip intalnire",
    TO_CHAR(aux.data_intalnire, 'DD Month YYYY') "Data intalnire",
    CASE 
        WHEN MONTHS_BETWEEN(SYSDATE, aux.data_nasterii) >= 216 THEN 'Major'
        ELSE 'Minor'
    END AS "Varsta"
FROM (
SELECT p.cod_pacient, p.nume_pacient,
p.prenume_pacient,p.data_nasterii,au.cod_intalnire,au.cod_doctor,au.tip_intalnire,au.data_intalnire
FROM PACIENTI p, AU_INTALNIRE_CU au 
WHERE p.cod_pacient = au.cod_pacient and p.sex = 'M' and upper(au.tip_intalnire) in (upper('Operatie'), upper('Consultatie')))aux,
DOCTORI d
WHERE  d.cod_doctor = aux.cod_doctor and d.experienta > 5;

--in cerere se utilizeaza o subcerere nesincronizata in clauza from
--se folosesc 2 functii pe date calendaristice(MONTHS-BETWEEN si TO_CHAR)
--se foloseste instructiunea Case


-- SA SE AFISEZE CODURILE SI NUMELE SPITALELOR, NUMARUL DE SPONSORI, MEDIA SUMELOR PRIMITE DE LA SPONSORI,
-- SUMA MAXIMA PRIMITA DE LA UN SPONSOR, PENTRU TOATE SPITALELE CARE AU MEDIA DE SPONSORIZARE MAI MARE CA
--MEDIA SALARILOR DOCTORILOR DIN BUCURESTI CARE AU EXPERIENTA DE PESTE 1 AN, LUCREAZA INTR-UN DEPARTAMENT
--CU SALARIUL MINIM PESTE 1500 DE LEI INTR-UN SPITAL INFIINTAT DUPA ANUL 1900
 
SELECT s.cod_spital "Cod spital", s.nume_spital "Nume spital", COUNT(sz.nume_sponsor) "Numar sponsori",
    AVG(sz.suma) "Medie suma", MAX(sz.suma) "Suma maxima"
FROM SPITALE s, SPONSORIZEAZA sz
WHERE s.cod_spital = sz.cod_spital
GROUP BY s.cod_spital, s.nume_spital
HAVING AVG(sz.suma) > (SELECT AVG(d.salariu)
FROM DOCTORI d, DEPARTAMENTE de, SPITALE sp
where d.cod_departament = de.cod_departament and de.cod_spital = sp.cod_spital and d.experienta > 1 and de.salariu_minim >1500 and sp.an_infiintare > 1900);
                       
                       
                       
        
--gruparile de date se realizeaza prin group by
--se folosesc functuiile de grup COUNT,AVG,MAX
--Filtrarea la nivel de grupuri se realizeaza prin HAVING care include o subcerere nesincronizata care
--intervine in 3 tabele(DOCTORI,DEPARTAMENTE,SPITALE)


--SA SE AFISEZE SPONSORII SI ATRIBUTELE LOR + TIPUL DE FIRMA(IN FUNCTIE DE VECHIME)
--CARE AU MEDIA DE SPONSORIZARE mai mica DE 6200 DE LEI SI MAI mare DE 1000 DE LEI

 
SELECT s.nume_sponsor "Nume sponsor", s.nume_actionar1 || ' ' || s.prenume_actionar1 "Actionar 1",
    s.nume_actionar2 || ' ' || s.prenume_actionar2 "Actionar 2", NVL(s.telefon, 'Num?r de telefon lips?') "telefon",
    DECODE(s.vechime,0,'Firma noua',1, 'Firma in crestere', 2, 'Firma consolidata', 3, 'Firma solida', 'Firma veche'
    ) "Firma"
FROM SPONSORI s, (SELECT  nume_sponsor
                  FROM SPONSORIZEAZA
                  GROUP BY nume_sponsor
                  HAVING AVG(suma) < 6200 and AVG(suma)>1000) aux
WHERE s.nume_sponsor = aux.nume_sponsor
ORDER BY vechime DESC;

--se foloseste ordonarea in functie de vechime
--se folosesc functiile NVL si DECODE


--SA SE MAREASCA CU 10% SALARIILE DOCTORILOR CARE AU AVUT CEL PUTIN O INTALNIRE DE TIp OPERATIE
UPDATE DOCTORI
SET salariu = salariu * 1.1
WHERE cod_doctor IN (
    SELECT DISTINCT cod_doctor
    FROM AU_INTALNIRE_CU
    WHERE tip_intalnire = 'operatie'
);
rollback;


--SA SE SCADA CU 1 NUMARUL MAXIM DE DOCTORI IN DEPARTAMENTELE DINTR-UN SPITAL DIN COLENTINA SAU CARE AU
--CEL PUTIN UN DOCTOR CARE ARE EXPERIENTA DE PESTE 5 ANI
UPDATE DEPARTAMENTE
SET numar_maxim_doctori = numar_maxim_doctori - 1
WHERE cod_spital IN (SELECT cod_spital
                     FROM SPITALE
                     WHERE nume_cartier = 'Colentina'
)
OR cod_departament IN (SELECT DISTINCT cod_departament
                       FROM DOCTORI
                       WHERE experienta > 5
);
rollback;

--SA SE STEARGA SPONSORII CARE NU FAC NICIO SPONSORIZARE
DELETE FROM SPONSORI
WHERE nume_sponsor NOT IN (
    SELECT distinct nume_sponsor
    FROM SPONSORIZEAZA
);

rollback;
commit;



