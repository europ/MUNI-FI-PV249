# [PV249 - Development in Ruby](https://is.muni.cz/predmet/fi/podzim2019/PV249)

### Lectures

1. Entrance test
2. Simple IRC server in rails
3. Ruby basics (language type, syntax, OOP, conventions)
4. Git / GitHub / GitLab (commands, tips and tricks, best practices)
5.
6.
7.
8.
9.
10.
11.
12.
13.

### Exercises

* form of consultations, not mandatory

1.
2. Installing Ruby
3. Commissioning simple IRC server in rails
4. Project 1. - MiniHub
5.
6.
7.
8.
9.
10.
11.
12.
13.

### Projects

1. **MiniHub** (Simple GitHub as an Rails application)
2.
3.

### MiniHub

Zadání první fáze projektu:
* V adresáři `rails` vytvořte jednoduchou Rails aplikaci `MuniHub` která bude umět:
  * Registrování nových uživatelů (zadání jména, loginu, hesla s potvrzením)
  * Přihlašování existujících uživatelů
  * Vytváření repozitářů (jenom jednoduchý model bez napojení na skutečný git repozitář)
  * Jednoduchý ticketovací systém (issues)
* Požadované atributy modelu:
  * User: name:String, email:String, password_hash: String, password_salt:String
  * Repository: name:String
  * Issue: subject: String, text: String
* Vazby:
  * User : Repository 1:N
  * Repository : Issue 1:N
  * User : Issue 1:N (author)
* Omezení:
  * User.login bude obsahovat jenom [a-z] znaky
* Všechny fáze projektu budou v jednom repositáři, dbejte tedy na pojmenování podaresářů v projektu podle zadání úkolu (zde `rails`).
