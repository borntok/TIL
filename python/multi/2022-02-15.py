# -*- coding: utf-8 -*-
"""
Created on Tue Feb 15 17:55:08 2022

@author: LGE1
"""

#%%

# =============================================================================
# =============================================================================
# # 문제 01 유형(DataSet_01.csv 이용)
#
# 구분자 : comma(“,”), 4,572 Rows, 5 Columns, UTF-8 인코딩
# 
# 글로벌 전자제품 제조회사에서 효과적인 마케팅 방법을 찾기
# 위해서 채널별 마케팅 예산과 매출금액과의 관계를 분석하고자
# 한다.
# 컬 럼 / 정 의  /   Type
# TV   /     TV 마케팅 예산 (억원)  /   Double
# Radio / 라디오 마케팅 예산 (억원)  /   Double
# Social_Media / 소셜미디어 마케팅 예산 (억원)  / Double
# Influencer / 인플루언서 마케팅
# (인플루언서의 영향력 크기에 따라 Mega / Macro / Micro / 
# Nano) / String

# SALES / 매출액 / Double
# =============================================================================
# =============================================================================
#%%
import pandas as pd
import numpy as np

data01 = pd.read_csv('Dataset_01.csv')
data01.info()
#%%

# =============================================================================
# 1. 데이터 세트 내에 총 결측값의 개수는 몇 개인가? (답안 예시) 23
# =============================================================================
data01.isna().sum().sum()


data01.columns

# ['TV', 'Radio', 'Social_Media', 'Influencer', 'Sales']
data01[['TV', 'Radio', 'Social_Media']].isna().sum().sum()

# [참고] 결측치가 포함된 행
# data01.isna().any(axis=1).sum()


#%%

# =============================================================================
# 2. TV, Radio, Social Media 등 세 가지 다른 마케팅 채널의 예산과 매출액과의 상관분석을
# 통하여 각 채널이 매출에 어느 정도 연관이 있는지 알아보고자 한다. 
# - 매출액과 가장 강한 상관관계를 가지고 있는 채널의 상관계수를 소수점 5번째
# 자리에서 반올림하여 소수점 넷째 자리까지 기술하시오. (답안 예시) 0.1234
# =============================================================================

round(data01.corr().drop('Sales')['Sales'].abs().max(), 4)

# [참고]
data01.corr().drop('Sales')['Sales'].abs().max()
data01.corr().drop('Sales')['Sales'].abs().idxmax()
data01.corr().drop('Sales')['Sales'].abs().nlargest(2).index

cor_dat = data01.corr().drop('Sales')['Sales'].abs()
cor_dat.index[cor_dat > 0.6]

# 답: 0.9995



#%%

# =============================================================================
# 3. 매출액을 종속변수, TV, Radio, Social Media의 예산을 독립변수로 하여 회귀분석을
# 수행하였을 때, 세 개의 독립변수의 회귀계수를 큰 것에서부터 작은 것 순으로
# 기술하시오. 
# - 분석 시 결측치가 포함된 행은 제거한 후 진행하며, 회귀계수는 소수점 넷째 자리
# 이하는 버리고 소수점 셋째 자리까지 기술하시오. (답안 예시) 0.123
# =============================================================================

q2 = data01.dropna()

from sklearn.linear_model import LinearRegression
from statsmodels.api import OLS, add_constant
from statsmodels.formula.api import ols


# sklearn LinearRegression
var_list = ['TV', 'Radio', 'Social_Media']
lm = LinearRegression(fit_intercept=True)
lm.fit(q2[var_list], q2.Sales)

dir(lm)

lm.intercept_ # 절편
lm.coef_ # 회귀계수

# statsmodel ols

form1 = 'Sales~' + '+'.join(var_list)
print(form1)

lm2 = ols(form1, data=q2).fit()

dir(lm2)

lm2.summary()
lm2.params.drop('Intercept').sort_values(ascending=False)

# 답: [3.562, 0.004, -0.003]

# [참고] p-value 기준으로 변수 추출
lm2.pvalues < 0.05
    
# [참고] sklearn 사용법
lm = LinearRegression(fit_intercept=True)
lm.fit(q2.TV, q2.Sales) # 입력변수 X는 2차원 구조로 입력

data01.shape
data01['Sales'].shape
data01['Sales'].values.reshape(-1, 1)
data01[['Sales']].shape

q2.index[lm2.outlier_test()['unadj_p'] < 0.05]

# OLS
X = q2[var_list]
y = q2.Sales

lm3 = OLS(y, X).fit()
lm3.summary()

XX = add_constant(X)

lm4 = OLS(y, XX).fit()
lm4.summary()
#%%

# =============================================================================
# =============================================================================
# # 문제 02 유형(DataSet_02.csv 이용)
# 구분자 : comma(“,”), 200 Rows, 6 Columns, UTF-8 인코딩

