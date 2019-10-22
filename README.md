# [PV249 - Development in Ruby](https://is.muni.cz/predmet/fi/podzim2019/PV249)

### Lectures

1. Entrance test
2. Simple IRC server in rails
3. Ruby basics (language type, syntax, OOP, conventions)
4. Git / GitHub / GitLab (commands, tips and tricks, best practices)
5. Advanced Ruby
    * https://github.com/adamruzicka/advanced-ruby
6. Unit testing
7.
8.
9.
10.
11.
12.
13.

### Exercises

* form of consultations, not mandatory

1. (canceled)
2. Installing Ruby and its further parts (bundler, gems, etc.)
3. Commissioning a simple IRC server in rails
4. (free)
5. (free)
6. (free)
7.
8.
9.
10.
11.
12.
13.

### Projects

Simple MiniHub application (subset of GitHub or GitLab) divided into three separate parts:

1. Rails
    * deadline: 20.10.2019
    * specifications: [here](#minihub---rails)
2. CLI
    * deadline:
    * specifications: [here](#minihub---cli)
3. Sinatra
    * deadline:
    * specifications: [here](#minihub---sinatra)

### MiniHub - Rails

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

### MiniHub - CLI

TODO

### MiniHub - Sinatra

TODO
