#' A function to save a data structure into a  Blob  container.
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS key to access the blob"
#' @param file "Filename"
#' @param data "Datastructure to be saved"
#' @param verbose(optional) "set to TRUE to get full information about the REST call" 
#' @export 
azurePutBlob <- function (sa,container,key, file, data, verbose = FALSE) {
url <- paste("https://",sa,".blob.core.windows.net/",container,'/',basename(file),sep="")
res<-azureBlobCall(url, "PUT", key, headers = c("x-ms-blob-type"="BlockBlob"), requestBody = data, verbose = verbose)
return(res)
}