# 환자의 상태와 그에 따라 처방된 약에 대한 정보를 분석하고자한다
# 
# 컬 럼 / 정 의  / Type
# Age  / 연령 / Integer
# Sex / 성별 / String
# BP / 혈압 레벨 / String
# Cholesterol / 콜레스테롤 레벨 /  String
# Na_to_k / 혈액 내 칼륨에 대비한 나트륨 비율 / Double
# Drug / Drug Type / String
# =============================================================================
# =============================================================================
import pandas as pd
import numpy as np

data02 = pd.read_csv('Dataset_02.csv')
data02.info()


#%%

# =============================================================================
# 1.해당 데이터에 대한 EDA를 수행하고, 여성으로 혈압이 High, Cholesterol이 Normal인
# 환자의 전체에 대비한 비율이 얼마인지 소수점 네 번째 자리에서 반올림하여 소수점 셋째
# 자리까지 기술하시오. (답안 예시) 0.123
# =============================================================================

data02.columns
# ['Age', 'Sex', 'BP', 'Cholesterol', 'Na_to_K', 'Drug']

q1 = data02[['Sex', 'BP', 'Cholesterol']].value_counts(normalize=True)
q1[('F', 'HIGH', 'NORMAL')]

# 답: 0.105

q1_1 = pd.crosstab(index=[data02['Sex'], data02['BP']],
                   columns=data02['Cholesterol'], normalize=True) # noramlize=1, 2
q1_1


#%%

# =============================================================================
# 2. Age, Sex, BP, Cholesterol 및 Na_to_k 값이 Drug 타입에 영향을 미치는지 확인하기
# 위하여 아래와 같이 데이터를 변환하고 분석을 수행하시오. 
# - Age_gr 컬럼을 만들고, Age가 20 미만은 ‘10’, 20부터 30 미만은 ‘20’, 30부터 40 미만은
# ‘30’, 40부터 50 미만은 ‘40’, 50부터 60 미만은 ‘50’, 60이상은 ‘60’으로 변환하시오. 
# - Na_K_gr 컬럼을 만들고 Na_to_k 값이 10이하는 ‘Lv1’, 20이하는 ‘Lv2’, 30이하는 ‘Lv3’, 30 
# 초과는 ‘Lv4’로 변환하시오.
# - Sex, BP, Cholesterol, Age_gr, Na_K_gr이 Drug 변수와 영향이 있는지 독립성 검정을
# 수행하시오.
# - 검정 수행 결과, Drug 타입과 연관성이 있는 변수는 몇 개인가? 연관성이 있는 변수
# 가운데 가장 큰 p-value를 찾아 소수점 여섯 번째 자리 이하는 버리고 소수점 다섯
# 번째 자리까지 기술하시오.
# (답안 예시) 3, 1.23456
# =============================================================================

q2 = data02.copy()

# 파생변수 생성
# np.where(조건) -> 위치값 리턴
# np.where(조건, 참/거짓) -> 조건에 따라 실행

q2['Age_gr'] = np.where(q2.Age < 20, 10,
                np.where(q2.Age < 30, 20,
                 np.where(q2.Age < 40, 30,
                  np.where(q2.Age < 50, 40,
                   np.where(q2.Age < 60, 50, 60)))))
q2['Na_K_gr'] = np.where(q2.Na_to_K <= 10, 'Lv1',
                 np.where(q2.Na_to_K <= 20, 'Lv2',
                  np.where(q2.Na_to_K <= 30, 'Lv3', 'Lv4')))

# 카이제곱검정
from scipy.stats import chi2_contingency

# (1) 빈도 산출
tab = pd.crosstab(index=q2.Sex, columns=q2.Drug)
tab

# (2) 카이제곱검정
q2_out = chi2_contingency(tab)
q2_out

#(2.119248418109203, -> 카이제곱 통계량 sum((O_ij - E_ij)^2/E_ij)
# 0.7138369773987128, -> p-value
# 4, -> 자유도 (r-1)(c-1)
# array([[43.68, 11.04,  7.68,  7.68, 25.92],
#        [47.32, 11.96,  8.32,  8.32, 28.08]])) -> 기대빈도

# (3) 반복문 적용
q2.columns
var_list = ['Sex', 'BP', 'Cholesterol', 'Age_gr', 'Na_K_gr']

q2_out = []
for i in var_list:
    tab = pd.crosstab(index=q2[i], columns=q2.Drug)
    q2_out0 = chi2_contingency(tab)
    pvalue = q2_out0[1]
    q2_out.append([i, pvalue])
    
q2_out = pd.DataFrame(q2_out, columns=['var', 'pvalue'])

# 연관성 높은 변수 찾기
q2_out2 = q2_out[q2_out.pvalue < 0.05]

q2_out2.max()

# 답: 4, 0.00070


# [참고]
idx = q2_out2.pvalue.idxmax()
q2_out2.iloc[idx, :]

#%%

