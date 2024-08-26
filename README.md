# automated-DFIR-orchestrator-in-AWS
## Use Case
AWS 클라우드 환경에서 침해사고 발생시 신속하게 대응하기 위해 DFIR(디지털 포렌식 사고대응)을 신속 정확하게 대응하기 위하여 자동화 시스템을 구축하였습니다.

다음과 같은 문제가 있을 떄 자동화 시스템을 도입을 권장합니다 :)
- 침해사고 발생시 사고대응과 포렌식을 수동으로 진행하는 경우
- 진행해야 하는 절차가 많아 시간 소모가 심한 경우 
- 숙련되지 않은 인력이 수행하기 어려운 경우

## Golas
Lambda Function 이 목표를 달성하는데 있어서 중요한 역할을 수행하고 있습니다.

- 신속한 사고 대응으로 사고 확산 방지와 피해 최소화
- 정확성 및 일관성을 가지고 데이터를 처리
- 인적 경제적 비용 절감

## Limitations
다음 자동화 시스템은 법정에서 법적 증거로 간주되지 않을 수 있습니다.( 기술적으로 필요한 부분만 발췌하여 사용 할 것을 권장드립니다 ) 

## Architecture
침해사고 발생시 DFIR 자동화 아키텍쳐 


<img width="964" alt="KakaoTalk_20240826_143510493" src="https://github.com/user-attachments/assets/8a4f63db-2329-49b2-8e37-7070bb597e48">


가장 먼저 침해사고 발생시 GuardDuty 에서 사고를 탐지하여 EventBridge를 통해 미리 정해둔 유형의 침해사고에 대해 Step functions workflow가 작동하도록 설계하였습니다. 


( workflow는 AWS Lambda 로 구현하였습니다. 자세한 내용은 다음 부록을 참고하여 주시기 바랍니다) 
그렇다면 Step functions workflow 안에서 어떠한 순서대로 작동을 하는지 면밀히 살펴보겠습니다. 


1-1. AWS SES 를 사용하여 침해사고에 대한 경고 이메일을 보안 담당자에게 전송합니다.


1-2. NACL에서 공격 ip를 차단해줍니다.  


2-1. 중요한 정보들이 휘발되지 않게 앞 순서에서 휘발성 데이터들을 수집해줍니다. 


2-2. 이후 인스턴스 격리시켜 추가 침해사고를 방지합니다.


2-3. 침해사고 당한 인스턴스의 볼륨을 식별하고 스냅샷을 생성해준 후 무결성 보장을 위해 스냅샷 기반 새로운 볼륨을 생성해주고 새 EC2 인스턴에 볼륨을 연결해줍니다.


2-4. 기본적인 정보가 들어있는 비휘발성 데이터들을 수집하여줍니다.


2-5. 수집한 데이터 중 파일을 생성하거나 삭제한 흔적이 있는 파일들을 시간순서대로 정렬하여 저장합니다. 


2-6. 위에서 분석을 마친 결과를 보안 담당자 메일로 전송하여 줍니다. 
 
## Workflow
스텝 펑션 워크 플로우 사진 넣고 어떻게 단계적으로 이루어 지는지 서술 하는 부분. 

## Pre-requisites 
이모저모 사전에 준비돼야 하는 환경이 무엇인지 이모저모박모김모자.

## Operation
운영과 관련된 말을 쓰기.. 
