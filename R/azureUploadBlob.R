#' A function to upload a file to a Blob container,  
#' inside the container the file will keep the same name
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS ket to access the blob"
#' @param file "File to upload"
#' @param verbose(optional) "set to TRUE to get full information about the REST call"
#' @export 
azureUploadBlob <- function (sa,container,key, file, verbose = FALSE) {
url <- paste("https://",sa,".blob.core.windows.net/",container,'/',basename(file),sep="")
res<-azureBlobCall(url, "PUT", key, headers = c("x-ms-blob-type"="BlockBlob"), requestBody = upload_file(file), verbose = verbose)
return(res)
}