# =============================================================================
# 3.Sex, BP, Cholesterol 등 세 개의 변수를 다음과 같이 변환하고 의사결정나무를 이용한
# 분석을 수행하시오.
# - Sex는 M을 0, F를 1로 변환하여 Sex_cd 변수 생성
# - BP는 LOW는 0, NORMAL은 1 그리고 HIGH는 2로 변환하여 BP_cd 변수 생성
# - Cholesterol은 NORMAL은 0, HIGH는 1로 변환하여 Ch_cd 생성
# - Age, Na_to_k, Sex_cd, BP_cd, Ch_cd를 Feature로, Drug을 Label로 하여 의사결정나무를
# 수행하고 Root Node의 split feature와 split value를 기술하시오. 
# 이 때 split value는 소수점 셋째 자리까지 반올림하여 기술하시오. (답안 예시) Age, 
# 12.345
# =============================================================================

# 파생변수(더미 생성)

q3 = data02.copy()

q3['Sex_cd'] = np.where(q3.Sex == 'M', 0, 1)
q3['BP_cd'] = np.where(q3.BP == 'LOW', 0,
               np.where(q3.BP == 'NORMAL', 1, 2))
q3['CH_cd'] = np.where(q3.Cholesterol == 'NORMAL', 0, 1)

# 의사결정나무 파라미터
var_list = ['Age', 'Na_to_K', 'Sex_cd', 'BP_cd', 'CH_cd']

from sklearn.tree import DecisionTreeClassifier, plot_tree, export_text

dt = DecisionTreeClassifier().fit(q3[var_list], q3.Drug)
plot_tree(dt, max_depth=2, feature_names=var_list, class_names=list(q3.Drug.unique()), precision=3, fontsize=10)

print(export_text(dt, feature_names=var_list))

# 답: Na_to_K, 14.829

#%%

# =============================================================================
# =============================================================================
# # 문제 03 유형(DataSet_03.csv 이용)
# 
# 구분자 : comma(“,”), 5,001 Rows, 8 Columns, UTF-8 인코딩
# 안경 체인을 운영하고 있는 한 회사에서 고객 사진을 바탕으로 안경의 사이즈를
# 맞춤 제작하는 비즈니스를 기획하고 있다. 우선 데이터만으로 고객의 성별을
# 파악하는 것이 가능할 지를 연구하고자 한다.
#
# 컬 럼 / 정 의 / Type
# long_hair / 머리카락 길이 (0 – 길지 않은 경우 / 1 – 긴
# 경우) / Integer
# forehead_width_cm / 이마의 폭 (cm) / Double
# forehead_height_cm / 이마의 높이 (cm) / Double
# nose_wide / 코의 넓이 (0 – 넓지 않은 경우 / 1 – 넓은 경우) / Integer
# nose_long / 코의 길이 (0 – 길지 않은 경우 / 1 – 긴 경우) / Integer
# lips_thin / 입술이 얇은지 여부 0 – 얇지 않은 경우 / 1 –
# 얇은 경우) / Integer
# distance_nose_to_lip_long / 인중의 길이(0 – 인중이 짧은 경우 / 1 – 인중이
# 긴 경우) / Integer
# gender / 성별 (Female / Male) / String
# =============================================================================
# =============================================================================
import pandas as pd
import numpy as np

data03 = pd.read_csv('Dataset_03.csv')
data03.info()


#%%

# =============================================================================
# 1.이마의 폭(forehead_width_cm)과 높이(forehead_height_cm) 사이의
# 비율(forehead_ratio)에 대해서 평균으로부터 3 표준편차 밖의 경우를 이상치로
# 정의할 때, 이상치에 해당하는 데이터는 몇 개인가? (답안 예시) 10
# =============================================================================

q1 = data03.copy()

q1['forehead_ratio'] = q1['forehead_width_cm'] / q1['forehead_height_cm'] 

xbar = q1['forehead_ratio'].mean()
std = q1['forehead_ratio'].std()

UB = xbar + 3*std
LB = xbar - 3*std

len(q1[(q1['forehead_ratio'] > UB) | (q1['forehead_ratio'] < LB)])

# 답: 3

#%%

# =============================================================================
# 2.성별에 따라 forehead_ratio 평균에 차이가 있는지 적절한 통계 검정을 수행하시오.
# - 검정은 이분산을 가정하고 수행한다.
# - 검정통계량의 추정치는 절대값을 취한 후 소수점 셋째 자리까지 반올림하여
# 기술하시오.
# - 신뢰수준 99%에서 양측 검정을 수행하고 결과는 귀무가설 기각의 경우 Y로, 그렇지
# 않을 경우 N으로 답하시오. (답안 예시) 1.234, Y
# =============================================================================

from scipy.stats import ttest_ind, ttest_rel

q1.columns

g_m = q1[q1.gender == 'Male']['forehead_ratio']
g_f = q1[q1.gender == 'Female']['forehead_ratio']

q2_out = ttest_ind(g_m, g_f, equal_var=False)

# Ttest_indResult(statistic=2.9994984197511543, pvalue=0.0027186702390657176)
q2_out.pvalue < 0.01
round(q2_out.statistic, 3)

# 답: 2.999, Y