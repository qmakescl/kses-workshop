# 모듈별 프롬프트 모음

복사해서 코딩 에이전트에 붙여넣으세요. `[ ]` 부분은 본인 상황에 맞게 바꿉니다.
**B** 표시는 개인 데이터를 가져온 분을 위한 병행 과제입니다.

---

## M2-1. 프로파일 스크립트 만들기

```text
data/public/anchor.csv 의 구조를 요약하는 R 스크립트 R/00_profile.R 을 작성해줘.

- 스크립트 맨 위에 input_path 와 output_path 변수를 두어 경로만 바꾸면 다른 데이터에도 쓸 수 있게 해줘.
- csv, xlsx, sav 파일을 모두 읽을 수 있게 해줘 (readr, readxl, haven).
- 공백 문자만 있는 칸은 결측으로 처리해줘.
- 변수별로 다음을 표 하나로 만들어 output_path 에 csv 로 저장해:
  변수명, 자료형, 결측 수, 고유값 개수,
  숫자형이면 최솟값·최댓값,
  문자·범주형이면 고유값이 10개 이하일 때만 값 목록 (11개 이상이면 "(생략)"으로 표시)
- 개별 행의 값(원자료)은 절대 출력하지 마.
- 기본 경로는 input_path = "data/public/anchor.csv", output_path = "docs/profile_public.csv" 로 해줘.

작성한 뒤 실행해서 결과를 보여줘.
```

## M2-2. 공개 데이터 코드북

아래는 기존 예시입니다. 이번 워크숍에서는 이어지는 **워크숍용** 프롬프트를 사용합니다.

```text
docs/profile_public.csv 를 바탕으로 코드북 초안 docs/codebook_public.csv 를 만들어줘.
열은 variable, label, type, unit, values_range, missing_code, timepoint, note 로 해줘.
변수명의 PreOp / @6wk / @6mo 는 timepoint 로, Pink 는 환자보고, Green 은 검사자 측정으로 해석해줘.
label, unit, timepoint 는 변수명으로 추정하되 추정한 칸에는 note 에 "추정" 이라고 표시해.
의미를 알 수 없는 변수(V67 등)는 label 을 "불명" 으로 두고 note 에 이유를 적어.
```

### 워크숍용: 미리 제공한 논문 메모 읽기

원 논문을 다시 검색하거나 요약 파일을 새로 생성하지 않습니다. 위의 코드북 작성 요청과 함께 아래 프롬프트를 사용합니다.

```text
프로젝트에 미리 제공된 docs/paper_notes.md 를 읽고 논문 출처, 표본 흐름, 변수 정의와 근거가 무엇인지 먼저 짧게 요약해줘. 원문을 새로 검색하거나 paper_notes.md 를 다시 작성하지 마.
docs/profile_public.csv 와 docs/paper_notes.md 를 참고해 docs/codebook_public.csv 초안을 만들어줘.
열은 variable, label, type, unit, values_range, missing_code, timepoint, note 로 해줘.
논문에서 확인된 정의는 paper_notes.md 의 절·표 근거를 note 에 적고, 변수명에서 추정한 내용은 "추정", 근거가 없는 항목은 "확인 필요"로 표시해줘.
제공 CSV의 행 수와 논문의 매칭 표본을 같은 집단으로 취급하지 마. 결과를 보여주고 내가 코드북을 감수할 수 있게 해줘.
```

## M2-3. B: 내 데이터 코드북과 모의 데이터

1단계. `R/00_profile.R`을 `R/00_profile_private.R`로 복사하고 경로만 바꿉니다. (에이전트 없이 직접)

```r
input_path  <- "../private-data/my_study.csv"
output_path <- "../private-data/out/profile_private.csv"
```

2단계. **IDE 바깥의 별도 터미널**에서 실행하고, 결과를 직접 검토한 뒤 `docs/profile_private.csv`로 옮깁니다.

```bash
Rscript R/00_profile_private.R
```

3단계. 에이전트에 요청합니다.

```text
docs/profile_private.csv 는 내 연구 데이터의 구조 요약이다. 이 연구는 [연구설계, 대상, 주요 결과변수를 한두 문장으로].
1) M2-2 와 같은 열 구성으로 docs/codebook_private.csv 를 만들어줘. 추정한 칸에는 note 에 "추정" 표시.
2) 코드북의 유형과 범위를 따르는 모의 데이터 100행을 data/mock/mock_private.csv 로 만들어줘.
   결측 비율은 프로파일과 비슷하게 넣어줘.
../private-data 폴더는 절대 열지 마.
```

