CREATE SEQUENCE seq_departamente
INCREMENT BY 10
START WITH 100
MAXVALUE 999
NOCYCLE;

CREATE SEQUENCE seq_doctori2
INCREMENT BY 10
START WITH 101
MAXVALUE 999
NOCYCLE;

CREATE SEQUENCE seq_pacienti2
INCREMENT BY 10
START WITH 102
MAXVALUE 999
NOCYCLE;

CREATE SEQUENCE seq_au_intalnire_cu
INCREMENT BY 1
START WITH 1
MAXVALUE 999
NOCYCLE;

CREATE TABLE SPITALE (
    cod_spital VARCHAR2(3) CONSTRAINT spitale_pk PRIMARY KEY,
    nume_spital VARCHAR2(50) NOT NULL,
    adresa_spital VARCHAR2(50) NOT NULL,
    nume_cartier VARCHAR2(20) NOT NULL,
    an_infiintare NUMBER(4) NOT NULL,
    telefon VARCHAR2(10) NOT NULL
);

INSERT INTO SPITALE (cod_spital, nume_spital, adresa_spital, nume_cartier, an_infiintare, telefon)
VALUES ('SCC', 'Spitalul Clinic Colentina', 'Soseaua Stefan Cel Mare 19-21', 'Colentina', 1858, '021317245');

INSERT INTO SPITALE (cod_spital, nume_spital, adresa_spital, nume_cartier, an_infiintare, telefon)
VALUES ('SGA', 'Spitalul pentru copii Grigore Alexandrescu', 'Bulevardul Iancu de Hunedoara 30', 'Damaroaia', 1858, '0213169366');

INSERT INTO SPITALE (cod_spital, nume_spital, adresa_spital, nume_cartier, an_infiintare, telefon)
VALUES ('ICF', 'Institutul Clinic Fundeni', 'Soseaua Fundeni 258', 'Colentina', 1959, '0212750500');

INSERT INTO SPITALE (cod_spital, nume_spital, adresa_spital, nume_cartier, an_infiintare, telefon)
VALUES ('SCU', 'Spitalul Clinic de Urgenta', 'Calea Floreasca 8', 'Floreasca', 1934, '0215992300');

INSERT INTO SPITALE (cod_spital, nume_spital, adresa_spital, nume_cartier, an_infiintare, telefon)
VALUES ('SUE', 'Spitalul Universitar de Urgenta Elias', 'Bulevardul Marasti 17', 'Aviatorilor', 1936, '0213161600');

CREATE TABLE SPONSORI (
    nume_sponsor VARCHAR2(20) CONSTRAINT sponsori_pk PRIMARY KEY,
    nume_actionar1 VARCHAR2(20) NOT NULL,
    nume_actionar2 VARCHAR2(20) NOT NULL,
    prenume_actionar1 VARCHAR2(20) NOT NULL,
    prenume_actionar2 VARCHAR2(20) NOT NULL,
    telefon VARCHAR2(10),
    vechime NUMBER(2) NOT NULL
);
INSERT INTO SPONSORI (nume_sponsor, nume_actionar1, nume_actionar2, prenume_actionar1, prenume_actionar2, telefon, vechime)
VALUES ('Orange', 'Ioan', 'Muscalu', 'Antonio', 'Muscalu', '0770448919', 10);

INSERT INTO SPONSORI (nume_sponsor, nume_actionar1, nume_actionar2, prenume_actionar1, prenume_actionar2, telefon, vechime)
VALUES ('Vidian', 'Ioan', 'Voinea', 'Antonio', 'Andrei', '0770448904', 3);

INSERT INTO SPONSORI (nume_sponsor, nume_actionar1, nume_actionar2, prenume_actionar1, prenume_actionar2, telefon, vechime)
VALUES ('Best', 'Dinica', 'Dinica', 'Maria', 'Magda', '0734806145', 2);

INSERT INTO SPONSORI (nume_sponsor, nume_actionar1, nume_actionar2, prenume_actionar1, prenume_actionar2, telefon, vechime)
VALUES ('Aronia', 'Georgescu', 'Dician', 'Marian', 'Nicoleta', '0787686006', 4);

INSERT INTO SPONSORI (nume_sponsor, nume_actionar1, nume_actionar2, prenume_actionar1, prenume_actionar2, vechime)
VALUES ('Filips', 'Ion', 'Noe', 'Filip', 'Eugen', 1);

