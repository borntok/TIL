-- 그룹함수
-- 1. ROLLUP: 오라클에서는 GROUP BY의 컬럼에 대한 소계, 합계를 구하는 함수
SELECT DECODE(DEPTNO, NULL, '전체합계', ' ') TOT, -- DEPTNO가 NULL이면 전체합계를 출력
       DECODE(DEPTNO, NULL, ' ', 10, '인사팀', 20, '관리팀', 30, '전산팀') "부서", -- 부서번호가 NULL이면 공백, 10번 인사팀 등으로 출력
       SUM(SAL)
 FROM EMP
GROUP BY ROLLUP(DEPTNO); -- ROLLUP 함수를 이용하면 부서별 합계 및 전체합계를 구할 수 있음

-- 부서별, 직업별 ROLLUP을 실행하면 부서별 합계, 직업별 합계, 전체 합계가 모두 조회된다.
SELECT DEPTNO, JOB, SUM(SAL)
 FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO;

-- 2. GROUPING: ROLLUP, CUBE, GROUPING SETS에서 생성되는 합계 값을 구분하기 위해 사용
-- 소계, 합계가 구해지면 GROUPING 함수는 1을 리턴해주고 그렇지 않으면 0을 리턴
-- DECODE함수와 함께 사용하면 고객이 원하는 데이터 형태로 작성해서 제공 가능
SELECT DEPTNO, 
       DECODE(GROUPING(DEPTNO),0, ' ','전체합계') TOT,
       DECODE(GROUPING(JOB),0,' ', '부서합계') TOT_DEPT, 
       SUM(SAL)
  FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO;

-- 3. GROUPING SETS: GROUP BY에 나오는 컬럼의 순서에 상관없이 다양한 소계를 만들 수 있다
SELECT DEPTNO, JOB, SUM(SAL)
  FROM EMP
GROUP BY GROUPING SETS(JOB, DEPTNO) -- 컬럼별로 독립적으로 계산. 순서에 관계X
ORDER BY DEPTNO, JOB;

-- 4. CUBE: 제시한 컬럼에 대해서 결합 가능한 모든 집계를 계산, 다차원 집계, 다양한 데이터 분석
SELECT DEPTNO, JOB, SUM(SAL)
  FROM EMP
GROUP BY CUBE(DEPTNO, JOB); -- 전체합계, 직업별 합계, 부서별 합계, 직업별 부서별 합계