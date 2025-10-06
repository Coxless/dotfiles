# gitブランチ名取得関数
def get_git_branch [] {
    if (".git" | path exists) {
        let branch = (git rev-parse --abbrev-ref HEAD | str trim)
        if $branch == "HEAD" { "" } else { $branch }
    } else {
        ""
    }
}

def get_user [] {
  whoami | str trim
}

def create_left_prompt [] {
  let user = get_user
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