CREATE TABLE SPONSORIZEAZA (
    nume_sponsor VARCHAR2(20),
    cod_spital VARCHAR2(3),
    suma NUMBER(7) NOT NULL,
    CONSTRAINT sponsorizeaza_fk_sponsor FOREIGN KEY (nume_sponsor) REFERENCES SPONSORI(nume_sponsor),
    CONSTRAINT sponsorizeaza_fk_spital FOREIGN KEY (cod_spital) REFERENCES SPITALE(cod_spital),
    CONSTRAINT sponsorizeaza_pk PRIMARY KEY (nume_sponsor, cod_spital)
);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Vidian', 'SCC', 5000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Vidian', 'SGA', 6000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Vidian', 'ICF', 7000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Orange', 'SCC', 1000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Orange', 'SCU', 12000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Best', 'SCC', 9000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Best', 'SGA', 3000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Best', 'SCU', 5000);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Best', 'ICF', 7500);

INSERT INTO SPONSORIZEAZA (nume_sponsor, cod_spital, suma)
VALUES ('Filips', 'SCC', 2500);

CREATE TABLE DEPARTAMENTE (
    cod_departament NUMBER(3) CONSTRAINT departamente_pk PRIMARY KEY,
    nume_departament VARCHAR2(20) NOT NULL,
    cod_spital VARCHAR2(3) NOT NULL,
    numar_maxim_doctori NUMBER(3) NOT NULL,
    salariu_minim NUMBER(7) NOT NULL,
    salariu_maxim NUMBER(7) NOT NULL,
    CONSTRAINT departamente_fk_spital FOREIGN KEY (cod_spital) REFERENCES SPITALE(cod_spital)
);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Chirurgie', 'SCC', 50, 2500, 15000);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Ortopedie', 'SCC', 50, 1500, 9000);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Neurologie', 'SGA', 45, 3000, 6000);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Ortopedie', 'SGA', 5, 5000, 20000);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Radiologie', 'ICF', 25, 1000, 8000);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Cardiologie', 'ICF', 30, 1200, 7600);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Cardiologie', 'SCU', 10, 4500, 12000);

INSERT INTO DEPARTAMENTE (cod_departament, nume_departament, cod_spital, numar_maxim_doctori, salariu_minim, salariu_maxim)
VALUES (seq_departamente.NEXTVAL, 'Pediatrie', 'SUE', 90, 2300, 8400);

CREATE TABLE DOCTORI (
    cod_doctor NUMBER(3) CONSTRAINT doctori_pk PRIMARY KEY,
    cod_departament NUMBER(3) NOT NULL,
    nume_doctor VARCHAR2(20) NOT NULL,
    prenume_doctor VARCHAR2(20) NOT NULL,
    salariu NUMBER(7) NOT NULL,
    email VARCHAR2(50),
    experienta NUMBER(2) NOT NULL,
    CONSTRAINT doctori_fk_departament FOREIGN KEY (cod_departament) REFERENCES DEPARTAMENTE(cod_departament)
);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 100, 'Popescu', 'Alex', 9000, 'alexp@gmail.com', 10);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 100, 'Ionescu', 'Maria', 8000, 'mariai@gmail.com', 9);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 110, 'Neagu', 'Andrei', 2500, 'andrein@gmail.com', 3);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 110, 'Stoica', 'Gabriel', 3000, 'gabriels@gmail.com',3);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 120, 'Mihai', 'Ioana', 3500, 'ioanam@gmail.com', 6);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 120, 'Tudor', 'Vlad', 4000, 'vladt@gmail.com', 1);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 130, 'Constantinescu', 'Elena', 8000, 'elenac@gmail.com', 6);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 140, 'Stanescu', 'Mihai', 1200, 'mihais@gmail.com', 2);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 150, 'Radu', 'Diana', 3500, 'dianar@gmail.com',9);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 150, 'Marinescu', 'Raluca',5000, 'ralucam@gmail.com', 11);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 160, 'Florescu', 'Andreea', 6000, 'andreeaf@gmail.com', 4);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 160, 'Vasile', 'Robert', 7000, 'robertv@gmail.com', 8);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 170, 'Popa', 'Cristina', 3000, 'cristinap@gmail.com', 2);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 170, 'Radulescu', 'Ion', 2900, 'ionr@gmail.com', 1);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 160, 'Dragomir', 'George', 5000, 'georged@gmail.com', 7);

