# kses-workshop

대한견주관절의학회 중개연구위원회 2026 실습 워크숍 실습 저장소입니다.
코딩 에이전트와 함께 R·Python으로 데이터를 분석하고, 그 결과로 원고를 작성합니다.

- 일시: 2026년 10월 24일 (토) 09:00–15:00
- 장소: 토즈모임센터 강남역토즈타워점

## 시작하기

1. 이 저장소를 `kses/kses-workshop`에 `git clone`합니다. 개인 데이터를 가져오신 분은 `kses/private-data/`에 데이터 파일을 둡니다.
2. VS Code에서 `kses-workshop` 폴더를 엽니다. (**`kses` 폴더가 아니라 `kses-workshop` 폴더**를 엽니다.)
3. 환경을 점검합니다.

   ```bash
   # macOS
   bash scripts/check_env.sh

   # Windows (PowerShell)
   powershell -ExecutionPolicy Bypass -File scripts\check_env.ps1
   ```

4. R 패키지를 설치합니다. (사전 준비에서 했다면 건너뜁니다.) Python 가상환경과 의존성은 딥러닝 실습 중 `uv`로 만듭니다.

   ```bash
   Rscript scripts/install_r_packages.R
   ```

## 폴더 구조

```text
kses/
├─ kses-workshop/            ← 에이전트 작업 폴더 (이 저장소)
│   ├─ data/public/          ← 공개 실습 데이터 (anchor.csv)
│   ├─ data/mock/            ← 모의 데이터 (에이전트 생성)
│   ├─ docs/                 ← 프로파일, 코드북, 프롬프트 모음
│   ├─ R/                    ← R 스크립트
│   ├─ python/               ← 실습 중 uv 프로젝트와 가상환경을 만들 폴더
│   ├─ output/               ← 표, 그림
│   └─ scripts/              ← 환경 점검·설치 스크립트
└─ private-data/             ← 실제 개인 데이터 (저장소 바깥, 에이전트 비노출)
```

`AGENTS.md`는 초기 저장소에 포함하지 않고, 실습 과정에서 함께 작성합니다.

## 실습 데이터

Hawa A, et al. Is it enough to utilize a single anchor for repair of rotator cuff tears ≤ 3 * 3 cm²? *PLoS One*. 2025;20(4):e0320915.
자세한 내용은 [data/public/README.md](data/public/README.md)를 참고하세요.

## 개인 데이터 원칙

- 실제 환자 데이터는 **코딩 에이전트에게 보여주지 않습니다.**
- 에이전트는 공개 데이터와 모의 데이터로 스크립트를 만들고, 참가자가 그 스크립트를 개인 데이터에 직접 실행합니다.
- 개인 데이터는 이 저장소 바깥 `../private-data/`에 둡니다.

## 진행 순서

| 시간 | 내용 | 주요 파일 |
|---|---|---|
| 09:30 | 코드북 만들기 | `R/00_profile.R`, `docs/codebook_public.csv` |
| 10:05 | 논문 재현 | `R/01_reproduce.R` |
| 10:30 | 회귀모형으로 재분석 | `R/02_model.R` |
| 11:00 | MNIST CNN | `python/mnist_cnn.py` |
| 11:25 | 로지스틱 회귀 vs 신경망 | `python/compare.py` |
| 13:00 | 글쓰기, Reporting Guideline | `docs/` |

각 단계의 프롬프트는 [docs/prompts.md](docs/prompts.md)에 있습니다.
