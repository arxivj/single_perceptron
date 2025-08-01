# Single Perceptron

단일 퍼셉트론의 작동 원리를 시각적으로 이해하고, 논리 연산 학습 및 패턴 인식 시뮬레이션을 통해 인공신경망의 기초를 탐구하는 Flutter 애플리케이션입니다.

---

## **Features**

|                                                           [결정 경계 시각화](#결정-경계-시각화-visualization)                                                            |                                                       [패턴 인식 시뮬레이션](#패턴-인식-시뮬레이션-pattern-recognition)                                                       |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------:|
| <img src="/screenshots/decision_boundary_screenshot.png" alt="Decision Boundary Visualization" style="max-width: 100%; height: auto; max-height: 480px;"/> | <img src="/screenshots/pattern_recognition_screenshot.png" alt="Pattern Recognition Simulation" style="max-width: 100%; height: auto; max-height: 480px;"/> |

---

## 결정 경계 시각화 (Visualization)

사용자가 퍼셉트론의 가중치(w1, w2)와 편향(bias)을 조절하여 2차원 공간에서 **결정 경계**가 어떻게 변화하는지 실시간으로 확인할 수 있도록 돕습니다.

AND, OR, NOT과 같은 기본적인 논리 연산의 학습 과정을 시뮬레이션하고, 단일 퍼셉트론이 해결할 수 없는 **XOR 문제의 본질**을 시각적으로 이해하는 데 유용합니다.

### **How to Use**

1.  메인 화면에서 "결정 경계 시각화" 카드를 탭하여 해당 화면으로 이동합니다.
2.  화면 하단의 슬라이더를 사용하여 **가중치(w1, w2)** 와 **편향(bias)** 을 변경합니다.
3.  그래프 상에서 결정 경계선이 실시간으로 업데이트되는 것을 확인합니다.
4.  **입력 값(x1, x2)** 에 해당하는 LED Switch를 탭하여 변경 해가며 각 입력에 대한 퍼셉트론의 출력을 확인합니다.
5.  **LED Switch 조작 시 그래프 반영**: 화면 하단의 LED Switch (x1, x2)를 탭하여 입력 값을 변경하면, 그래프 상에 해당 입력 값에 해당하는 점(Point)이 커지고 노란색 테두리로 강조되어 표시됩니다.

<img src="/screenshots/decision_boundary_visualizer.gif" alt="Decision Boundary Demo" width="250"/>

#### **Point Colors**

그래프 상의 각 점은 퍼셉트론의 입력 조합(예: (1, 1), (1, -1) 등)을 나타냅니다. 이 점들의 색상은 현재 퍼셉트론의 가중치와 편향 설정에 따라 해당 입력 조합이 어떻게 분류되는지를 보여줍니다.

-   **초록색 점**: 퍼셉트론의 순입력(net input) 값이 0보다 크거나 같을 때 (즉, 퍼셉트론이 해당 입력 패턴을 **Positive**로 분류할 때) 표시됩니다.
-   **빨간색 점**: 퍼셉트론의 순입력(net input) 값이 0보다 작을 때 (즉, 퍼셉트론이 해당 입력 패턴을 **Negative**로 분류할 때) 표시됩니다.

### **Concept**: 입력 값 1과 -1의 사용

로젠블랫의 오리지널 퍼셉트론 모델은 입력 값으로 **1과 -1**을 사용했습니다. 이는 단순히 결정 경계 시각화의 편의성을 넘어, 퍼셉트론의 가중치 업데이트 규칙(예: 오분류 시 가중치 조정)에서 1과 -1이 갖는 대칭적인 특성이 계산을 단순화하고 모델의 동작을 명확히 하는 데 기여했기 때문입니다.

-   **대칭성**: 1과 -1은 0을 기준으로 대칭적인 값을 가지므로, 가중치와 편향을 조절하여 결정 경계를 원점 주변에 쉽게 위치시킬 수 있습니다. 이는 학습 알고리즘의 안정성과 효율성을 높이는 데 도움이 됩니다.
-   **수학적 편리성**: 1과 -1을 사용하면 순입력(net input) 계산 시 음수 값의 기여를 명확하게 표현할 수 있어, 가중치 업데이트 규칙을 더 직관적으로 만들 수 있습니다.

### **Example**: AND 연산 학습

**AND 연산**은 두 입력(x1, x2)이 모두 1일 때만 1을 출력하고, 그 외에는 0을 출력합니다. 단일 퍼셉트론으로 AND 연산을 학습시키기 위한 가중치와 편향은 다양할 수 있지만, 다음은 한 가지 예시입니다.

**AND 연산 진리표:**

| x1 | x2 | 출력 (AND) |
| :--: | :--: | :----------: |
|  1   |  1   |      1       |
|  1   |  -1  |      0       |
|  -1  |  1   |      0       |
|  -1  |  -1  |      0       |

**예시 설정 값:**

```
w1 (가중치 1): 10
w2 (가중치 2): 10
bias (편향): -15
```

**학습 과정:**

1. `w1` 슬라이더를 조작하여 10으로 설정하고, `w2` 슬라이더를 10으로 설정합니다.
2. `bias` 슬라이더를 -15로 설정합니다.
3. `x1`, `x2`에 해당하는 LED Switch를 탭하여 (1, 1)로 설정합니다.
4. 그래프의 현재 상태의 점(노란색 테두리로 강조)이 초록색으로 표시되는지 확인합니다. 이는 퍼셉트론이 입력 (1, 1)을 **Positive**로 분류했음을 나타냅니다.
5. AND 진리표와 대조하여 퍼셉트론이 올바르게 학습되었는지 확인합니다.

<img src="/screenshots/decision_boundary_visualizer.gif" alt="Decision Boundary Visualizer Demo" width="250"/>


#### **Other Logic Gates**

다른 논리 연산(OR, NOT)에 대해서도 유사한 방식으로 실험해 볼 수 있습니다.

| OR 연산 | AND 연산 | XOR 연산 | NAND 연산 | NOR 연산 |
| :---: | :---: | :---: | :---: | :---: |
| <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">0</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">0</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">0</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">1</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">1</td></tr> </table> |


---

## 패턴 인식 시뮬레이션 (Pattern Recognition)

4x4 그리드의 LED를 통해 16개의 이진 입력 패턴을 생성하고, 이를 퍼셉트론에 학습시켜 특정 패턴을 인식하도록 훈련하는 과정을 시뮬레이션합니다.

### **How to Use**

1.  메인 화면에서 "패턴 인식 시뮬레이션" 카드를 탭하여 해당 화면으로 이동합니다.
2.  4x4 그리드의 LED를 탭하여 원하는 입력 패턴을 만듭니다.
3.  **"Positive Target"** 또는 **"Negative Target"** 을 선택하여 현재 패턴의 학습 목표를 설정합니다.
4.  **"Learn"** 버튼을 탭하여 퍼셉트론을 훈련시킵니다.
5.  학습된 패턴은 하단의 목록에 추가되며, 탭하여 다시 불러올 수 있습니다.
6.  🔄 버튼을 사용하여 현재 입력 패턴을 초기화할 수 있습니다.

<img src="/screenshots/learning_process_pattern.gif" alt="Learning Process Demo" width="250"/>

#### **Classification Colors**

-   **초록색**: `Net Input` > 0 (Positive 분류)
-   **빨간색**: `Net Input` < 0 (Negative 분류)

### **Algorithm**: 학습 알고리즘 및 입력 처리

-   **학습 알고리즘**: **퍼셉트론 학습 규칙(Perceptron Learning Rule)** 기반
-   **입력 처리**: 4x4 LED 상태(켜짐/꺼짐) -> 퍼셉트론 입력(1 또는 -1)

### **Example**: 'T'와 'J' 패턴 학습

> 퍼셉트론이 'T'와 'J'의 다양한 변형을 일반화하여 인식하도록, 여러 형태의 패턴을 번갈아 반복적으로 학습시키는 것이 중요합니다.

#### **'T' 패턴 학습 (Positive Target)**

**예시 'T' 패턴:**

| Pattern 1 | Pattern 2 |
| :---: | :---: |
| ⬜️🟩🟩🟩<br>⬜️⬜️🟩⬜️<br>⬜️⬜️🟩⬜️<br>⬜️⬜️🟩⬜️ | 🟩🟩🟩⬜️<br>⬜️🟩⬜️⬜️<br>⬜️🟩⬜️⬜️<br>⬜️🟩⬜️⬜️ |
| **Pattern 3** | **Pattern 4** |
| ⬜️⬜️⬜️⬜️<br>⬜️🟩🟩🟩<br>⬜️⬜️🟩⬜️<br>⬜️⬜️🟩⬜️ | ⬜️🟩🟩🟩<br>⬜️⬜️🟩⬜️<br>⬜️⬜⬜⬜️<br>⬜️⬜️⬜️⬜️ |

**학습 과정:**

1.  위 예시 중 하나를 LED 그리드에 만듭니다.
2.  학습 목표를 **"Positive Target"** 으로 설정합니다.
3.  **"Learn"** 버튼을 눌러 학습을 진행합니다.
4.  다른 형태의 'T' 패턴으로 위 과정을 반복합니다.

<img src="/screenshots/t_pattern_learn.gif" alt="T Pattern Demo" width="250"/>

#### **'J' 패턴 학습 (Negative Target)**

**예시 'J' 패턴:**

| Pattern 1 | Pattern 2 |
| :---: | :---: |
| ⬜️⬜️⬜️🟩<br>⬜️⬜️⬜️🟩<br>⬜️🟩⬜️🟩<br>⬜️🟩🟩🟩 | ⬜️⬜️🟩⬜<br>⬜️⬜️🟩⬜<br>🟩⬜️🟩⬜<br>️🟩🟩🟩⬜ |
| **Pattern 3** | **Pattern 4** |
| ⬜️⬜️⬜️🟩<br>⬜️️⬜️⬜️🟩<br>⬜️🟩⬜️🟩<br>⬜️⬜️🟩⬜ | ⬜️⬜️🟩⬜<br>⬜️⬜️🟩⬜<br>🟩⬜️🟩⬜<br>⬜🟩🟩⬜ |

**학습 과정:**

1.  위 예시 중 하나를 LED 그리드에 만듭니다.
2.  학습 목표를 **"Negative Target"** 으로 설정합니다.
3.  **"Learn"** 버튼을 눌러 학습을 진행합니다.
4.  다른 형태의 'J' 패턴으로 위 과정을 반복합니다.

<img src="/screenshots/j_pattern_learn.gif" alt="J Pattern Demo" width="250"/>

### **Guide**: 학습 결과 확인 및 재학습

#### **Check Results**

학습 후, 하단의 "Learned Patterns" 목록에서 각 패턴에 대한 `Net Input` 값을 확인할 수 있습니다.

<img src="/screenshots/pattern_result.gif" alt="Pattern Result Demo" width="250"/>

#### **Troubleshooting**
학습을 진행하다 보면, 특정 패턴에 대해 퍼셉트론의 분류 결과(`Net Input`의 부호)가 설정했던 학습 목표(Positive/Negative)와 일치하지 않는 경우가 발생할 수 있습니다.<br>
예를 들어, 'J' 패턴을 Negative로 학습시켰는데 `Net Input`이 양수(Positive)로 나오는 경우입니다. 이 떈 해당 패턴을 다시 불러와 **올바른 목표로 재학습**시키면 됩니다.

**재학습 과정:**

1.  분류가 잘못된 패턴 카드를 탭하여 불러옵니다.
2.  올바른 학습 목표("Positive" 또는 "Negative")를 선택합니다.
3.  **"Learn"** 버튼을 다시 눌러 재학습시킵니다.

<img src="/screenshots/mismatch_relearn.gif" alt="Mismatch Relearn Demo" width="250"/>

---

## **Installation**

### **Android**

1.  [single_perceptron.apk](https://github.com/arxivj/single_perceptron/releases/download/v1.0.0/single_perceptron.apk) 링크를 클릭하거나, 아래 QR 코드를 스캔하여 APK 파일을 다운로드합니다.
    <br><br>
    <img src="screenshots/single_perceptron_qr.png" width="160"/>
    <br><br>
2.  Android 기기에서 다운로드한 APK 파일을 설치합니다.<br><br>