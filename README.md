# Counter App (Flutter + Bloc + Clean Architecture)

클린 아키텍처 원칙을 따르는 Flutter 카운터 애플리케이션입니다.

## 기능

- **Counter 탭**: 카운터 증가 기능
- **History 탭**: 카운터 버튼 클릭 히스토리를 타임스탬프와 함께 표시
- Secure Storage를 사용한 로컬 저장소
- Bloc 패턴을 사용한 상태 관리

## 아키텍처

본 프로젝트는 클린 아키텍처를 따릅니다:

```
lib/
├── core/
│   └── usecase.dart
├── features/
│   └── counter/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           └── pages/
└── main.dart
```

### 레이어

1. **Domain Layer**: 비즈니스 로직과 엔티티
   - Entities: Counter, CounterHistory
   - Repositories: 인터페이스
   - Use Cases: IncrementCounter, GetCounter, GetCounterHistory, AddCounterHistory

2. **Data Layer**: 데이터 처리
   - Data Sources: Local storage (Secure Storage)
   - Models: 데이터 모델
   - Repository Implementations

3. **Presentation Layer**: UI와 상태 관리
   - Bloc: CounterBloc, HistoryBloc
   - Pages: CounterPage, HistoryPage

## 시작하기

1. Flutter SDK가 설치되어 있는지 확인하세요.

2. 프로젝트 디렉토리로 이동:

```bash
cd counter
```

3. 의존성 설치:

```bash
flutter pub get
```

4. 앱 실행:

```bash
flutter run
```

## 사용된 패키지

- `flutter_bloc`: 상태 관리
- `equatable`: 값 비교
- `flutter_secure_storage`: 보안 로컬 저장소
- `intl`: 날짜/시간 포맷팅

## 특징

- Clean Architecture 원칙 적용
- Bloc 패턴으로 상태 관리
- Secure Storage를 통한 안전한 로컬 데이터 저장
- 탭 기반 UI로 기능 분리
