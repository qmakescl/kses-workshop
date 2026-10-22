#!/usr/bin/env bash
# 워크숍 환경 점검 (macOS / Linux)
# 사용법: bash scripts/check_env.sh

ok=0; fail=0
pass() { printf "  [OK]   %-12s %s\n" "$1" "$2"; ok=$((ok+1)); }
miss() { printf "  [없음] %-12s %s\n" "$1" "$2"; fail=$((fail+1)); }

# nvm 은 셸 함수라서 스크립트에서 직접 불러와야 한다
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

echo "== 프로그램 =="
check() {
  local name="$1" cmd="$2" hint="$3"
  if command -v "$cmd" >/dev/null 2>&1; then
    pass "$name" "$("$cmd" --version 2>&1 | head -n 1)"
  else
    miss "$name" "$hint"
  fi
}
check "Git"     git     "사전 준비 안내의 Git 설치 영상 참고"
check "uv"      uv      "사전 준비 안내의 uv 설치 영상 참고"
check "R"       Rscript "https://cran.r-project.org 에서 설치"
check "Node.js" node    "nvm install --lts"
if command -v nvm >/dev/null 2>&1; then pass "nvm" "$(nvm --version)"; else miss "nvm" "사전 준비 안내의 nvm 설치 영상 참고"; fi
check "VS Code" code    "VS Code 명령 팔레트 > 'Shell Command: Install code command in PATH'"

echo
echo "== R 패키지 =="
if command -v Rscript >/dev/null 2>&1; then
  Rscript -e '
pk <- c("tidyverse","readxl","haven","janitor","gtsummary","gt","broom","MatchIt","languageserver","httpgd")
ok <- vapply(pk, requireNamespace, logical(1), quietly = TRUE)
for (p in pk) cat(sprintf("  [%s] %s\n", if (ok[[p]]) "OK  " else "없음", p))
if (!all(ok)) cat("  -> Rscript scripts/install_r_packages.R 를 실행하세요\n")
' 2>/dev/null
else
  echo "  R 이 없어 건너뜀"
fi

echo
echo "== VS Code 확장 =="
if command -v code >/dev/null 2>&1; then
  exts="$(code --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]')"
  for e in ms-python.python reditorsupport.r; do
    if echo "$exts" | grep -qx "$e"; then pass "$e" ""; else miss "$e" "code --install-extension $e"; fi
  done
  if echo "$exts" | grep -q "antigravity"; then pass "Antigravity" ""; else miss "Antigravity" "사전 준비 안내의 Antigravity 확장 영상 참고"; fi
else
  echo "  code 명령이 없어 건너뜀"
fi

echo
echo "== 폴더 =="
if [ -d "../private-data" ]; then pass "private-data" "저장소 바깥에 있음"; else echo "  [참고] ../private-data 없음 (개인 데이터를 가져온 경우에만 필요)"; fi

echo
echo "결과: OK $ok / 없음 $fail"
