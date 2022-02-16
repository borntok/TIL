# -*- coding: utf-8 -*-
"""
Created on Wed Feb 16 17:46:26 2022

@author: LGE1
"""

#%%

# =============================================================================
# 3.주어진 데이터를 사용하여 성별을 구분할 수 있는지 로지스틱 회귀분석을 적용하여
# 알아 보고자 한다. 
# - 데이터를 7대 3으로 나누어 각각 Train과 Test set로 사용한다. 이 때 seed는 123으로
# 한다.
# - 원 데이터에 있는 7개의 변수만 Feature로 사용하고 gender를 label로 사용한다.
# (forehead_ratio는 사용하지 않음)
# - 로지스틱 회귀분석 예측 함수와 Test dataset를 사용하여 예측을 수행하고 정확도를
# 평가한다. 이 때 임계값은 0.5를 사용한다. 
# - Male의 Precision 값을 소수점 둘째 자리까지 반올림하여 기술하시오. (답안 예시) 
# 0.12
# 
# 
# (참고) 
# from sklearn.linear_model import LogisticRegression
# from sklearn.model_selection import train_test_split
# from sklearn import metrics
# train_test_split 의 random_state = 123
# =============================================================================

q3 = data03.copy()
q3.columns

#['long_hair', 'forehead_width_cm', 'forehead_height_cm', 'nose_wide',
#     'nose_long', 'lips_thin', 'distance_nose_to_lip_long', 'gender']

from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import precision_score, classification_report

train, test = train_test_split(q3, test_size=0.3, random_state=123)

var_list = q3.columns.drop('gender')

logit = LogisticRegression().fit(train[var_list], train['gender'])

q3_pred = logit.predict(test[var_list])

precision_score(test['gender'], q3_pred, pos_label='Male')
print(classification_report(test['gender'], q3_pred))

# 답: 0.96

dir(logit)
logit.coef_
q3_pred_pr = logit.predict_proba(test[var_list])



#%%

# =============================================================================
# =============================================================================
# # 문제 04 유형(DataSet_04.csv 이용)
#
#구분자 : comma(“,”), 6,718 Rows, 4 Columns, UTF-8 인코딩

# 한국인의 식생활 변화가 건강에 미치는 영향을 분석하기에 앞서 육류
# 소비량에 대한 분석을 하려고 한다. 확보한 데이터는 세계 각국의 1인당
# 육류 소비량 데이터로 아래와 같은 내용을 담고 있다.

# 컬 럼 / 정 의 / Type
# LOCATION / 국가명 / String
# SUBJECT / 육류 종류 (BEEF / PIG / POULTRY / SHEEP) / String
# TIME / 연도 (1990 ~ 2026) / Integer
# Value / 1인당 육류 소비량 (KG) / Double
# =============================================================================
# =============================================================================

data04 = pd.read_csv('DataSet_04.csv')
data04.info()
# (참고)
# #1
# import pandas as pd
# import numpy as np
# #2
# from scipy.stats import ttest_rel
# #3
# from sklearn.linear_model import LinearRegression

#%%

# =============================================================================
# 1.한국인의 1인당 육류 소비량이 해가 갈수록 증가하는 것으로 보여 상관분석을 통하여
# 확인하려고 한다. 
# - 데이터 파일로부터 한국 데이터만 추출한다. 한국은 KOR로 표기되어 있다.
# - 년도별 육류 소비량 합계를 구하여 TIME과 Value간의 상관분석을 수행하고
# 상관계수를 소수점 셋째 자리에서 반올림하여 소수점 둘째 자리까지만 기술하시오. 
# (답안 예시) 0.55
# =============================================================================

data04.columns
# ['LOCATION', 'SUBJECT', 'TIME', 'Value']

q1 = data04[data04.LOCATION == 'KOR']

q1_tab = q1.groupby('TIME')['Value'].sum()

q1_tab2 = q1_tab.reset_index()
q1_tab2.corr()['TIME']['Value']

# 답: 0.96

#%%