## M3. 제공 CSV 분석과 논문 비교

```text
docs/codebook_public.csv 를 참고해서 R/01_reproduce.R 을 작성해줘.
이 작업은 제공 CSV의 분석이며 논문의 매칭 표본 346명을 재현한 결과라고 표현하지 마.
1) 원본 행 수, ID만 있는 행을 제외한 행 수, Group 0/1의 행 수를 기록하고 공백 결측 처리와 범주 표기 통일 과정을 명시해.
2) 논문의 포함 기준(전후·내외측 파열 직경 모두 30 mm 이하)을 적용한 뒤 앵커 군별 인구학적 특성 표 (gtsummary).
   연속형은 중앙값(IQR), 평균, 표본 SD, SEM(= SD/√관측 수)을 구분해 보여주고 Mann-Whitney U 검정.
   논문은 평균±SEM을 보고하므로 우리 표의 평균±SD와 혼동하지 않도록 설명해.
3) 내외측 10 mm, 전후 10 mm 기준 4개 하위군 × 앵커 군별 재파열률. 기대빈도가 작으면 Fisher 정확검정
4) 결과를 output/ 에 html 로 저장하고, 실습 CSV의 단계별 행 수와 docs/paper_notes.md 에 기록된 논문의 적격·분석 가능·매칭 후 표본 수를 구분해 비교 메모를 남겨줘. 메모에 없는 내용은 추정하지 마.
```

**B**: 위 프롬프트의 파일을 `data/mock/mock_private.csv`, `docs/codebook_private.csv`로 바꾸고, 출력 스크립트를 `R/01_table1_private.R`로, 입력 경로를 맨 위 변수로 두게 합니다.

## M4. 회귀모형으로 재분석

```text
하위군을 나눠 반복 검정하는 대신 하나의 모형으로 분석하고 싶다.
R/02_model.R 에 재파열 여부를 결과로 하는 로지스틱 회귀를 작성해줘.
설명변수는 앵커 군, 파열 크기(면적 또는 전후·내외측 직경), 앵커 군과 파열 크기의 상호작용, 나이, 성별, 수술 전 강직도.
OR 과 95% CI 표, forest plot 을 output/ 에 저장하고, 결과를 docs/paper_notes.md 에 기록된 논문 결론과 비교하는 한 문단을 써줘. 메모에 없는 내용은 추정하지 마.
```

**B**:

```text
내 연구의 주 질문은 [한 문장]. data/mock/mock_private.csv 와 docs/codebook_private.csv 로
이 질문에 맞는 회귀모형 스크립트 R/02_model_private.R 을 작성해줘. 입력 경로는 맨 위 변수로 두고,
결과는 output_path 변수에 저장해. ../private-data 폴더는 열지 마.
```

## M5. MNIST CNN

```text
이미 kses-workshop/ 루트에 만든 Python 3.11 uv 프로젝트와 .venv를 사용해줘. python/에 별도 가상환경을 만들지 마.
루트의 pyproject.toml에 PyTorch(CPU), torchvision, numpy, pandas, scikit-learn, matplotlib를 의존성으로 추가해.
Windows/Linux에서는 CPU 전용 PyTorch 패키지를 사용하고, uv run 으로 실행해.
python/mnist_cnn.py 에 MNIST 를 분류하는 작은 CNN 을 작성해. CPU 에서 2 epoch 이내로 끝나야 해.
학습·검증 손실 곡선, 테스트 정확도, 혼동행렬, 틀린 이미지 16장을 output/ 에 저장해줘.
```

## M6. 로지스틱 회귀 vs 신경망

```text
data/public/anchor.csv 로 재파열을 예측하는 두 모델을 비교하는 python/compare.py 를 작성해줘.
전처리는 R/01_reproduce.R 과 같은 규칙(빈 행 제거, 공백 결측, 30 mm 이하 포함 기준)을 따라줘.
로지스틱 회귀와 은닉층 1개의 작은 신경망(MLP)을 5-fold 교차검증으로 비교하고
AUC 와 calibration plot 을 output/ 에 저장해줘.
```
