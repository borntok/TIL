`$ cd 폴더명/` 폴더 이동

`$ cd ..` 상위 폴더로 이동

`$ touch` 파일 생성

`$ mkdir` 폴더 생성

`$ mv` 파일 이동, 이름 변경

`$ rm` 파일 삭제

`$ rm -rf` 폴더 삭제

`$ .파일명` 숨김 파일

`$ ls` 파일 리스트

`$ ls -a` 전체 파일 리스트


# git 01



```
$ git init
$ touch README.md
$ git add README.md
$ git config --global user.name '내이름'
$ git config --global user.email 'github에서@쓸메일주소'
$ cat ~/.gitconfig  # => 입력한 대로 잘 나오는지 확인!
$ git commit -m 'first commit'
```

**NEVER**

1. `~` 에서 `$ git init` 진행
2. 리포 안에 리포 만들기
3. **`$ git init` 입력 전 확인할 점**
   1. `~` 인지
   2. `(master)` 떠 있는지



## 프로젝트 초기화 진행

프로젝트 폴더 생성

```
mkdir new_project
```

README 파일 & gitignore 생성

```
$ touch README.md .gitignore 생성
```

초기화 시점에 1회 입력

```
$ git init 
```

작업하며 계속 입력

```
$ git add .
$ git commit -m 'MESSAGE'
```

모니터링 명령어

```
$ git status  # 현재 상황
$ git log     # commit 로그 
```

원격 저장소 생성 @github.com

원격 저장소(remote repo) 등록하기

```
$ git remote add origin <URL>
```

등록된 저장소 확인

```
$ git remote -v
```

원격 저장소에 PUSH 하기

```
$ git push origin master
```

새로운 컴퓨터에서 기존 원격 저장소 복제하기

```
$ git clone <URL>

```

원격 저장소에 PULL하기

```
$ git pull origin master
```

# git 02

1. ```
   $ git add .
   ```

2. ```
   $ git commit -m '메세지'
   ```

3. ```
   $ git push origin master
   ```

   1.잘 된다 => 8번으로 

   2.안된다 => 4번으로

   ```
   ```

   

4. ```
   $ git pull origin master
   ```

   1. 자동 병합(auto merge)이 일어난다.

       - ```
         $ git status 에 아무런 알림이 없다.
         ```

5. 
