# docs

| 파일 | 내용 | 만드는 시점 |
|---|---|---|
| `prompts.md` | 모듈별 프롬프트 모음 | 미리 제공 |
| `codebook_template.csv` | 코드북 열 구성 예시 | 미리 제공 |
| `paper_notes.md` | 원 논문·정정 공지를 확인한 근거 메모. M2-2부터 읽기 | 미리 제공 |
| `profile_public.csv` | 공개 데이터 구조 요약 | M2-1 |
| `codebook_public.csv` | 공개 데이터 코드북 | M2-2 |
| `profile_private.csv` | (B) 내 데이터 구조 요약. **직접 검토한 뒤** 이 폴더로 옮김 | M2-3 |
| `codebook_private.csv` | (B) 내 데이터 코드북 | M2-3 |

## 코드북 열 정의

| 열 | 의미 | 예 |
|---|---|---|
| variable | 데이터의 변수명 그대로 | `@6mo_Retear` |
| label | 사람이 읽는 이름 | 6개월 재파열 여부 |
| type | numeric / categorical / binary / text / date | binary |
| unit | 단위 | mm, 도, N, 점 |
| values_range | 허용 범위 또는 범주 코딩 | 0=no, 1=yes |
| missing_code | 결측 표기 | `" "` (공백) |
| timepoint | 측정 시점 | preop / 6wk / 6mo |
| note | 추정 여부, 정리 규칙, 의문점 | 추정 / U,u → Undersurface |
