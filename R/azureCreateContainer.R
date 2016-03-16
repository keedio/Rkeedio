#' A function to create a Blob  container
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS key to access the blob"
#' @param verbose(optional) "set to TRUE to get full information about the REST call"
#' @export 
azureCreateContainer <- function (sa,container,key,verbose = FALSE) {
url <- paste("https://",sa,".blob.core.windows.net/",container,"?restype=container",sep="")
res<-azureBlobCall(url, "PUT", key, verbose = verbose)
return(res)
}