INSERT INTO DOCTORI (cod_doctor, cod_departament, nume_doctor, prenume_doctor, salariu, email, experienta)
VALUES (seq_doctori2.NEXTVAL, 110, 'Dumitrescu', 'Ana', 3000, 'anad@gmail.com', 2);

CREATE TABLE PACIENTI (
    cod_pacient NUMBER(3) CONSTRAINT pacienti_pk PRIMARY KEY,
    nume_pacient VARCHAR2(20) NOT NULL,
    prenume_pacient VARCHAR2(20) NOT NULL,
    sex CHAR(1) NOT NULL,
    telefon VARCHAR2(10),
    email VARCHAR2(50),
    data_nasterii DATE
);
INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Popescu', 'Andrei', 'M', '0701234567', 'andreipop@gmail.com',  to_date('13-03-1990','DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Mihai', 'Elena', 'F', '0712345678', 'elenam@gmail.com', to_date('20-01-2000', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Ionescu', 'Ion', 'M', '0723456789', 'ionion@gmail.com', to_date('10-10-2010', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Radu', 'Maria', 'F', '0734567890', 'mariarad@gmail.com', to_date('02-02-2001', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Dumitrescu', 'George','M', '0745678901', 'gd@gmail.com', to_date('05-10-2009', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Vasile', 'Ana', 'F', '0756789012', 'anavasile@gmail.com', to_date('20-12-1980', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Stan', 'Alexandru', 'M', '0767890123', 'alxs@gmail.com', to_date('04-11-2003', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Neagu', 'Florin', 'M', '0778901234', 'fl7@gmail.com', to_date('29-07-1956', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Banu', 'Sebastian', 'M', '0770448907', 'bsebica@gmail.com', to_date('12-03-2002', 'DD-MM-YYYY'));

INSERT INTO PACIENTI (cod_pacient, nume_pacient, prenume_pacient, sex, telefon, email, data_nasterii)
VALUES (seq_pacienti2.NEXTVAL, 'Gheorghe', 'George', 'M', '0776884709', 'ggggg@gmail.com', to_date('01-01-2015', 'DD-MM-YYYY'));





CREATE TABLE AU_INTALNIRE_CU (
    cod_doctor NUMBER(3),
    cod_pacient NUMBER(3),
    cod_intalnire NUMBER(3),
    data_intalnire DATE NOT NULL,
    tip_intalnire VARCHAR2(15) NOT NULL,
    CONSTRAINT au_intalnire_cu_fk_doctor FOREIGN KEY (cod_doctor) REFERENCES DOCTORI(cod_doctor),
    CONSTRAINT au_intalnire_cu_fk_pacient FOREIGN KEY (cod_pacient) REFERENCES PACIENTI(cod_pacient),
    CONSTRAINT au_intalnire_cu_pk PRIMARY KEY (cod_doctor, cod_pacient, cod_intalnire)
);

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (101, 182, seq_au_intalnire_cu.NEXTVAL, to_date('10-06-2024', 'DD-MM-YYYY'), 'operatie');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (111, 102, seq_au_intalnire_cu.NEXTVAL, to_date('11-06-2024', 'DD-MM-YYYY'), 'recuperare');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (201, 122, seq_au_intalnire_cu.NEXTVAL, to_date('12-06-2024', 'DD-MM-YYYY'), 'consultatie');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (161, 112, seq_au_intalnire_cu.NEXTVAL, to_date('12-06-2024', 'DD-MM-YYYY'), 'operatie');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (171, 172, seq_au_intalnire_cu.NEXTVAL, to_date('13-06-2024', 'DD-MM-YYYY'), 'recuperare');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (181, 192, seq_au_intalnire_cu.NEXTVAL, to_date('13-06-2024', 'DD-MM-YYYY'), 'consultatie');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (131, 132, seq_au_intalnire_cu.NEXTVAL, to_date('14-06-2024', 'DD-MM-YYYY'), 'consultatie');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (191, 162, seq_au_intalnire_cu.NEXTVAL, to_date('15-06-2024', 'DD-MM-YYYY'), 'consultatie');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (201, 152, seq_au_intalnire_cu.NEXTVAL, to_date('15-06-2024', 'DD-MM-YYYY'), 'recuperare');

INSERT INTO AU_INTALNIRE_CU (cod_doctor, cod_pacient, cod_intalnire, data_intalnire, tip_intalnire)
VALUES (221, 102, seq_au_intalnire_cu.NEXTVAL, to_date('16-06-2024', 'DD-MM-YYYY'), 'recuperare');

commit;