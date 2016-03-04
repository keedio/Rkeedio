#' A function to delete a Blob file, it doesn't work if snapshots are available for the blob
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS ket to access the blob"
#' @param name "name of the blob"
#' @export 
azureDeleteBlob <- function (sa,container,key, name) {
url <- paste("https://",sa,".blob.core.windows.net/",container,'/',name,sep="")
res<-azureBlobCall(url, "DELETE", key)
return(res)
}