# =============================================================================
# 2. 한국 인근 국가 가운데 식생의 유사성이 상대적으로 높은 일본(JPN)과 비교하여, 연도별
# 소비량에 평균 차이가 있는지 분석하고자 한다.
# - 두 국가의 육류별 소비량을 연도기준으로 비교하는 대응표본 t 검정을 수행하시오.
# - 두 국가 간의 연도별 소비량 차이가 없는 것으로 판단할 수 있는 육류 종류를 모두
# 적으시오. (알파벳 순서) (답안 예시) BEEF, PIG, POULTRY, SHEEP
# =============================================================================

from scipy.stats import ttest_rel

q2 = data04[data04.LOCATION.isin(['KOR', 'JPN'])]

sub_list = q2.SUBJECT.unique()
# ['BEEF', 'PIG', 'POULTRY', 'SHEEP']

q2_out2 = []
for i in sub_list:
    temp = q2[q2.SUBJECT == i]
    q2_tab = pd.pivot_table(temp, index='TIME', columns='LOCATION', values='Value').dropna()

    q2_out = ttest_rel(q2_tab['KOR'], q2_tab['JPN']) #alternative로 양측검정, 단측검정 변경 가능
    pvalue = q2_out.pvalue
    q2_out2.append([i, pvalue])
    
q2_out2 = pd.DataFrame(q2_out2, columns=['sub', 'pvalue'])

q2_out2[q2_out2.pvalue >= 0.05] 

# (차이가 없는 경우) 답: POULTRY

# [참]
q2_out2[q2_out2.pvalue < 0.05]   
# 차이가 있는 경우 답: BEEF, PIG, SHEEP


# =============================================================================
# 3.(한국만 포함한 데이터에서) Time을 독립변수로, Value를 종속변수로 하여 육류
# 종류(SUBJECT) 별로 회귀분석을 수행하였을 때, 가장 높은 결정계수를 가진 모델의
# 학습오차 중 MAPE를 반올림하여 소수점 둘째 자리까지 기술하시오. (답안 예시) 21.12
# (MAPE : Mean Absolute Percentage Error, 평균 절대 백분율 오차)
# (MAPE = Σ ( | y - y ̂ | / y ) * 100/n ))
# 
# =============================================================================

from sklearn.linear_model import LinearRegression

q3 = q1.copy()

sub_list = q3.SUBJECT.unique()

q3_out = []
for i in sub_list:
    temp = q3[q3.SUBJECT == i]
    lm = LinearRegression().fit(temp[['TIME']], temp['Value'])
    r2 = lm.score(temp[['TIME']], temp['Value'])
    pred = lm.predict(temp[['TIME']])

    mape = (abs(temp['Value']-pred)/ temp['Value']).sum() * 100 / len(temp)
    q3_out.append([i, r2, mape])
print(q3_out)

q3_out = pd.DataFrame(q3_out, columns=['sub', 'r2', 'mape'])
q3_out.loc[q3_out.r2.idxmax(), :]

# 답: 5.78

#%%

# =============================================================================
# =============================================================================
# # 문제 05 유형(DataSet_05.csv 이용)
#
# 구분자 : comma(“,”), 8,068 Rows, 12 Columns, UTF-8 인코딩
#
# A자동차 회사는 신규 진입하는 시장에 기존 모델을 판매하기 위한 마케팅 전략을 
# 세우려고 한다. 기존 시장과 고객 특성이 유사하다는 전제 하에 기존 고객을 세분화하여
# 각 그룹의 특징을 파악하고, 이를 이용하여 신규 진입 시장의 마케팅 계획을 
# 수립하고자 한다. 다음은 기존 시장 고객에 대한 데이터이다.
#

# 컬 럼 / 정 의 / Type
# ID / 고유 식별자 / Double
# Age / 나이 / Double
# Age_gr / 나이 그룹 (10/20/30/40/50/60/70) / Double
# Gender / 성별 (여성 : 0 / 남성 : 1) / Double
# Work_Experience / 취업 연수 (0 ~ 14) / Double
# Family_Size / 가족 규모 (1 ~ 9) / Double
# Ever_Married / 결혼 여부 (Unknown : 0 / No : 1 / Yes : 2) / Double
# Graduated / 재학 중인지 여부 / Double
# Profession / 직업 (Unknown : 0 / Artist ~ Marketing 등 9개) / Double
# Spending_Score / 소비 점수 (Average : 0 / High : 1 / Low : 2) / Double
# Var_1 / 내용이 알려지지 않은 고객 분류 코드 (0 ~ 7) / Double
# Segmentation / 고객 세분화 결과 (A ~ D) / String
# =============================================================================
# =============================================================================


