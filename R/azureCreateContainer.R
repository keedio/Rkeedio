#' A function to create a Blob  container
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS ket to access the blob"
#' @export 
azureCreateContainer <- function (sa,container,key) {
url <- paste("https://",sa,".blob.core.windows.net/",container,"?restype=container",sep="")
res<-azureBlobCall(url, "PUT", key)
return(res)
}
