% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/azureBlobCall.R
\name{azureBlobCall}
\alias{azureBlobCall}
\title{A function to call Azure Blob using httr}
\usage{
azureBlobCall(url, verb, key, requestBody = NULL, headers = NULL,
  ifMatch = "", md5 = "", verbose = FALSE)
}
\arguments{
\item{url}{url of the blob}

\item{verb}{"PUT GET CREATE DELETE"}

\item{key}{"SAS ket to access the blob"}
}
\description{
A function to call Azure Blob using httr
}

