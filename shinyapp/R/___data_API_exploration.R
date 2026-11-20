

# election pipeline
# - Résultats généraux : contient les chiffres de participation, de votes blancs et nuls, par bureau de vote, pour chaque élection.
# - Résultats par candidat : contient les résultats des votes pour chaque candidat par bureau de vote.
# Les deux tables sont rapprochables par les colonnes id_election et id_brut_miom

# url params
base <- "https://tabular-api.data.gouv.fr"
endpoint <- "api/resources/%s/data"
dataset <- "b8703c69-a18f-46ab-9e7f-3a8368dcb891"

# query
param <- list(page = 1,
              page_size = 20,
              id_election__exact = "2022_pres_t1",
              code_commune__exact = "39300")

# build url
url <- paste(base, sprintf(endpoint, dataset), sep = "/")

# add query parameters
param <- paste(names(param), param, sep = "=", collapse = "/&")
url <- paste(url, param, sep = "?")

# call API
res <- iker::with_cache(
  iker::call_api(url, header = list()),
  timeout = 24,
  encrypt = FALSE)

iker::call_api(url = "https://tabular-api.data.gouv.fr/api/resources/b8703c69-a18f-46ab-9e7f-3a8368dcb891/data/?page=1&page_size=20&id_election__exact=2022_pres_t1&code_commune__exact=39300", header = list())
