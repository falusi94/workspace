" Example local-rc with test exection in Docker

" Vim test
function! AppDockerTransform(cmd) abort
    return "~/bin/docker_exec -p app-run -i 'docker compose run --rm --no-deps -d app bash' -c ".shellescape(a:cmd)
endfunction

let g:test#custom_transformations = {'app_docker': function('AppDockerTransform')}
let g:test#transformation = 'app_docker'
