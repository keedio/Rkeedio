#' A function to get a file from a  Blob  container
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS key to access the blob"
#' @param file "File to upload"
#' azureGetBlob()
azureGetBlob <- function (sa,container,key, file) {
url <- paste("https://",sa,".blob.core.windows.net/",container,'/',basename(file),sep="")
res<-azureBlobCall(url, "GET", key)
return(res)
}
