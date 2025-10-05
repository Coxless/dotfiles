# gitブランチ名取得関数
def get_git_branch [] {
    if (".git" | path exists) {
        let branch = (git rev-parse --abbrev-ref HEAD | str trim)
        if $branch == "HEAD" { "" } else { $branch }
    } else {
        ""
    }
}


# プロンプト作成関数（ディレクトリ名 + ブランチ名）
def create_left_prompt [] {
    let user = ($env.USERNAME? | default $env.USER)
    let dir = ($env.PWD | path basename)
    let branch = get_git_branch
    if ($branch != "") {
        $"(ansi blue)<($user)>(ansi reset) (ansi green_bold)($dir)(ansi reset) (ansi yellow)[($branch)](ansi reset)"
    } else {
        $"(ansi blue)<($user)>(ansi reset) (ansi green_bold)($dir)(ansi reset)"
    }
}

# プロンプトコマンド設定
$env.PROMPT_COMMAND = {create_left_prompt}
