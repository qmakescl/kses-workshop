# 워크숍 환경 점검 (Windows PowerShell)
# 사용법: powershell -ExecutionPolicy Bypass -File scripts\check_env.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$script:ok = 0; $script:fail = 0
function Pass($name, $msg) { Write-Host ("  [OK]   {0,-12} {1}" -f $name, $msg) -ForegroundColor Green; $script:ok++ }
function Miss($name, $msg) { Write-Host ("  [없음] {0,-12} {1}" -f $name, $msg) -ForegroundColor Yellow; $script:fail++ }

function Check($name, $cmd, $hint) {
  $c = Get-Command $cmd -ErrorAction SilentlyContinue
  if ($c) {
    $v = (& $cmd --version 2>&1 | Select-Object -First 1)
    Pass $name "$v"
  } else {
    Miss $name $hint
  }
}

Write-Host "== 프로그램 =="
Check "Git"     "git"     "사전 준비 안내의 Git 설치 영상 참고"
Check "uv"      "uv"      "사전 준비 안내의 uv 설치 영상 참고"
Check "R"       "Rscript" "https://cran.r-project.org 에서 설치 후 PATH 에 R\bin 추가"
Check "Node.js" "node"    "nvm install lts ; nvm use lts"
Check "nvm"     "nvm"     "nvm-windows 설치 (사전 준비 안내 참고)"
Check "VS Code" "code"    "VS Code 재설치 시 'PATH에 추가' 옵션 선택"

Write-Host ""
Write-Host "== R 패키지 =="
if (Get-Command Rscript -ErrorAction SilentlyContinue) {
  $rcode = @'
pk <- c("tidyverse","readxl","haven","janitor","gtsummary","gt","broom","MatchIt","languageserver","httpgd")
ok <- vapply(pk, requireNamespace, logical(1), quietly = TRUE)
for (p in pk) cat(sprintf("  [%s] %s\n", if (ok[[p]]) "OK  " else "MISS", p))
if (!all(ok)) cat("  -> Rscript scripts/install_r_packages.R\n")
'@
  Rscript -e $rcode 2>$null
} else {
  Write-Host "  R 이 없어 건너뜀"
}

Write-Host ""
Write-Host "== VS Code 확장 =="
if (Get-Command code -ErrorAction SilentlyContinue) {
  $exts = (code --list-extensions 2>$null) | ForEach-Object { $_.ToLower() }
  foreach ($e in @("ms-python.python", "reditorsupport.r")) {
    if ($exts -contains $e) { Pass $e "" } else { Miss $e "code --install-extension $e" }
  }
  if ($exts | Where-Object { $_ -like "*antigravity*" }) { Pass "Antigravity" "" } else { Miss "Antigravity" "사전 준비 안내의 Antigravity 확장 영상 참고" }
} else {
  Write-Host "  code 명령이 없어 건너뜀"
}

Write-Host ""
Write-Host "== 폴더 =="
if (Test-Path "..\private-data") { Pass "private-data" "저장소 바깥에 있음" } else { Write-Host "  [참고] ..\private-data 없음 (개인 데이터를 가져온 경우에만 필요)" }

Write-Host ""
Write-Host ("결과: OK {0} / 없음 {1}" -f $script:ok, $script:fail)
