# can print all url details

    Code
      url_parse("http://user:pass@example.com:80/path?a=1&b=2&c={1{2}3}#frag")
    Message
      <httr2_url> http://user:pass@example.com:80/path?a=1&b=2&c=%7B1%7B2%7D3%7D#frag
      * scheme: http
      * hostname: example.com
      * username: user
      * password: pass
      * port: 80
      * path: /path
      * query:
        * a: 1
        * b: 2
        * c: {1{2}3}
      * fragment: frag

# password also requires username

    Code
      url_build(url)
    Condition
      Error in `url_build()`:
      ! Cannot set url `password` without `username`.

# validates inputs

    Code
      query_build(1:3)
    Condition
      Error:
      ! Query must be a named list.
    Code
      query_build(list(x = 1:2, y = 1:3))
    Condition
      Error:
      ! Query parameters must be length 1 atomic vectors.
      * Problems: "x" and "y".

