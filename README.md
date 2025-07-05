# Single Perceptron

단일 퍼셉트론의 작동 원리를 시각적으로 이해하고, 논리 연산 학습 및 패턴 인식 시뮬레이션을 통해 인공신경망의 기초를 탐구하는 Flutter 애플리케이션입니다.

---

## **Features**

| [결정 경계 시각화](#visualization)                                                                                         | [패턴 인식 시뮬레이션](#pattern-recognition)                                                                                         |
| :--------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------: |
| <img src="/screenshots/decision_boundary_screenshot.png" alt="Decision Boundary Visualization" style="height: 600px;"/> | <img src="/screenshots/pattern_recognition_screenshot.png" alt="Pattern Recognition Simulation" style="height: 600px;"/> |

---

## **Visualization**: 결정 경계 시각화

사용자가 퍼셉트론의 가중치(w1, w2)와 편향(bias)을 조절하여 2차원 공간에서 **결정 경계**가 어떻게 변화하는지 실시간으로 확인할 수 있도록 돕습니다.

AND, OR, NOT과 같은 기본적인 논리 연산의 학습 과정을 시뮬레이션하고, 단일 퍼셉트론이 해결할 수 없는 **XOR 문제의 본질**을 시각적으로 이해하는 데 유용합니다.

### **How to Use**

<table>
  <tr>
    <td>
      <ol>
        <li>메인 화면에서 "결정 경계 시각화" 카드를 탭하여 해당 화면으로 이동합니다.</li>
        <li>화면 하단의 슬라이더를 사용하여 <strong>가중치(w1, w2)</strong>와 <strong>편향(bias)</strong>을 변경합니다.</li>
        <li>그래프 상에서 결정 경계선이 실시간으로 업데이트되는 것을 확인합니다.</li>
        <li>입력 값(x1, x2)을 변경하여 각 입력에 대한 퍼셉트론의 출력을 확인합니다.</li>
        <li>
          <strong>LED Switch 조작 시 그래프 반영:</strong><br>
          화면 하단의 LED Switch (x1, x2)를 탭하여 입력 값을 변경하면, 그래프 상에 해당 입력 값에 해당하는 점(Point)이 커지고 노란색 테두리로 강조되어 표시됩니다.
        </li>
      </ol>
    </td>
    <td width="200">
      <img src="/screenshots/decision_boundary_visualizer.gif" alt="Decision Boundary Demo" />
    </td>
  </tr>
</table>

#### **Point Colors**

그래프 상의 각 점은 퍼셉트론의 입력 조합(예: (1, 1), (1, -1) 등)을 나타냅니다. 이 점들의 색상은 현재 퍼셉트론의 가중치와 편향 설정에 따라 해당 입력 조합이 어떻게 분류되는지를 보여줍니다.

-   **초록색 점**: 퍼셉트론의 순입력(net input) 값이 0보다 크거나 같을 때 (즉, 퍼셉트론이 해당 입력 패턴을 **Positive**로 분류할 때) 표시됩니다.
-   **빨간색 점**: 퍼셉트론의 순입력(net input) 값이 0보다 작을 때 (즉, 퍼셉트론이 해당 입력 패턴을 **Negative**로 분류할 때) 표시됩니다.

### **Concept**: 입력 값 1과 -1의 사용

로젠블랫의 오리지널 퍼셉트론 모델은 입력 값으로 **1과 -1**을 사용했습니다. 이는 단순히 결정 경계 시각화의 편의성을 넘어, 퍼셉트론의 가중치 업데이트 규칙(예: 오분류 시 가중치 조정)에서 1과 -1이 갖는 대칭적인 특성이 계산을 단순화하고 모델의 동작을 명확히 하는 데 기여했기 때문입니다.

이 시뮬레이션에서는 이러한 역사적 맥락과 함께, 1과 -1이 갖는 다음과 같은 이점을 활용합니다:

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

위 설정을 예시로 각 입력에 대한 퍼셉트론의 동작을 확인해 보겠습니다.

**학습 과정:**

<table>
  <tr>
    <td>
      <ol>
        <li><code>w1</code> 슬라이더를 조작하여 10으로 설정하고, <code>w2</code> 슬라이더를 10으로 설정합니다.</li>
        <li><code>bias</code> 슬라이더를 -15로 설정합니다.</li>
        <li><code>x1</code>, <code>x2</code>에 해당하는 LED Switch를 터치하여 (1, 1)로 설정합니다.</li>
        <li>그래프의 현재 상태의 점(노란색 테두리로 강조)이 초록색으로 표시되는지 확인합니다. 이는 퍼셉트론이 입력 (1, 1)을 <strong>Positive</strong>로 분류했음을 나타냅니다.</li>
        <li>AND 진리표와 대조하여 퍼셉트론이 올바르게 학습되었는지 확인합니다. 모든 입력 조합에 대해 퍼셉트론이 올바른 출력을 생성한다면 해당 논리 연산을 성공적으로 학습한 것입니다.</li>
      </ol>
    </td>
    <td width="200">
      <img src="/screenshots/decision_boundary_visualizer.gif" alt="Decision Boundary Visualizer Demo" />
    </td>
  </tr>
</table>

#### **Other Logic Gates**

다른 논리 연산(OR, NOT)에 대해서도 유사한 방식으로 실험해 볼 수 있습니다.

| OR 연산                                                                                                                   | AND 연산                                                                                                                   | XOR 연산                                                                                                                    | NAND 연산                                                                                                                    | NOR 연산                                                                                                                   |
| :------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------: |
| <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">0</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">0</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">0</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">1</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">1</td></tr> </table> | <table> <tr><th>x1</th><th>x2</th><th>출력</th></tr> <tr><td align="center">1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">1</td><td align="center">-1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">1</td><td align="center">0</td></tr> <tr><td align="center">-1</td><td align="center">-1</td><td align="center">1</td></tr> </table> |

---

## **Pattern Recognition**: 패턴 인식 시뮬레이션

4x4 그리드의 LED를 통해 16개의 이진 입력 패턴을 생성하고, 이를 퍼셉트론에 학습시켜 특정 패턴을 인식하도록 훈련하는 과정을 시뮬레이션합니다.

사용자는 패턴을 직접 만들고, 학습 목표(Positive/Negative)를 설정하며, 학습된 패턴을 저장하고 불러와 퍼셉트론의 학습 능력을 실험할 수 있습니다.

### **How to Use**

<table>
  <tr>
    <td>
      <ol>
        <li>메인 화면에서 "패턴 인식 시뮬레이션" 카드를 탭하여 해당 화면으로 이동합니다.</li>
        <li>4x4 그리드의 LED를 탭하여 원하는 입력 패턴을 만듭니다.</li>
        <li><strong>"Positive Target"</strong> 또는 <strong>"Negative Target"</strong>을 선택하여 현재 패턴의 학습 목표를 설정합니다.</li>
        <li><strong>"Learn"</strong> 버튼을 탭하여 퍼셉트론을 훈련시킵니다. 퍼셉트론의 가중치와 편향이 업데이트됩니다.</li>
        <li>학습된 패턴은 하단의 목록에 추가되며, 탭하여 다시 불러올 수 있습니다.</li>
        <li>🔄 버튼을 사용하여 현재 입력 패턴을 초기화할 수 있습니다.</li>
      </ol>
    </td>
    <td width="200">
      <img src="/screenshots/learning_process_pattern.gif" alt="Learning Process Demo" />
    </td>
  </tr>
</table>

#### **Classification Colors**

화면 상단에 표시되는 퍼셉트론의 분류 결과는 `Net Input` 값에 따라 색상으로 구분됩니다.

-   **초록색**: `Net Input` 값이 0보다 크거나 같을 때 (즉, 퍼셉트론이 현재 패턴을 **Positive**로 분류할 때) 표시됩니다.
-   **빨간색**: `Net Input` 값이 0보다 작을 때 (즉, 퍼셉트론이 현재 패턴을 **Negative**로 분류할 때) 표시됩니다.

### **Algorithm**: 학습 알고리즘 및 입력 처리

-   **학습 알고리즘**: **퍼셉트론 학습 규칙(Perceptron Learning Rule)** 을 기반으로 가중치와 편향을 조정합니다.
-   **입력 처리**: 4x4 그리드의 각 LED 상태(켜짐/꺼짐)는 퍼셉트론의 입력(1 또는 -1)으로 변환됩니다.

### **Example**: 'T'와 'J' 패턴 학습

이 시뮬레이션에서는 4x4 LED 그리드를 활용하여 다양한 형태의 패턴을 퍼셉트론에 학습시킬 수 있습니다. 여기서는 'T' 형태의 패턴을 **Positive** 목표로, 'J' 형태의 패턴을 **Negative** 목표로 설정하여 학습시키는 예시를 안내합니다.

> 퍼셉트론은 학습을 통해 'T'와 'J' 패턴의 다양한 변형들을 일반화하여 인식하는 능력을 습득하게 됩니다. 학습의 효과를 높이려면 다양한 형태의 'T'와 'J' 패턴을 번갈아 가며 반복적으로 학습시키는 것이 중요합니다.

#### **'T' 패턴 학습 (Positive Target)**

'T' 패턴은 중앙 상단에 가로선이 있고 그 아래로 세로선이 내려오는 형태를 가집니다. 다양한 두께나 위치의 'T'를 학습시켜 퍼셉트론이 'T'의 본질적인 특징을 파악하도록 할 수 있습니다.

**예시 'T' 패턴 (다양한 형태):**

| | | | | |
| :---: | :---: | :---: | :---: | :---: |
| ⬜️🟩🟩🟩<br>⬜️⬜️🟩⬜️<br>⬜️⬜️🟩⬜️<br>⬜️⬜️🟩⬜️ | 🟩🟩🟩⬜️<br>⬜️🟩⬜️⬜️<br>⬜️🟩⬜️⬜️<br>⬜️🟩⬜️⬜️ | ⬜️⬜️⬜️⬜️<br>⬜️🟩🟩🟩<br>⬜️⬜️🟩⬜️<br>⬜️⬜️🟩⬜️ | ⬜️🟩🟩🟩<br>⬜️⬜️🟩⬜️<br>⬜️⬜⬜⬜️<br>⬜️⬜️⬜️⬜️ | ⬜️⬜⬜⬜️<br>⬜️⬜️⬜️⬜️<br>🟩🟩🟩⬜<br>⬜️🟩⬜️⬜ |

**학습 과정:**

<table>
  <tr>
    <td>
      <ol>
        <li>위 예시를 참고하여 하나의 'T' 패턴을 LED 그리드에 만듭니다.</li>
        <li>학습 목표를 <strong>"Positive Target"</strong>으로 설정합니다.</li>
        <li><strong>"Learn"</strong> 버튼을 눌러 학습을 진행합니다.</li>
        <li>다른 형태의 'T' 패턴을 번갈아 가며 반복적으로 학습시킵니다.</li>
      </ol>
    </td>
    <td width="200">
      <img src="/screenshots/t_pattern_learn.gif" alt="T Pattern Demo" />
    </td>
  </tr>
</table>

#### **'J' 패턴 학습 (Negative Target)**

'J' 패턴은 오른쪽 상단에서 시작하여 아래로 내려오다 왼쪽으로 꺾이는 형태를 가집니다. 다양한 크기나 꺾이는 지점의 'J'를 학습시켜 퍼셉트론이 'J'의 특징을 인식하도록 할 수 있습니다.

**예시 'J' 패턴 (다양한 형태):**

| | | | |
| :---: | :---: | :---: | :---: |
| ⬜️⬜️⬜️🟩<br>⬜️⬜️⬜️🟩<br>⬜️🟩⬜️🟩<br>⬜️🟩🟩🟩 | ⬜️⬜️🟩⬜<br>⬜️⬜️🟩⬜<br>🟩⬜️🟩⬜<br>️🟩🟩🟩⬜ | ⬜️⬜️⬜️🟩<br>⬜️️⬜️⬜️🟩<br>⬜️🟩⬜️🟩<br>⬜️⬜️🟩⬜ | ⬜️⬜️🟩⬜<br>⬜️⬜️🟩⬜<br>🟩⬜️🟩⬜<br>⬜🟩🟩⬜ |

**학습 과정:**

<table>
  <tr>
    <td>
      <ol>
        <li>위 예시를 참고하여 하나의 'J' 패턴을 LED 그리드에 만듭니다.</li>
        <li>학습 목표를 <strong>"Negative Target"</strong>으로 설정합니다.</li>
        <li><strong>"Learn"</strong> 버튼을 눌러 학습을 진행합니다.</li>
        <li>다른 형태의 'J' 패턴을 번갈아 가며 반복적으로 학습시킵니다.</li>
      </ol>
    </td>
    <td width="200">
      <img src="/screenshots/j_pattern_learn.gif" alt="J Pattern Demo" />
    </td>
  </tr>
</table>

### **Guide**: 학습 결과 확인 및 재학습

#### **Check Results**

<table>
  <tr>
    <td>
      패턴을 학습시킨 후, 화면 하단의 "Learned Patterns" 목록에서 학습된 패턴들을 확인할 수 있습니다.
      <br><br>
      각 패턴 카드에는 해당 패턴에 대한 퍼셉트론의 <code>Net Input</code> 값이 표시됩니다.
    </td>
    <td width="200">
      <img src="/screenshots/pattern_result.gif" alt="Pattern Result Demo" />
    </td>
  </tr>
</table>

#### **Troubleshooting**

학습을 진행하다 보면, 특정 패턴에 대해 퍼셉트론의 분류 결과(`Net Input`의 부호)가 설정했던 학습 목표(Positive/Negative)와 일치하지 않는 경우가 발생할 수 있습니다. 예를 들어, 'J' 패턴을 Negative 학습시켰는데 `Net Input`이 양수(Positive)로 나오는 경우입니다.

이러한 불일치는 퍼셉트론이 아직 해당 패턴을 정확히 인식하지 못하고 있음을 의미합니다. 이 경우, 해당 패턴을 다시 불러와 **올바른 학습 목표를 설정한 후 "Learn" 버튼을 다시 눌러 재학습**시키면 됩니다. 퍼셉트론은 잘못 분류된 패턴에 대해 가중치와 편향을 조정하여 다음번에는 올바르게 분류하도록 학습합니다.

**재학습 과정:**

<table>
  <tr>
    <td>
      <ol>
        <li>"Learned Patterns" 목록에서 분류가 잘못된 패턴 카드를 탭하여 LED 그리드에 해당 패턴을 불러옵니다.</li>
        <li>화면 상단의 <code>Net Input</code> 값과 색상을 확인하여 현재 퍼셉트론이 이 패턴을 어떻게 분류하고 있는지 파악합니다.</li>
        <li>만약 분류가 잘못되었다면 (예: Positive 목표였는데 빨간색으로 표시), 올바른 학습 목표("Positive Target" 또는 "Negative Target")가 선택되어 있는지 확인합니다.</li>
        <li><strong>"Learn"</strong> 버튼을 다시 눌러 퍼셉트론을 재학습시킵니다.</li>
        <li>이 과정을 반복하여 모든 학습된 패턴이 올바르게 분류될 때까지 훈련할 수 있습니다.</li>
      </ol>
    </td>
    <td width="200">
      <img src="/screenshots/mismatch_relearn.gif" alt="Mismatch Relearn Demo" />
    </td>
  </tr>
</table>

---

## **Installation**

### **Android**

1.  [single_perceptron.apk](./single_perceptron.apk) 링크를 클릭하거나, 아래 QR 코드를 스캔하여 APK 파일을 다운로드합니다.

    <img src="./single_perceptron.qr.png" width="200">

2.  Android 기기에서 다운로드한 APK 파일을 설치합니다.
