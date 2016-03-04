#' A function to call Azure Blob using httr

#' @param url url of the blob
#' @param verb "PUT GET CREATE DELETE" 
#' @param key "SAS ket to access the blob"
#' @export
azureBlobCall <- function(url, verb, key, requestBody=NULL, headers=NULL, ifMatch="", md5="") { 
  urlcomponents <- httr::parse_url(url)
  account <- gsub(".blob.core.windows.net", "", urlcomponents$hostname, fixed = TRUE)
  container <- urlcomponents$path

  # get timestamp in us locale
  lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "us")
  `x-ms-date` <- format(Sys.time(),"%a, %d %b %Y %H:%M:%S %Z", tz="GMT")
  Sys.setlocale("LC_TIME", lct)

  # if requestBody exist get content length in bytes and content type
  `Content-Length` <- ""; `Content-Type` <- ""
  if(!is.null(requestBody)) {
    if(class(requestBody) == "form_file") {
      `Content-Length` <- (file.info(requestBody$path))$size
      `Content-Type` <- requestBody$type 
    } else {
      requestBody <- enc2utf8(as.character(requestBody))
      `Content-Length` <- nchar(requestBody, "bytes")
      `Content-Type` <- "text/plain; charset=UTF-8" 
    }
  } 

  # combine timestamp and version headers with any input headers, order and create the CanonicalizedHeaders
  headers <- setNames(c(`x-ms-date`, "2015-04-05",  unlist(headers)), 
                      c("x-ms-date", "x-ms-version", unclass(names(unlist(headers)))))
  headers <- headers[order(names(headers))]
  CanonicalizedHeaders <- paste(names(headers), headers, sep=":", collapse = "\n")

  # create CanonicalizedResource headers and add any queries to it
  if(!is.null(urlcomponents$query)) {
    components <- setNames(unlist(urlcomponents$query), unclass(names(unlist(urlcomponents$query))))
    componentstring <- paste0("\n", paste(names(components[order(names(components))]),
                                          components[order(names(components))], sep=":", collapse = "\n"))
  } else componentstring <- ""
  CanonicalizedResource <- paste0("/",account,"/",container, componentstring)

  # create the authorizationtoken
  signaturestring <- paste0(verb, "\n\n\n", `Content-Length`, "\n", md5, "\n", `Content-Type`, "\n\n\n", 
                            ifMatch, "\n\n\n\n", CanonicalizedHeaders, "\n", CanonicalizedResource)

  requestspecificencodedkey <- RCurl::base64(
    digest::hmac(key=RCurl::base64Decode(key, mode="raw"),
                 object=enc2utf8(signaturestring),
                 algo= "sha256", raw=TRUE)
  )

  authorizationtoken <- paste0("SharedKey ", account, ":", requestspecificencodedkey)

  # make the call
  headers_final <- add_headers(Authorization=authorizationtoken, headers, `Content-Type` = `Content-Type`)
  call <- httr::VERB(verb=verb, url=url, config=headers_final, body=requestBody, verbose())

  print("signaturestring");print(signaturestring); 
  print(headers_final); print(call)
  return(content(call))
}