#(참고)
#1
# import pandas as pd
# #2
# from scipy.stats import chi2_contingency
# #3
# from sklearn.model_selection import train_test_split
# from sklearn import metrics
# from sklearn.tree import DecisionTreeClassifier
# from sklearn.tree import export_graphviz
# import pydot


data05 = pd.read_csv('DataSet_05.csv', na_values=['?', ' ', 'NA', ''])
data05.info()

#%%

# =============================================================================
# 1.위의 표에 표시된 데이터 타입에 맞도록 전처리를 수행하였을 때, 데이터 파일 내에
# 존재하는 결측값은 모두 몇 개인가? 숫자형 데이터와 문자열 데이터의 결측값을
# 모두 더하여 답하시오.
# (String 타입 변수의 경우 White Space(Blank)를 결측으로 처리한다) (답안 예시) 123
# =============================================================================

data05.columns
# ['ID', 'Age', 'Age_gr', 'Gender', 'Work_Experience', 'Family_Size',
#  'Ever_Married', 'Graduated', 'Profession', 'Spending_Score', 'Var_1',
#  'Segmentation']

data05.isna().sum().sum()

# 답: 1166

#%%

# =============================================================================
# 2.이어지는 분석을 위해 결측값을 모두 삭제한다. 그리고, 성별이 세분화(Segmentation)에
# 영향을 미치는지 독립성 검정을 수행한다. 수행 결과, p-value를 반올림하여 소수점
# 넷째 자리까지 쓰고, 귀무가설을 기각하면 Y로, 기각할 수 없으면 N으로 기술하시오. 
# (답안 예시) 0.2345, N
# =============================================================================

q2 = data05.dropna()

from scipy.stats import chi2_contingency

tab = pd.crosstab(index=q2.Gender, columns=q2.Segmentation)
q2_out = chi2_contingency(tab)
q2_out[1] < 0.05

# 답: 0.0031, Y

#%%

# =============================================================================
# 3.Segmentation 값이 A 또는 D인 데이터만 사용하여 의사결정 나무 기법으로 분류
# 정확도를
# 측정해 본다. 
# - 결측치가 포함된 행은 제거한 후 진행하시오.
# - Train대 Test 7대3으로 데이터를 분리한다. (Seed = 123)
# - Train 데이터를 사용하여 의사결정나무 학습을 수행하고, Test 데이터로 평가를
# 수행한다.
# - 의사결정나무 학습 시, 다음과 같이 설정하시오:
# • Feature: Age_gr, Gender, Work_Experience, Family_Size, 
#             Ever_Married, Graduated, Spending_Score
# • Label : Segmentation
# • Parameter : Gini / Max Depth = 7 / Seed = 123
# 이 때 전체 정확도(Accuracy)를 소수점 셋째 자리 이하는 버리고 소수점 둘째자리까지
# 기술하시오.
# (답안 예시) 0.12
# =============================================================================

q3 = q2[q2.Segmentation.isin(['A','D'])]

from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier

train, test = train_test_split(q3, test_size=0.3, random_state=123)

var_list = ['Age_gr', 'Gender', 'Work_Experience', 'Family_Size', 'Ever_Married', 
            'Graduated', 'Spending_Score']

dt = DecisionTreeClassifier(max_depth=7, random_state=123)
dt.fit(train[var_list], train['Segmentation'])

acc = dt.score(test[var_list], test['Segmentation'])

# 답: 0.68

# from sklearn.metrics import accuracy_score

#%%

# =============================================================================
# =============================================================================
# # 문제 06 유형(DataSet_06.csv 이용)
#
# 구분자 : comma(“,”), 4,323 Rows, 19 Columns, UTF-8 인코딩

