#   file <- "030_curl_neovim.md"

# =================================================
# https://nazarii.bardiuk.com/posts/vim-curl.html

#   CAUTION:   run this and will replace this file with result

#   PURPOSE:    cool way to filter buffer content and run with curl
#   USAGE:      COPY to SCRATCH BUFFER
#	======================================

#   
#		SELF-contained.   use this to run curl at neovim ex line:
#		Uses curl's  --config feature, to read directly from buffer rather than a file.

#   The solo - means to use buffer contents
#   Filter is like  ! sort

#   CAUTION:   run this and will replace this file with result

# =================================================
# :nnoremap <leader>cc vipyPgvO<Esc>O<Esc>gv:!curl --config -<CR>
# =================================================

--url http://httpbin.org
--get
--header  "User-Agent: vim/curl"
--silent
--show-error
--data a=b
--data-urlencode "c=a+b"
--data '{"name" : "jim"}'
-w %{http_connect}
#run the command (will change BUFFER contents)

#   no output
#   -o  /dev/null
    -o  saved 

# NOTE the %
#     :%!curl --config -





