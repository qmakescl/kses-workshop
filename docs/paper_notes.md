# 실습 논문 근거 메모

이 문서는 워크숍 전에 [원 논문](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915)과 [2026년 정정 공지](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0340485)를 확인해 작성한 실습용 요약입니다. 참가자는 M2-2에서 이 파일을 읽고 공개 CSV의 변수와 대조합니다. 논문의 환자 선정 과정과 제공 CSV의 행 필터링은 서로 다른 계산입니다.

## 출처와 그림 번호

- Hawa A, Tham A, Bilbrough J, Hayek C, Shenouda M, Murrell GAC. *Is it enough to utilize a single anchor for repair of rotator cuff tears ≤ 3 × 3 cm²?* PLoS One. 2025;20(4):e0320915. [논문 DOI](https://doi.org/10.1371/journal.pone.0320915)
- [공개 보충자료 S1 CSV](https://doi.org/10.1371/journal.pone.0320915.s001)
- 2026년 [정정 공지](https://doi.org/10.1371/journal.pone.0340485)는 그림 1~4의 **캡션**을 수정했습니다. 정정본 기준 그림 1은 설문지, 그림 2는 환자 제외 흐름, 그림 3은 6개월 재파열률, 그림 4는 임상 결과입니다. 원 논문 웹페이지에 남아 있는 옛 캡션과 혼동하지 마세요.

## 연구 질문과 설계

- 연구 질문: 3 × 3 cm 이하의 전층 회전근개 파열을 단일 앵커로 봉합했을 때, 다중 앵커 봉합과 6개월 재파열률 및 임상 결과가 비슷한가? ([Abstract: Purpose](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))
- 전향적으로 수집한 자료를 후향적으로 분석한 관찰 코호트입니다. 단일 술자의 관절경 단열(single-row) 봉합 사례에서 나이, 성별, 파열 크기, 수술 전 강직도 등을 이용해 성향점수로 매칭했습니다. 무작위 배정 시험이 아닙니다. ([Methods: Study design](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))
- 주 결과는 수술 후 6개월 초음파로 평가한 봉합부 재파열입니다. 환자 보고 통증·기능과 검사자 측정 근력·관절운동범위는 부 결과입니다. ([Methods: Study design, Data collection](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))

## 포함·제외 기준과 표본 흐름

- 포함: 한 명의 선임 술자가 1개 이상의 앵커로 일차 봉합한 전층 파열, 최소 6개월 추적, 수술 후 6개월 초음파 평가. 제외: 견갑하근 단독 파열, 봉합 불가능 파열, 전후(AP) 또는 내외측(ML) 직경 3 cm 초과, 부분층 파열, 재수술, 견열 골절 관련 파열, PTFE 패치 사용, 6개월 추적 미참석. ([Methods: Inclusion criteria, Exclusion criteria](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))
- 논문 Results의 흐름: 전체 봉합 **2,922건** → 제외 기준 해당 **1,712건**(이 중 크기 초과 189건 포함) → 적격 **1,210건** → 6개월 추적 미참석 **40건** → 분석 가능 **1,170건** → 성향점수 매칭 **346명**, 단일·다중 앵커 각 **173명**. 정정본 기준 환자 제외 흐름은 **그림 2**, 매칭 설명은 **표 1**을 보세요. ([Results](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915), [정정 공지](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0340485))
- **제공 CSV와의 구분:** `data/public/anchor.csv`는 1,309행이며 ID만 있는 99행을 제외하면 값이 있는 1,210행입니다. 그 1,210행에 AP·ML 모두 30 mm 이하 조건을 적용하면 1,021행입니다. 이는 **실습 파일에서 계산한 행 수**입니다. 숫자가 같아도 CSV의 1,210행을 논문의 적격 1,210건과 같은 선정 단계·동일한 환자 집합으로 단정할 수 없습니다. CSV에는 논문의 모든 제외 기준·매칭 절차가 구현되어 있지 않습니다. ([data/public/README.md](../data/public/README.md), [논문 Results](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))

## 변수 정의와 측정 시점

| 논문에서 확인한 개념 | 정의·시점 | 근거와 CSV 대조 시 주의 |
|---|---|---|
| 파열 크기 | 수술 중 측정한 전후(AP)·내외측(ML) 직경의 곱으로 면적을 계산합니다. 직경은 cm 기준 3 cm 이하가 포함 범위입니다. | [Methods: Rotator cuff tear surface area](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915). CSV의 `TearAntPost`, `TearMedLat`, `TearSizeArea`와 단위·계산값을 직접 확인하세요. |
| 재파열 | 수술 후 6개월 초음파로 봉합부의 무결성을 평가합니다. | [Methods: Study design](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915), [Results: Retear rate](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915). CSV의 `@6mo_Retear`에서 0/1의 뜻과 결측 처리는 데이터로 검산하세요. |
| 환자 보고 결과 | 수정 L’Insalata 설문으로 통증, 강직, 기능, 만족도 등을 수술 전·6주·6개월에 확인하고 문항 응답을 0~4 값으로 변환합니다. | [Methods: Patients reported outcome](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915), 정정본 **그림 1**. `Pink` 변수와 개별 문항의 방향·라벨을 모두 논문만으로 확정하지 마세요. |
| 검사자 측정 결과 | 수동 관절운동범위는 도(°), 어깨 근력은 뉴턴(N)으로 수술 전·6주·6개월에 측정합니다. | [Methods: Surgeon reported outcome](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915). `Green` 변수의 약어는 항목별로 별도 확인하세요. |
| 수술 시간 | 절개 시작부터 피부 봉합까지의 분 단위 시간입니다. | [Methods: Rotator cuff tear surface area](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915). CSV `Op_time`의 단위를 확인하세요. |

논문이 CSV의 120개 열에 대한 완전한 코드북을 제공하지는 않습니다. `Group`의 0/1과 `Noofanchors`의 관계, `SurgeryType`, `V67` 등 의미가 불분명한 열은 공개 CSV의 값과 원문을 대조하고, 확인되지 않으면 코드북에 **추정** 또는 **확인 필요**로 표시하세요.

## 주요 결과: 매칭 후 346명

다음 값은 제공 CSV 전체가 아니라 **논문의 매칭 표본**에서 보고한 6개월 재파열률입니다. 경계는 AP·ML 각각 10 mm와 30 mm를 기준으로 합니다. ([Results: Retear rate](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915), 정정본 **그림 3**, [논문 표 2](https://doi.org/10.1371/journal.pone.0320915.t002))

| ML × AP | 단일 앵커 | 다중 앵커 | 논문 내 비교 |
|---|---:|---:|---|
| ≤10 × ≤10 mm | 3/62 (4.8%) | 2/61 (3.3%) | P=1.00 |
| ≤10 × >10–30 mm | 4/37 (10.8%) | 3/38 (7.9%) | P=0.71 |
| >10–30 × ≤10 mm | 0/11 (0%) | 0/10 (0%) | 양 군 재파열 없음 |
| >10–30 × >10–30 mm | 16/63 (25.4%) | 7/64 (10.9%) | P=0.04 |

- 양쪽 직경이 모두 10 mm를 넘는 하위군에서 다중 앵커군의 6개월 재파열률이 낮았습니다. 다른 세 하위군에서는 유의한 차이가 보고되지 않았습니다. ([Results: Retear rate](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))
- 양쪽 직경이 모두 10 mm 이하인 하위군에서 수술 시간은 단일 앵커 평균 14분, 다중 앵커 평균 20분으로 보고됐습니다(P<0.01). 다른 크기 하위군에서 같은 차이가 일관되게 보고되지는 않았습니다. ([Results: Intraoperatively](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))
- 6개월의 환자 보고·검사자 측정 임상 결과는 군 또는 하위군 간 유의한 차이가 보고되지 않았습니다. 수술 후 6주에는 일부 항목별 차이가 있으므로 ‘모든 시점에 차이 없음’으로 일반화하지 마세요. ([Results: Clinical outcome](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915), [표 4](https://doi.org/10.1371/journal.pone.0320915.t004), [표 5](https://doi.org/10.1371/journal.pone.0320915.t005))

## 해석과 한계

- 논문의 결론은 작은·중간 파열 전체에서 단일·다중 앵커 간 6개월 재파열률과 임상 결과의 뚜렷한 차이가 없었으나, **AP·ML 모두 10 mm 초과**인 경우에는 다중 앵커가 낮은 재파열률을 보였다는 것입니다. 이는 관찰 연구의 연관성으로 읽고 치료법의 인과적 우월성을 단정하지 마세요. ([Conclusion](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))
- 무작위 배정·눈가림이 없고 추적 기간이 6개월로 짧으며, 어느 한 직경이라도 30 mm를 넘는 파열은 포함하지 않았습니다. ([Discussion: Limitations](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))
- 논문은 평균±**SEM**을 보고하고 연속형 비교에 Mann–Whitney U, 범주형 비교에 카이제곱 검정을 사용했습니다. 워크숍에서 평균±**SD**, Fisher 검정 또는 다른 분석 집합을 택하면 방법과 이유를 별도로 적으세요. ([Methods: Statistical analysis](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320915))

## 워크숍에서 사용하는 방법

1. M2-2에서 이 메모의 출처·표본 흐름과 실제 `data/public/anchor.csv`의 열을 먼저 대조합니다.
2. `docs/codebook_public.csv`를 만들 때 확인된 정의에는 위 근거를, 불확실한 변수에는 ‘추정’ 또는 ‘확인 필요’를 남깁니다.
3. M3·M4에서 이 메모를 다시 읽되, 메모에 없는 수치나 정의를 채워 넣어야 한다면 원문을 확인하거나 비교를 보류합니다.
