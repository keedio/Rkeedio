#' A function to take a snapshot of a given  Blob 
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS ket to access the blob"
#' @param name "Name of the blob"
#' @export 
azureSnapshotBlob <- function (sa,container,key, name) {
url <- paste("https://",sa,".blob.core.windows.net/",container,'/',name,'?comp=snapshot',sep="")
res<-azureBlobCall(url, "PUT", key)
return(res)
}
