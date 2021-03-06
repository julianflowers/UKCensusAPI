#' UKCensusAPI
#'
#' R package for creating, and modifying, automated downloads of UK census data. See below for an overview of the package.
#'
#' It requires that you register with www.nomisweb.co.uk and obtain an API key,
#' whiBch should be stored in your .Renviron as "NOMIS_API_KEY", e.g.
#'
#' \samp{NOMIS_API_KEY=0x0123456789abcdef0123456789abcdef01234567}

#' See README.md for detailed information and examples.
#'
#' @section Overview:
#' Nomisweb, run by Durham University, provides online access to the most detailed and up-to-date statistics from official sources for local areas throughout the UK, including census data.
#' This package provides both a python and an R wrapper around the nomisweb census data API, enabling:
#'
#' \itemize{
#'  \item querying table metadata
#'  \item autogenerating customised python and R query code for future use
#'  \item automated cached data downloads
#'  \item modifying the geography of queries
#'  \item adding descriptive information to tables (from metadata)
#'}
#'
#' Queries can be customised on geographical coverage, geographical resolution, and table fields, the latter can be filtered to include only the category values you require.
#' The package generates reusable code snippets that can be inserted into applications. Such applications will work seamlessly for any user as long as they have installed this package, and possess their own nomisweb API key.
#' Since census data is essentially static, it makes little sense to download the data every time it is requested: all data downloads are cached.

#' @example inst/examples/geoquery.R
#' @example inst/examples/contextify.R

#' @section Functions:
#' \code{\link{geoCodeLookup}}
#'
#' \code{\link{geoCodes}}
#'
#' \code{\link{getData}}
#'
#' \code{\link{getLADCodes}}
#'
#' \code{\link{getMetadata}}
#'
#' \code{\link{instance}}
#'
#' \code{\link{queryInstance}}
#'
#' \code{\link{queryMetadata}}
#'
#' \code{\link{contextify}}
#'
#' @docType package
#' @name UKCensusAPI
NULL

Api <- NULL
Query <- NULL

.onLoad <- function(libname, pkgname) {
  Api <<- reticulate::import("ukcensusapi.Nomisweb", delay_load = TRUE)
  Query <<- reticulate::import("ukcensusapi.Query", delay_load = TRUE)
}

#' get an instance of the python API (required to call any of the functions)
#'
#' @param cacheDir directory to cache data
#' @return an instance of the ukcensusweb api
#' @export
instance = function(cacheDir) {
  # TODO can we have a function-static variable here?
  api = Api$Nomisweb(cacheDir)
  return(api)
}

#' get an instance of the python query (required to call any of the functions)
#'
#' @param api an instance of the ukcensusapi
#' @return an instance of the query module
#' @export
queryInstance = function(api) {
  # TODO can we have a function-static variable here?
  query = Query$Query(api)
  return(query)
}
