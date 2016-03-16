#' A function to get a file from a  Blob  container and store it in memory.
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS key to access the blob"
#' @param file "File to upload"
#' @param verbose(optional) "set to TRUE to get full information about the REST call"
#' @export 
azureGetBlob <- function (sa,container,key, file, verbose = FALSE) {
url <- paste("https://",sa,".blob.core.windows.net/",container,'/',basename(file),sep="")
res<-azureBlobCall(url, "GET", key, verbose = verbose)
return(res)
}
