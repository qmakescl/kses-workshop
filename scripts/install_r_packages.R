# 워크숍용 R 패키지 설치
# 사용법: Rscript scripts/install_r_packages.R

options(repos = c(CRAN = "https://cloud.r-project.org"))

cran_pkgs <- c(
  "tidyverse",      # 데이터 처리와 시각화
  "readxl",         # 엑셀 읽기
  "haven",          # SPSS·SAS·Stata 읽기
  "janitor",        # 변수명 정리, 교차표
  "gtsummary",      # Table 1
  "gt",             # 표 출력
  "broom",          # 모형 결과 정리
  "MatchIt",        # 성향점수 매칭
  "languageserver"  # VS Code R 확장에 필요
)

missing <- setdiff(cran_pkgs, rownames(installed.packages()))
if (length(missing) > 0) {
  message("설치: ", paste(missing, collapse = ", "))
  install.packages(missing)
} else {
  message("CRAN 패키지는 모두 설치되어 있습니다.")
}

# httpgd: VS Code 에서 그래프를 보여주는 패키지. CRAN 에 없을 수 있어 r-universe 에서 설치한다.
if (!requireNamespace("httpgd", quietly = TRUE)) {
  message("설치: httpgd")
  tryCatch(
    install.packages("httpgd",
                     repos = c("https://nx10.r-universe.dev", "https://cloud.r-project.org")),
    error = function(e) message("httpgd 설치 실패 (그래프는 별도 창으로 표시됩니다): ", conditionMessage(e))
  )
}

all_pkgs <- c(cran_pkgs, "httpgd")
ok <- vapply(all_pkgs, requireNamespace, logical(1), quietly = TRUE)
cat("\n")
for (p in all_pkgs) cat(sprintf("  [%s] %s\n", if (ok[[p]]) "OK  " else "실패", p))