# 주택 관련 정보를 바탕으로 주택 가격을 예측해 보고자 한다. 
# 다음은 확보한 주택 관련 데이터로 총 19개 컬럼으로 구성되어
# 있다.

# 컬 럼 / 정 의 / Type
# id / 매물 번호 / Double
# date / 날짜 / String
# price / 거래 가격 / Double
# bedrooms / 방 개수 / Double
# bathrooms / 화장실 개수 (화장실은 있으나 샤워기 없는 경우 0.5로 처리) / Double
# sqft_living / 건축물 면적 / Double
# sqft_lot / 대지 면적 / Double
# floors / 건축물의 층수 / Double
# waterfront / 강변 조망 가능 여부 (0 / 1) / Double
# view / 경관 (나쁨에서 좋음으로 0 ~ 4로 표시) / Double
# condition / 관리 상태 (나쁨에서 좋음으로 1 ~ 5로 표시) / Double
# grade / 등급 (낮음에서 높음으로 1 ~ 13으로 표시) / Double
# sqft_above / 지상 면적 / Double
# sqft_basement / 지하실 면적 / Double
# yr_built / 건축 연도 / Double
# yr_renovated / 개축 연도 / Double
# zipcode / 우편번호 / Double
# sqft_living15 / 15개의 인근 주택의 평균 건물 면적 / Double
# sqft_lot15 / 15개의 인근 주택의 평균 대지 면적 / Double
# =============================================================================
# =============================================================================

data06 = pd.read_csv('DataSet_06.csv')
data06.info()

#%%

# =============================================================================
# 1.강변 조망이 가능한지 여부(waterfront)에 따라 평균 주택 가격을 계산하고 조망이
# 가능한 경우와 그렇지 않은 경우의 평균 가격 차이의 절대값을 구하시오. 답은
# 소수점 이하는 버리고 정수부만 기술하시오. (답안 예시) 1234567
# =============================================================================

q1_0 = data06[data06.waterfront==0]['price'].mean()
q1_1 = data06[data06.waterfront==1]['price'].mean()

abs(q1_0 - q1_1)

# 답: 1167272

#%%

# =============================================================================
# 2.price, bedrooms, bathrooms, sqft_living, sqft_lot, floors, yr_built 등 7개의 변수 간의
# 상관분석을 수행하고 price와의 상관계수의 절대값이 가장 큰 변수와 가장 작은
# 변수를 차례로 기술하시오. (답안 예시) view, zipcode
# 
# =============================================================================

var_list = ["price", "bedrooms", "bathrooms", "sqft_living", "sqft_lot", "floors", "yr_built"] 

q2 = data06[var_list].corr().drop('price')['price']

abs(q2).sort_values(ascending=False)

# 답: sqft_living, yr_built



#%%

# =============================================================================
# 3. id, date, 그리고 zipcode를 제외한 모든 변수를 독립변수로, price를 종속변수로 하여
# 회귀분석을 수행하시오. 통계적 유의성을 갖지 못하는 독립변수를 제거하면 회귀
# 모형에 남는 변수는 모두
# 몇 개인가? 이 때 음의 회귀계수를 가지는 변수는 몇 개인가? (답안 예시) 5, 3
# =============================================================================

# =============================================================================
# (참고)
# import pandas as pd
# import numpy as np
# from sklearn.linear_model import LinearRegression
# from statsmodels.formula.api import ols
# =============================================================================

var_list = data06.columns.drop(['id', 'date', 'zipcode', 'price'])

from statsmodels.formula.api import ols

form = 'price~' + '+'.join(var_list)

lm = ols(form, data=data06).fit()

q3_out = lm.pvalues.drop('Intercept') < 0.05
sum(q3_out)

sum(lm.params.drop('Intercept')[q3_out] < 0)

# 답: 13, 2
#%%

# =============================================================================
# =============================================================================
# # 문제 10 유형(DataSet_10.csv 이용)
#
# 구분자 : comma(“,”), 1538 Rows, 6 Columns, UTF-8 인코딩

# 중고 자동차 가격에 대한 분석을 위하여 아래와 같은 데이터를
# 확보하였다.

