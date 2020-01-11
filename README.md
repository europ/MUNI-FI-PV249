# [PV249 - Development in Ruby](https://is.muni.cz/predmet/fi/podzim2019/PV249)

### Projects

The project had to be developed on GitLab. Each part stated below had to be submitted as a separate merge request. In the case that the merge request met the criteria (it was accepted by the teachers) the merge request was merged into the `master` branch. Branch `master` from GitLab is available in this repository under the acronym [`master_gitlab`](https://github.com/europ/MUNI-FI-PV249/tree/master_gitlab). The work history is available in [`master`](https://github.com/europ/MUNI-FI-PV249/tree/master) on GitHub.

Simple MuniHub application (subset of GitHub or GitLab) divided into three separate parts:

1. Rails
    * deadline: 20.10.2019
    * specifications: [here](#munihub---rails)
2. CLI
    * deadline:
    * specifications: [here](#munihub---cli)
3. Sinatra
    * deadline:
    * specifications: [here](#munihub---sinatra)

### MuniHub - Rails

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

### MuniHub - CLI

See [`cli/README.md`](cli/README.md)

### MuniHub - Sinatra

See [`sinatra/README.md`](sinatra/README.md)
