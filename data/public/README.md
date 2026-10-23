# 공개 실습 데이터

## 출처

Hawa A, Tham A, Bilbrough J, Hayek C, Shenouda M, Murrell GAC.
Is it enough to utilize a single anchor for repair of rotator cuff tears ≤ 3 * 3 cm²?
*PLoS One*. 2025;20(4):e0320915. https://doi.org/10.1371/journal.pone.0320915

- 파일: `anchor.csv` = 논문 Supporting information S1 File (`Anonymized_Anchor_Data.csv`)을 내려받은 그대로입니다. 수정하지 마세요.
- 라이선스: PLOS ONE 게재물은 CC BY 4.0입니다. 재사용 시 위 논문을 인용합니다.
- 정정 공지: https://doi.org/10.1371/journal.pone.0340485 (그림 캡션 정정)

## 데이터 개요

- 단일 술자가 시행한 관절경 회전근개 봉합술 환자. 6개월 초음파로 재파열 평가
- 1,309행 × 120열. 이 중 99행은 ID만 있는 행이므로 나머지는 **CSV에서 값이 있는 1,210행**입니다.
- 이 1,210행에서 전후·내외측 파열 직경이 모두 30 mm 이하인 행은 1,021행입니다(단일 앵커 155행, 다중 앵커 866행). 이는 실습 파일에 적용한 기준의 결과입니다.
- 논문은 별도의 환자 선정 과정을 거쳐 적격 1,210명, 6개월 추적 누락 40명을 제외한 분석 가능 1,170명, 성향점수 매칭 후 346명(각 군 173명)을 보고합니다. **CSV의 1,210행을 논문의 적격 1,210명과 같은 집단으로 단정할 수 없습니다.** 숫자가 같아도 선정 단계와 정의를 구분해 기록하세요.

## 읽을 때 주의할 점

- 결측은 빈칸이 아니라 공백 문자 `" "`로 들어 있습니다. R에서는 `read_csv(path, na = c("", " ", "NA"))`.
- 변수명에 `@`가 있습니다(`@6mo_Retear`). R에서는 백틱으로 감싸거나 `janitor::clean_names()`를 씁니다.
- 변수명 규칙: `PreOp` = 수술 전, `@6wk` = 수술 후 6주, `@6mo` = 수술 후 6개월, `Pink` = 환자보고 설문, `Green` = 검사자 측정

변수의 의미는 당일 워크숍에서 코드북으로 함께 정리합니다.