# 컬 럼 / 정 의 / Type
# model / 모델명 / String
# engine_power / 엔진 파워 / Double
# age_in_days / 운행 일수 / Double
# km / 운행 거리 / Double
# previous_owners / 이전 소유자 수 / Double
# price / 중고차 가격 / Double
# =============================================================================
# =============================================================================

# =============================================================================
# (참고)
# #1
# import pandas as pd
# import numpy as np
# #2
# import scipy.stats as ststs
# #3
# from sklearn.linear_model import LinearRegression
# =============================================================================

data10 = pd.read_csv('DataSet_10.csv')
data10.info()

#%%

# =============================================================================
# 1.이전 소유자 수가 한 명이고 엔진 파워가 51인 차에 대해 모델별 하루 평균 운행
# 거리를 산출하였을 때 가장 낮은 값을 가진 모델이 가장 큰 값을 가진 모델에 대한
# 비율은 얼마인가? 소수점 셋째 자리에서 반올림하여 소수점 둘째 자리까지
# 기술하시오.
# (모델별 평균 → 일평균 → 최대최소 비율 계산) (답안 예시) 0.12
# =============================================================================

q1 = data10[(data10.previous_owners == 1) & (data10.engine_power == 51)]

# 모델별 평균
q1_tab = q1.groupby('model')[['age_in_days', 'km']].mean()

# 일평균
q1_tab['km_per_day'] = q1_tab['km'] / q1_tab['age_in_days']

# 최대최소 비율
q1_tab['km_per_day'].min() / q1_tab['km_per_day'].max()

# 답: 0.97

#%%

# =============================================================================
# 2.운행 일수에 대한 운행 거리를 산출하고, 위 1번 문제에서 가장 큰 값을 가지고 있던
# 모델과 가장 낮은 값을 가지고 있던 모델 간의 운행 일수 대비 운행거리 평균이 다른지
# 적절한 통계 검정을 수행하고 p-value를 소수점 세자리 이하는 버리고 소수점
# 두자리까지 기술하고 기각 여부를 Y / N로 답하시오. (등분산을 가정하고 equal_var = 
# True / var.equal = T로 분석을 실행하시오.)
# (답안 예시) 0.23, Y
# =============================================================================

max_m = q1_tab['km_per_day'].idxmax()
min_m = q1_tab['km_per_day'].idxmin()

# 변수 만들기
q2 = data10.copy()
q2['km_per_day'] = q2['km'] / q2['age_in_days']

from scipy.stats import ttest_ind, bartlett # 등분산검정

q2_out = ttest_ind(q2[q2.model==max_m]['km_per_day'],
                   q2[q2.model==min_m]['km_per_day'],
                   equal_var=True)

q2_out.pvalue

# 답: 0.13, N

# [참고] 등분산검정
bartlett(q2[q2.model==max_m]['km_per_day'],
         q2[q2.model==min_m]['km_per_day'])
# H0: 등분산이다
# H1: 등분산이 아니다(이분산이다)

#%%

# =============================================================================
# 3.독립변수로 engine_power, age_in_days, km를 사용하고 종속변수로 price를 사용하여
# 모델별 선형회귀분석을 수행하고, 산출된 모형을 사용하여 다음과 같은 조건의
# 중고차에 대한 가격을 예측하고 예측된 가격을 정수부만 기술하시오.
# - model : pop / engine_power : 51 / age_in_days : 400 / 
# km : 9500 / previous_owners : 2

# (답안 예시) 12345
# =============================================================================
# model = pop이고 이전 소유자수가 2명인 데이터만을 이용하여 회귀모델을 생성하시오.

# q3 = data10[data10.previous_owners == 2]
q3 = data10[(data10.previous_owners == 2) & (data10.model == 'pop')]

from sklearn.linear_model import LinearRegression

var_list = ['engine_power', 'age_in_days', 'km']

lm = LinearRegression().fit(q3[var_list], q3['price'])

lm.predict([[51, 400, 9500]])
lm.predict(pd.DataFrame({'engine_power': [51],
                         'age_in_day': [400],
                         'km': [9500]}))

# 답: 10367
#%%

