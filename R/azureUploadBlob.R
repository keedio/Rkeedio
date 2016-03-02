#' A function to upload a file to a Blob  container
#' @param sa "Azure Storage Account"
#' @param container "Name of the container"
#' @param key "SAS ket to access the blob"
#' @param file "File to upload"
#' azureUploadBlob()
azureUploadBlob <- function (sa,container,key, file) {
url <- paste("https://",sa,".blob.core.windows.net/",container,'/',basename(file),sep="")
res<-azureBlobCall(url, "PUT", key, headers = c("x-ms-blob-type"="BlockBlob"), requestBody = upload_file(file))
return(res)
}
