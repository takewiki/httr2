% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oauth-flow-auth-code.R
\name{oauth_flow_auth_code}
\alias{oauth_flow_auth_code}
\alias{oauth_flow_auth_code_url}
\alias{oauth_flow_auth_code_listen}
\alias{oauth_flow_auth_code_parse}
\alias{oauth_flow_auth_code_pkce}
\title{OAuth flow: authorization code}
\usage{
oauth_flow_auth_code(
  client,
  auth_url,
  scope = NULL,
  pkce = TRUE,
  auth_params = list(),
  token_params = list(),
  redirect_uri = "http://localhost",
  host_name = deprecated(),
  host_ip = deprecated(),
  port = deprecated()
)

oauth_flow_auth_code_url(
  client,
  auth_url,
  redirect_uri = NULL,
  scope = NULL,
  state = NULL,
  auth_params = list()
)

oauth_flow_auth_code_listen(redirect_uri = "http://localhost:1410")

oauth_flow_auth_code_parse(query, state)

oauth_flow_auth_code_pkce()
}
\arguments{
\item{client}{An \code{\link[=oauth_client]{oauth_client()}}.}

\item{auth_url}{Authorization url; you'll need to discover this by reading
the documentation.}

\item{scope}{Scopes to be requested from the resource owner.}

\item{pkce}{Use "Proof Key for Code Exchange"? This adds an extra layer of
security and should always be used if supported by the server.}

\item{auth_params}{List containing additional parameters passed to \code{oauth_flow_auth_code_url()}}

\item{token_params}{List containing additional parameters passed to the
\code{token_url}.}

\item{redirect_uri}{URL to redirect back to after authorization is complete.
Often this must be registered with the API in advance.

httr2 supports two forms of redirect. Firstly, you can use a \code{localhost}
url (the default), where httr2 will set up a temporary webserver to listen
for the OAuth redirect. In this case, httr2 will automatically append a
random port. If you need to set it to a fixed port because the API requires
it, then specify it with (e.g.) \code{"http://localhost:1011"}. This technique
works well when you are working on your own computer.

Alternatively, you can provide a URL to a website that uses javascript to
give the user a code to copy and paste back into the R session (see
\url{https://www.tidyverse.org/google-callback/} and
\url{https://github.com/r-lib/gargle/blob/main/inst/pseudo-oob/google-callback/index.html}
for examples). This is less convenient (because it requires more
user interaction) but also works in hosted environments.}

\item{host_name, host_ip, port}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}
Now use \code{redirect_uri} instead.}

\item{state}{Random state generated by \code{oauth_flow_auth_code()}. Used to
verify that we're working with an authentication request that we created.
(This is an unlikely threat for R packages since the webserver that
listens for authorization responses is transient.)}

\item{query}{List of query parameters returned by \code{oauth_flow_auth_code_listen()}.}
}
\value{
An \link{oauth_token}.
}
\description{
These functions implement the OAuth authorization code flow, as defined
by \href{https://datatracker.ietf.org/doc/html/rfc6749#section-4.1}{rfc6749},
Section 4.1. This is the most commonly used OAuth flow where the user is
opens a page in their browser, approves the access, and then returns to R.

\code{oauth_flow_auth_code()} is a high-level wrapper that should work with APIs
that adhere relatively closely to the spec. When possible, it redirects the
browser back to a temporary local webserver to capture the authorization
code. When this is not possible (e.g. when running on a hosted platform
like RStudio Server) set \code{type = "web"} to instead prompts the user to enter
the code manually instead.

The remaining low-level functions can be used to assemble a custom flow for
APIs that are further from the spec:
\itemize{
\item \code{oauth_flow_auth_code_url()} generates the url that should be opened in a
browser.
\item \code{oauth_flow_auth_code_listen()} starts a temporary local webserver that
listens for the response from the resource server.
\item \code{oauth_flow_auth_code_parse()} parses the query parameters returned from
the server redirect, verifying that the \code{state} is correct, and returning
the authorisation code.
\item \code{oauth_flow_auth_code_pkce()} generates code verifier, method, and challenge
components as needed for PKCE, as defined in
\href{https://datatracker.ietf.org/doc/html/rfc7636}{rfc7636}.
}
}
\examples{
client <- oauth_client(
  id = "28acfec0674bb3da9f38",
  secret = obfuscated(paste0(
     "J9iiGmyelHltyxqrHXW41ZZPZamyUNxSX1_uKnv",
     "PeinhhxET_7FfUs2X0LLKotXY2bpgOMoHRCo"
  )),
  token_url = "https://github.com/login/oauth/access_token",
  name = "hadley-oauth-test"
)
if (interactive()) {
  token <- oauth_flow_auth_code(client, auth_url = "https://github.com/login/oauth/authorize")
  token
}
}
\seealso{
Other OAuth flows: 
\code{\link{oauth_flow_bearer_jwt}()},
\code{\link{oauth_flow_client_credentials}()},
\code{\link{oauth_flow_device}()},
\code{\link{oauth_flow_password}()},
\code{\link{oauth_flow_refresh}()}
}
\concept{OAuth flows}
\keyword{internal}