# =============================================================================
# =============================================================================
# # 문제 11 유형(DataSet_11.csv 이용)

# 구분자 : comma(“,”), 470 Rows, 4 Columns, UTF-8 인코딩

# 세계 각국의 행복지수를 비롯한 여러 정보를 조사한 DS리서치는
# 취합된 자료의 현황 파악 및 간단한 통계분석을 실시하고자 한다.

# 컬 럼 / 정 의 / Type
# Country / 국가명 / String
# Happiness_Rank / 당해 행복점수 순위 / Double
# Happiness_Score / 행복점수 / Double
# year / 년도 / Double
# =============================================================================
# =============================================================================

data11 = pd.read_csv('DataSet_11.csv')
data11.info()

#%%

# =============================================================================
# 1.분석을 위해 3년 연속 행복지수가 기록된 국가의 데이터를 사용하고자 한다. 
# 3년 연속 데이터가 기록되지 않은 국가의 개수는?
# - 국가명 표기가 한 글자라도 다른 경우 다른 국가로 처리하시오.
# - 3년 연속 데이터가 기록되지 않은 국가 데이터는 제외하고 이를 향후 분석에서
# 활용하시오.(답안 예시) 1
# =============================================================================

data11.columns
q1 = pd.pivot_table(data11, index='Country', columns='year', values='Happiness_Score',
                    aggfunc='mean')

q1.isna().any(axis=1).sum()

# (data11.groupby('Country').apply(len)
# 답: 20

#%%

# =============================================================================
# 2.(1번 산출물을 활용하여) 2017년 행복지수와 2015년 행복지수를 활용하여 국가별
# 행복지수 증감률을 산출하고 행복지수 증감률이 가장 높은 3개 국가를 행복지수가
# 높은 순서대로 차례대로 기술하시오.
# 증감률 = (2017년행복지수−2015년행복지수)/2
# 
# - 연도는 년월(YEAR_MONTH) 변수로부터 추출하며, 연도별 매출금액합계는 1월부터
# 12월까지의 매출 총액을 의미한다. (답안 예시) Korea, Japan, China
# =============================================================================

q2 = q1.dropna()

q2['ratio'] = (q2[2017] - q2[2015])/ 2

q2['ratio'].nlargest(3).index

# 답: Latvia, Romania, Togo

#%%

# =============================================================================
# 3.(1번 산출물을 활용하여) 년도별 행복지수 평균이 유의미하게 차이가 나는지
# 알아보고자 한다. 
# 이와 관련하여 적절한 검정을 사용하고 검정통계량을 기술하시오.
# - 해당 검정의 검정통계량은 자유도가 2인 F 분포를 따른다.
# - 검정통계량은 소수점 넷째 자리까지 기술한다. (답안 예시) 0.1234
# =============================================================================


from scipy.stats import f_oneway

from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm

f_oneway(q2[2015], q2[2016], q2[2017])

# 답: 0.0042
#%%


# =============================================================================
# =============================================================================
# # 문제 05 유형(Dataset_05_Mart_POS.csv /  이용)
#
# =============================================================================
# Dataset_05_Mart_POS.csv 
# 구분자 : comma(“,”), 20488 Rows, 3 Columns, UTF-8 인코딩
# =============================================================================
#
# 원룸촌에 위치한 A마트는 데이터 분석을 통해 보다 체계적인 재고관리와
# 운영을 하고자 한다. 이를 위해 다음의 두 데이터 세트를 준비하였다.
#
# 컬 럼 / 정 의 / Type
# Member_number / 고객 고유 번호 / Double
# Date / 구매일 / String
# itemDescription / 상품명 / String

# =============================================================================
# Dataset_05_item_list.csv 
# 구분자 : comma(“,”), 167 Rows, 4 Columns, UTF-8 인코
# =============================================================================
#
# 컬 럼 / 정 의 / Type
# prod_id / 상품 고유 번호 / Double
# prod_nm / 상품명 / String
# alcohol / 주류 상품 여부(1 : 주류) / Integer
# frozen / 냉동 상품 여부(1 : 냉동) / Integer
# =============================================================================
# =============================================================================

pos = pd.read_csv('Dataset_05_Mart_POS.csv')
list1 = pd.read_csv('Dataset_05_item_list.csv')


#%%

# =============================================================================
# 1.(Dataset_05_Mart_POS.csv를 활용하여) 가장 많은 제품이 팔린 날짜에 가장 많이 팔린
# 제품의 판매 개수는? (답안 예시) 1
# =============================================================================

pos.columns
# ['Member_number', 'Date', 'itemDescription']

list1.columns
# ['prod_id', 'prod_nm', 'alcohol', 'frozen']

q1 = pos['Date'].value_counts().idxmax()

pos[pos.Date == q1]['itemDescription'].value_counts().max()

# 답: 7

#%%

# =============================================================================
# 2. (Dataset_05_Mart_POS.csv, Dataset_05_item_list.csv를 활용하여) 고객이 주류 제품을
# 구매하는 요일이 다른 요일에 비해 금요일과 토요일이 많을 것이라는 가설을 세웠다. 
# 이를 확인하기 위해 금요일과 토요일의 일별 주류제품 구매 제품 수 평균과 다른
# 요일의 일별 주류제품 구매 제품 수 평균이 서로 다른지 비교하기 위해 독립 2표본
# t검정을 실시하시오. 
# 해당 검정의 p-value를 기술하시오.
# - 1분기(1월 ~ 3월) 데이터만 사용하여 분석을 실시하시오.
# - 등분산 가정을 만족하지 않는다는 조건 하에 분석을 실시하시오.
# - p-value는 반올림하여 소수점 둘째 자리까지 기술하시오. (답안 예시) 0.12
# =============================================================================


# 변수 추가- 요일, 월
# 문자열, 날짜 핸들링

type(pos.Date)
pos.Date.dtype

pos.itemDescription.str.slice(0, 1)

pd.to_datetime(pos.Date).dt.month
pd.to_datetime(pos.Date).dt.day_name(locale='ko_kr')

pos1 = pos.copy()

pos1['month'] = pd.to_datetime(pos1.Date).dt.month
pos1['day'] = pd.to_datetime(pos1.Date).dt.day_name(locale='ko_kr')
pos1['week'] = np.where(pos1['day'].isin(['금요일', '토요일']), 1, 0)

# 데이터 결합
merge1 = pd.merge(pos1, list1, left_on='itemDescription', right_on='prod_nm', how='left')

# 필터링
merge2 = merge1[merge1.month.isin([1,2,3])]

# 평균 차이 검정 진행
q2_tab = pd.pivot_table(merge2, index='Date', columns='week', values='alcohol', aggfunc='sum')

from scipy.stats import ttest_ind

q2_out = ttest_ind(q2_tab[0].dropna(), q2_tab[1].dropna(), equal_var=False)

q2_out.pvalue

# 답: 0.02

#%%

# =============================================================================
# 3.(Dataset_05_Mart_POS.csv를 활용하여) 1년 동안 가장 많이 판매된 10개 상품을 주력
# 상품으로 설정하고 특정 요일에 프로모션을 진행할지 말지 결정하고자 한다. 먼저
# 요일을 선정하기 전에 일원 분산 분석을 통하여 요일별 주력 상품의 판매 개수의
# 평균이 유의미하게 차이가 나는지 알아보고자 한다. 이와 관련하여 일원 분산 분석을
# 실시하고 p-value를 기술하시오.
# - p-value는 반올림하여 소수점 둘째 자리까지 기술하시오. (답안 예시) 0.12
# 
# (참고)
# from statsmodels.formula.api import ols
# from statsmodels.stats.anova import anova_lm
# =============================================================================

q3 = pos1.copy()

# 주력 상품 추출
top10 = pos1.itemDescription.value_counts().nlargest(10)
top10_list = top10.index

q3 = pos1[pos1.itemDescription.isin(top10_list)]

q3_agg = q3.groupby(['Date', 'day'])['itemDescription'].apply(len).reset_index()

# 분산분석

from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm

anova = ols('itemDescription~day', data=q3_agg).fit()
q3_out = anova_lm(anova)

print(q3_out)

q3_out['PR(>F)'][0]

# 답: 0.52