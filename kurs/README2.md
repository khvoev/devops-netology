# Курсовая работа по итогам модуля "DevOps и системное администрирование"

Курсовая работа необходима для проверки практических навыков, полученных в ходе прохождения курса "DevOps и системное администрирование".

Мы создадим и настроим виртуальное рабочее место. Позже вы сможете использовать эту систему для выполнения домашних заданий по курсу

## Задание

1. Создайте виртуальную машину Linux.

> Ответ: Настройки Vagrant данной машины

```bash
 Vagrant.configure("2") do |config|
    config.vm.hostname = "vagrant"
 	config.vm.box = "bento/ubuntu-20.04"
	config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.network "forwarded_port", guest: 443, host: 443
	config.vm.provider "virtualbox" do |v|
	  v.memory = 2048
	  v.cpus = 4
	end
 end
```

2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.

> Ответ:

```bash
vagrant@vagrant:~$ sudo apt install ufw
Reading package lists... Done
Building dependency tree
Reading state information... Done
ufw is already the newest version (0.36-6).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
vagrant@vagrant:~$ sudo ufw allow 22
Rules updated
Rules updated (v6)
vagrant@vagrant:~$ sudo ufw allow 443
Rules updated
Rules updated (v6)
vagrant@vagrant:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
vagrant@vagrant:~$ sudo ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22                         ALLOW IN    Anywhere
443                        ALLOW IN    Anywhere
22 (v6)                    ALLOW IN    Anywhere (v6)
443 (v6)                   ALLOW IN    Anywhere (v6)
```

3. Установите hashicorp vault ([инструкция по ссылке](https://learn.hashicorp.com/tutorials/vault/getting-started-install?in=vault/getting-started#install-vault)).

> Ответ:

```bash
vagrant@vagrant:~$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
OK
vagrant@vagrant:~$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Get:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:3 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Get:4 https://apt.releases.hashicorp.com focal InRelease [9,495 B]
Get:5 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]
Get:6 https://apt.releases.hashicorp.com focal/main amd64 Packages [41.2 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-updates/main i386 Packages [581 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [1,445 kB]
Get:9 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [1,109 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/main Translation-en [289 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/restricted i386 Packages [21.8 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [663 kB]
Get:13 http://archive.ubuntu.com/ubuntu focal-updates/restricted Translation-en [94.6 kB]
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [892 kB]
Get:15 http://archive.ubuntu.com/ubuntu focal-updates/universe i386 Packages [662 kB]
Get:16 http://archive.ubuntu.com/ubuntu focal-updates/universe Translation-en [195 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal-updates/multiverse i386 Packages [8,432 B]
Get:18 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [24.8 kB]
Get:19 http://archive.ubuntu.com/ubuntu focal-updates/multiverse Translation-en [6,928 B]
Get:20 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 Packages [42.0 kB]
Get:21 http://archive.ubuntu.com/ubuntu focal-backports/main i386 Packages [34.5 kB]
Get:22 http://archive.ubuntu.com/ubuntu focal-backports/main Translation-en [10.0 kB]
Get:23 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [19.3 kB]
Get:24 http://archive.ubuntu.com/ubuntu focal-backports/universe i386 Packages [10.9 kB]
Get:25 http://archive.ubuntu.com/ubuntu focal-backports/universe Translation-en [13.3 kB]
Get:26 http://security.ubuntu.com/ubuntu focal-security/main i386 Packages [351 kB]
Get:27 http://security.ubuntu.com/ubuntu focal-security/main Translation-en [202 kB]
Get:28 http://security.ubuntu.com/ubuntu focal-security/restricted i386 Packages [20.5 kB]
Get:29 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [609 kB]
Get:30 http://security.ubuntu.com/ubuntu focal-security/restricted Translation-en [86.8 kB]
Get:31 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [675 kB]
Get:32 http://security.ubuntu.com/ubuntu focal-security/universe i386 Packages [532 kB]
Get:33 http://security.ubuntu.com/ubuntu focal-security/universe Translation-en [114 kB]
Get:34 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [21.8 kB]
Get:35 http://security.ubuntu.com/ubuntu focal-security/multiverse i386 Packages [7,176 B]
Get:36 http://security.ubuntu.com/ubuntu focal-security/multiverse Translation-en [4,948 B]
Fetched 9,132 kB in 6s (1,648 kB/s)
Reading package lists... Done
vagrant@vagrant:~$ sudo apt-get update && sudo apt-get install vault
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:3 http://security.ubuntu.com/ubuntu focal-security InRelease
Hit:4 http://archive.ubuntu.com/ubuntu focal-backports InRelease
Hit:5 https://apt.releases.hashicorp.com focal InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  vault
0 upgraded, 1 newly installed, 0 to remove and 109 not upgraded.
Need to get 69.4 MB of archives.
After this operation, 188 MB of additional disk space will be used.
Get:1 https://apt.releases.hashicorp.com focal/main amd64 vault amd64 1.9.2 [69.4 MB]
Fetched 69.4 MB in 7s (9,809 kB/s)
Selecting previously unselected package vault.
(Reading database ... 41552 files and directories currently installed.)
Preparing to unpack .../archives/vault_1.9.2_amd64.deb ...
Unpacking vault (1.9.2) ...
Setting up vault (1.9.2) ...
Generating Vault TLS key and self-signed certificate...
Generating a RSA private key
......................................................................................................................................................................................................................................................................................................................................................++++
.........................................................................................++++
writing new private key to 'tls.key'
-----
Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.
```

4. Cоздайте центр сертификации по инструкции ([ссылка](https://learn.hashicorp.com/tutorials/vault/pki-engine?in=vault/secrets-management)) и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).

> Ответ:
> Запускаем 2 сессию:

```bash
vagrant@vagrant:~$ vault server -dev -dev-root-token-id root
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.17.5
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.9.2
             Version Sha: f4c6d873e2767c0d6853b5d9ffc77b0d297bfbdf

==> Vault server started! Log data will stream in below:

2022-06-01T08:59:35.312Z [INFO]  proxy environment: http_proxy="\"\"" https_proxy="\"\"" no_proxy="\"\""
2022-06-01T08:59:35.312Z [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2022-06-01T08:59:35.319Z [INFO]  core: Initializing VersionTimestamps for core
2022-06-01T08:59:35.323Z [INFO]  core: security barrier not initialized
2022-06-01T08:59:35.324Z [INFO]  core: security barrier initialized: stored=1 shares=1 threshold=1
2022-06-01T08:59:35.325Z [INFO]  core: post-unseal setup starting
2022-06-01T08:59:35.330Z [INFO]  core: loaded wrapping token key
2022-06-01T08:59:35.333Z [INFO]  core: Recorded vault version: vault version=1.9.2 upgrade time="2022-01-13 08:59:35.3306083 +0000 UTC m=+0.680249900"
2022-06-01T08:59:35.334Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-06-01T08:59:35.334Z [INFO]  core: no mounts; adding default mount table
2022-06-01T08:59:35.339Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-06-01T08:59:35.342Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-06-01T08:59:35.347Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-06-01T08:59:35.351Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-06-01T08:59:35.353Z [INFO]  rollback: starting rollback manager
2022-06-01T08:59:35.353Z [INFO]  core: restoring leases
2022-06-01T08:59:35.355Z [INFO]  identity: entities restored
2022-06-01T08:59:35.355Z [INFO]  identity: groups restored
2022-06-01T08:59:35.356Z [INFO]  core: post-unseal setup complete
2022-06-01T08:59:35.357Z [INFO]  core: root token generated
2022-06-01T08:59:35.357Z [INFO]  core: pre-seal teardown starting
2022-06-01T08:59:35.357Z [INFO]  expiration: lease restore complete
2022-06-01T08:59:35.369Z [INFO]  rollback: stopping rollback manager
2022-06-01T08:59:35.369Z [INFO]  core: pre-seal teardown complete
2022-06-01T08:59:35.382Z [INFO]  core.cluster-listener.tcp: starting listener: listener_address=127.0.0.1:8201
2022-06-01T08:59:35.382Z [INFO]  core.cluster-listener: serving cluster requests: cluster_listen_address=127.0.0.1:8201
2022-06-01T08:59:35.384Z [INFO]  core: post-unseal setup starting
2022-06-01T08:59:35.385Z [INFO]  core: loaded wrapping token key
2022-06-01T08:59:35.385Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-06-01T08:59:35.386Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-06-01T08:59:35.387Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-06-01T08:59:35.387Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-06-01T08:59:35.390Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-06-01T08:59:35.391Z [INFO]  rollback: starting rollback manager
2022-06-01T08:59:35.391Z [INFO]  core: restoring leases
2022-06-01T08:59:35.391Z [INFO]  expiration: lease restore complete
2022-06-01T08:59:35.391Z [INFO]  identity: entities restored
2022-06-01T08:59:35.391Z [INFO]  identity: groups restored
2022-06-01T08:59:35.392Z [INFO]  core: post-unseal setup complete
2022-06-01T08:59:35.392Z [INFO]  core: vault is unsealed
2022-06-01T08:59:35.395Z [INFO]  expiration: revoked lease: lease_id=auth/token/root/h6838d322370be82d3447671c91cbad2bf6fa2ba66ac7aaf770a518dd81b92157
2022-06-01T08:59:35.401Z [INFO]  core: successful mount: namespace="\"\"" path=secret/ type=kv
2022-06-01T08:59:35.402Z [INFO]  secrets.kv.kv_69b5cd3c: collecting keys to upgrade
2022-06-01T08:59:35.402Z [INFO]  secrets.kv.kv_69b5cd3c: done collecting keys: num_keys=1
2022-06-01T08:59:35.402Z [INFO]  secrets.kv.kv_69b5cd3c: upgrading keys finished
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: yifICMNJ6qZlbNDTVa1CaAxbhiqXAVh1J5ev2f5pitA=
Root Token: root

Development mode should NOT be used in production installations!

2022-06-01T09:06:16.630Z [INFO]  core: successful mount: namespace="\"\"" path=pki/ type=pki
2022-06-01T09:06:24.266Z [INFO]  core: mount tuning of leases successful: path=pki/
```

Устанавливаем JSON

```bash
vagrant@vagrant:~$ sudo apt-get install jq
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  libjq1 libonig5
The following NEW packages will be installed:
  jq libjq1 libonig5
0 upgraded, 3 newly installed, 0 to remove and 109 not upgraded.
Need to get 313 kB of archives.
After this operation, 1,062 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 libonig5 amd64 6.9.4-1 [142 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 libjq1 amd64 1.6-1ubuntu0.20.04.1 [121 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 jq amd64 1.6-1ubuntu0.20.04.1 [50.2 kB]
Fetched 313 kB in 1s (430 kB/s)
Selecting previously unselected package libonig5:amd64.
(Reading database ... 41558 files and directories currently installed.)
Preparing to unpack .../libonig5_6.9.4-1_amd64.deb ...
Unpacking libonig5:amd64 (6.9.4-1) ...
Selecting previously unselected package libjq1:amd64.
Preparing to unpack .../libjq1_1.6-1ubuntu0.20.04.1_amd64.deb ...
Unpacking libjq1:amd64 (1.6-1ubuntu0.20.04.1) ...
Selecting previously unselected package jq.
Preparing to unpack .../jq_1.6-1ubuntu0.20.04.1_amd64.deb ...
Unpacking jq (1.6-1ubuntu0.20.04.1) ...
Setting up libonig5:amd64 (6.9.4-1) ...
Setting up libjq1:amd64 (1.6-1ubuntu0.20.04.1) ...
Setting up jq (1.6-1ubuntu0.20.04.1) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
```

Экспортируем переменную среды для vault CLI для адресации к серверу Vault и переменную среды для CLI хранилища для аутентификации на сервере Vault.

```bash
vagrant@vagrant:~$ export VAULT_ADDR=http://127.0.0.1:8200
vagrant@vagrant:~$ export VAULT_TOKEN=root
```

Настроим механизм секретов pki с временем жизни раз в месяц (730 часов)

```bash
vagrant@vagrant:~$ vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/
vagrant@vagrant:~$ vault secrets tune -max-lease-ttl=730h pki
Success! Tuned the secrets engine at: pki/
```

Сгенерируем корневой сертификат и сохраним сертификат в CA_cert.crt:

```bash
vagrant@vagrant:~$  vault write -field=certificate pki/root/generate/internal \
 > common_name="example.com" \
>  ttl=730h > CA_cert.crt


vagrant@vagrant:~$ cat CA_cert.crt
-----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUC3xVnp4HOCJq9CQrwKPbm/84kWgwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMTEzMDk1NzA1WhcNMjIw
MjEyMTk1NzM0WjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAOTI3BjsSTOQwisC6sZFjSHq/0ZufURHcGCdK3dW
PEmIkFXa/3PE32OmYF4kluOhQREn2dtzvo0xQYIdCgoVhnf1oLEz9E4r+e3urQAr
+w4x5c1I+9fXbq2/ELWzQPusTbeJnnkAN9j6iL+WfiCziHqbVc3mr8cbOscz9DJa
SXeds4rLBW+1G324mzqM/68IiMQq9YXUPFB448nQw9mRFb3ct75vdO2OIFi9hLm6
jLVsUcMq9G+VKQvE775v87LH5cZy4DJvxeIUn+mmJpVOz8g8wlmUOBDPXqsZxPzf
IoD1/0vB9xTEBp3n3NIpGU6JLuJnsAFAFQWsyZ7mJwf+CXkCAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFCtH6/hrpuQE
J6iKon/d+Yg/RK7HMB8GA1UdIwQYMBaAFCtH6/hrpuQEJ6iKon/d+Yg/RK7HMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQDdJvNuAGZd
k45gH44mAuPkV3UJ8VqOZYqCfsKK5YK09FYKb5BcMcdPE+6xR497ABsgHnB5h+Xd
sLbypKb8xFU4s6a9+FV6JfTM0zfS5gQp7e94SEXbv4jo9Bcvg0PQIZDfmsChEYje
0RNotNnhIg0WjeL9WEq/6KhXqX2vh45hnfyvizPw3Nct6pnovd3eibC437n9uGwC
S/vAf3XZH6zxar/woOQXWMgp7yk6wygP4IV5HQUF7ddSdkFmJiMrLoTyoo9WdlcH
LLz4n1RSr1s+21nnC//6QEM93bRV1zdJ9vr2bvsAy0k9Is5hKrPYBIIDC2Ld1M2Z
kfVqa+u0nIQZ
-----END CERTIFICATE-----v
```

Конфигурируем CA и CRL ссылки(URLs):

```bash
vagrant@vagrant:~$ vault write pki/config/urls \
> issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
> crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls
```

Создадим роль:

```bash
vagrant@vagrant:~$ vault write pki/roles/example-dot-com \
> allowed_domains="example.com" \
> allow_subdomains=true \
> allow_bare_domains=true \
> max_ttl="730h"
Success! Data written to: pki/roles/example-dot-com
```

Выпускаем сертификаты для сервера:

```bash
vagrant@vagrant:~$ vault write pki/issue/example-dot-com common_name="test.example.com" ttl="24h"
Key                 Value
---                 -----
certificate         -----BEGIN CERTIFICATE-----
MIIDvzCCAqegAwIBAgIUDeGPgD/n7YqEpVTxOHTjsDzk5+EwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMTEzMDk1ODE3WhcNMjIw
MTE0MDk1ODQ3WjAbMRkwFwYDVQQDExB0ZXN0LmV4YW1wbGUuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4zBzWVMVXRJDnPjaQ4/QRK1uogOQcsjX
69ev5oF433Z3ZmqndHcelHO5RD+KM77iK3+nTDvRsKIxs0j0DKAUE3nLq98UMxNr
JrenDN1h8f5M528yyca3TmcgMa4EZ6GATg32ywRsfILYGCNpk8q9SbvU8ytFY+Lp
GCMeThpkuwRo6o9aANms1wnShAWm3JYxPbB/GwrkcSCq7rXTACqL5PNLashLfTyS
qUq7WZAuVTwgX8NOBTKEgzptLHfL/WFk4IVtHila7cI4LCbN0OuvtokfDffYhrBd
Y7m+MaEB4ZMLeIJWGt1zDZ9d7uBsPpmfpIFQXju1Jf9nrPJhxXOlaQIDAQABo4H/
MIH8MA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUH
AwIwHQYDVR0OBBYEFEgD5cIeFGSDAsIN87nEmnL4ipLSMB8GA1UdIwQYMBaAFCtH
6/hrpuQEJ6iKon/d+Yg/RK7HMDsGCCsGAQUFBwEBBC8wLTArBggrBgEFBQcwAoYf
aHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jYTAbBgNVHREEFDASghB0ZXN0
LmV4YW1wbGUuY29tMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6
ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA1zVxMljIsFdBvMj1o
OyIAkCB3qlY1VA2F0iYl/EL9rCYLULqH58Xj2rICyccYP1oXp/uqIiO/34nAxVmH
X+QpX534M4IrPU/Bt1jQe6auKucmuZb2dyWwSxt7sX3Z0sqLDghv9OXkWSyzGEnL
B6H0C8ANMexLHdwWicnkE9RyvvUpd7mfLCl7hr8xfRtiLws4kA2G48WZllmAW+PH
O8qZLgh+nPhM2JWFlkiqyacMv66eR7ORDvZ5Byyu7kReqNRAq3grcbkxnAOKsf09
yNII3h74DCFHP/WIJB14FADn/cOHcs5nE8blOl0jrzDQhO2KxeQsU3ghkVSIuJbi
u75g
-----END CERTIFICATE-----
expiration          1642154327
issuing_ca          -----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUC3xVnp4HOCJq9CQrwKPbm/84kWgwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMTEzMDk1NzA1WhcNMjIw
MjEyMTk1NzM0WjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAOTI3BjsSTOQwisC6sZFjSHq/0ZufURHcGCdK3dW
PEmIkFXa/3PE32OmYF4kluOhQREn2dtzvo0xQYIdCgoVhnf1oLEz9E4r+e3urQAr
+w4x5c1I+9fXbq2/ELWzQPusTbeJnnkAN9j6iL+WfiCziHqbVc3mr8cbOscz9DJa
SXeds4rLBW+1G324mzqM/68IiMQq9YXUPFB448nQw9mRFb3ct75vdO2OIFi9hLm6
jLVsUcMq9G+VKQvE775v87LH5cZy4DJvxeIUn+mmJpVOz8g8wlmUOBDPXqsZxPzf
IoD1/0vB9xTEBp3n3NIpGU6JLuJnsAFAFQWsyZ7mJwf+CXkCAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFCtH6/hrpuQE
J6iKon/d+Yg/RK7HMB8GA1UdIwQYMBaAFCtH6/hrpuQEJ6iKon/d+Yg/RK7HMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQDdJvNuAGZd
k45gH44mAuPkV3UJ8VqOZYqCfsKK5YK09FYKb5BcMcdPE+6xR497ABsgHnB5h+Xd
sLbypKb8xFU4s6a9+FV6JfTM0zfS5gQp7e94SEXbv4jo9Bcvg0PQIZDfmsChEYje
0RNotNnhIg0WjeL9WEq/6KhXqX2vh45hnfyvizPw3Nct6pnovd3eibC437n9uGwC
S/vAf3XZH6zxar/woOQXWMgp7yk6wygP4IV5HQUF7ddSdkFmJiMrLoTyoo9WdlcH
LLz4n1RSr1s+21nnC//6QEM93bRV1zdJ9vr2bvsAy0k9Is5hKrPYBIIDC2Ld1M2Z
kfVqa+u0nIQZ
-----END CERTIFICATE-----
private_key         -----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA4zBzWVMVXRJDnPjaQ4/QRK1uogOQcsjX69ev5oF433Z3Zmqn
dHcelHO5RD+KM77iK3+nTDvRsKIxs0j0DKAUE3nLq98UMxNrJrenDN1h8f5M528y
yca3TmcgMa4EZ6GATg32ywRsfILYGCNpk8q9SbvU8ytFY+LpGCMeThpkuwRo6o9a
ANms1wnShAWm3JYxPbB/GwrkcSCq7rXTACqL5PNLashLfTySqUq7WZAuVTwgX8NO
BTKEgzptLHfL/WFk4IVtHila7cI4LCbN0OuvtokfDffYhrBdY7m+MaEB4ZMLeIJW
Gt1zDZ9d7uBsPpmfpIFQXju1Jf9nrPJhxXOlaQIDAQABAoIBAQCRq046lugazgwm
SPWB3mNWtbE7Fnf28UppANnbPWboOUhjlb0bEwm7e9vto6QUe67+3xHA8pYH4Gdn
oj5BHh7hQfXSlO2Ztji9EYJ94DDd/gUHW6g/8jc0gTEGSaKvY8ElyxRTpdl9mFPA
Xmxig9sMvO/UnwkV+7cjb9kNkSTHN95Ku6ACkXWWNcM5aaZ02j5gKUwbmtP/lja+
Eu1sBuelsirCT7ycHJIwlHJEImRbNoa4XAuTFB6uvJs9oK3zfI8S1AnPf8BrQZuN
+4xpUeR/EutHt9to1qf6YSL+EkFdSM4jxfI2ltgQ4KVk1UuTRJqL5szsyeUmrlxh
A1cUSTKlAoGBAOvt+NTVk9f/gZPl227WGegnjZCBTp8RkeOspncrIC6x34nBjZcr
3sLCWeDwMavWgRhB47umTyWeBkEFT8mG9pa7tihF5ROSjqtR8jyRjTWVhSPW0fNL
ZH2BfuQFrwU50lsvpaWzEPjY9lOziSUta4akMy3uPI9eiTmYCvEUFjhXAoGBAPaE
Ijc5bywNvQfib04bQW77yJuIufbnP3GeTDwnL4Qnyhru4NniGojBruZo4LcV0uIP
ORjP+Sn2DZQdYoil7uYaHf6S/S1hDLnPJCu/Dz4+MENnbYVDX82gDLnZ788yuguo
auYyPe8yHZNrQHdIi3lMIfLrv5s7rFVIWrXDJXg/AoGBAMxtLJiuXyZfnBVcq6AE
H/qKmx1FDazC+pg+Nxc25PHQ6hJhBaChQKmc4WgId+GfQciU/xDPb/D2VhDs20+R
hATjrViEB5PH/5rurGhS7foqDm0ZbF3VS8N7+0j0q8xpZ53fUTacS+5zgCzSedke
2/aUPExmC09m6Jxg48o0T3SNAoGAaAzRnFmjsQaDeSZ8MI2UitG/lNabF7n3r29P
Yjxv8+oPhlq5kX28EWke96Xg46ZUgpJGWVC/LJTsmk3k3ySat4jijCdisZq7Elp6
O/TC7FS3blvjgFI1x8b8WB3C+MPCf1Uw+cTPG30durGUXkTCigo2ciBLmawQS1bk
4r9hu2UCgYEAmOIdu8yUKNoz5JBEnh2PVvI0ezZ9YJnSvQWrUv3Kza7/LDLwMOQR
A/+azPc7EAerXYeH+U9sCgsU9otaBKVhNDnmxQkXuddb+DoQvuH2TdAV0OczTq2/
n/EMl5k3aK09Zs+Ly9TtzkrPW23RGKsDrUHalLO/XxtptkTSuet56DA=
-----END RSA PRIVATE KEY-----
private_key_type    rsa
serial_number       0d:e1:8f:80:3f:e7:ed:8a:84:a5:54:f1:38:74:e3:b0:3c:e4:e7:e1
```

5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.

> Ответ:
> ![](ol.png)
![](cert.jpg)
6. Установите nginx.

> Ответ:

```bash
vagrant@vagrant:~$ sudo apt install nginx
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core libfontconfig1 libgd3 libjbig0 libjpeg-turbo8 libjpeg8 libnginx-mod-http-image-filter libnginx-mod-http-xslt-filter
  libnginx-mod-mail libnginx-mod-stream libtiff5 libwebp6 libx11-6 libx11-data libxcb1 libxpm4 nginx-common nginx-core
Suggested packages:
  libgd-tools fcgiwrap nginx-doc ssl-cert
The following NEW packages will be installed:
Preparing to unpack .../19-nginx_1.18.0-0ubuntu1.2_all.deb ...
Unpacking nginx (1.18.0-0ubuntu1.2) ...
Setting up libxcb1:amd64 (1.14-2) ...
Setting up nginx-common (1.18.0-0ubuntu1.2) ...
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /lib/systemd/system/nginx.service.
Setting up libjbig0:amd64 (2.1-3.1build1) ...
Setting up libnginx-mod-http-xslt-filter (1.18.0-0ubuntu1.2) ...
Setting up libx11-data (2:1.6.9-2ubuntu1.2) ...
Setting up libwebp6:amd64 (0.6.1-2ubuntu0.20.04.1) ...
Setting up fonts-dejavu-core (2.37-1) ...
Setting up libjpeg-turbo8:amd64 (2.0.3-0ubuntu1.20.04.1) ...
Setting up libx11-6:amd64 (2:1.6.9-2ubuntu1.2) ...
Setting up libjpeg8:amd64 (8c-2ubuntu8) ...
Setting up libnginx-mod-mail (1.18.0-0ubuntu1.2) ...
Setting up libxpm4:amd64 (1:3.5.12-1) ...
Setting up fontconfig-config (2.13.1-2ubuntu3) ...
Setting up libnginx-mod-stream (1.18.0-0ubuntu1.2) ...
Setting up libtiff5:amd64 (4.1.0+git191117-2ubuntu0.20.04.2) ...
Setting up libfontconfig1:amd64 (2.13.1-2ubuntu3) ...
Setting up libgd3:amd64 (2.2.5-5.2ubuntu2.1) ...
Setting up libnginx-mod-http-image-filter (1.18.0-0ubuntu1.2) ...
Setting up nginx-core (1.18.0-0ubuntu1.2) ...
Setting up nginx (1.18.0-0ubuntu1.2) ...
Processing triggers for ufw (0.36-6) ...
Processing triggers for systemd (245.4-4ubuntu3.11) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
vagrant@vagrant:~$ sudo ufw allow 'Nginx HTTP'
w allow 'Nginx HTTPS'Rule added
Rule added (v6)
vagrant@vagrant:~$ sudo ufw allow 'Nginx HTTPS'
Rule added
Rule added (v6)
vagrant@vagrant:~$ systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-01-13 10:26:05 UTC; 1min 40s ago
       Docs: man:nginx(8)
   Main PID: 14853 (nginx)
      Tasks: 5 (limit: 2278)
     Memory: 6.0M
     CGroup: /system.slice/nginx.service
             ├─14853 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             ├─14854 nginx: worker process
             ├─14855 nginx: worker process
             ├─14856 nginx: worker process
             └─14857 nginx: worker process

Jun 01 10:26:05 vagrant systemd[1]: Starting A high performance web server and a reverse proxy server...
Jun 01 10:26:05 vagrant systemd[1]: Started A high performance web server and a reverse proxy server.
```

7. По инструкции ([ссылка](https://nginx.org/en/docs/http/configuring_https_servers.html)) настройте nginx на https, используя ранее подготовленный сертификат:

- можно использовать стандартную стартовую страницу nginx для демонстрации работы сервера;
- можно использовать и другой html файл, сделанный вами;

> Ответ:

Полученные сертификаты и закрытый ключ сохранены в файл /etc/ssl/test.example.com.cert.

```bash
root@vagrant:/etc/ssl# cat test.example.com.cert
-----BEGIN CERTIFICATE-----
MIIDvzCCAqegAwIBAgIUDeGPgD/n7YqEpVTxOHTjsDzk5+EwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMTEzMDk1ODE3WhcNMjIw
MTE0MDk1ODQ3WjAbMRkwFwYDVQQDExB0ZXN0LmV4YW1wbGUuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4zBzWVMVXRJDnPjaQ4/QRK1uogOQcsjX
69ev5oF433Z3ZmqndHcelHO5RD+KM77iK3+nTDvRsKIxs0j0DKAUE3nLq98UMxNr
JrenDN1h8f5M528yyca3TmcgMa4EZ6GATg32ywRsfILYGCNpk8q9SbvU8ytFY+Lp
GCMeThpkuwRo6o9aANms1wnShAWm3JYxPbB/GwrkcSCq7rXTACqL5PNLashLfTyS
qUq7WZAuVTwgX8NOBTKEgzptLHfL/WFk4IVtHila7cI4LCbN0OuvtokfDffYhrBd
Y7m+MaEB4ZMLeIJWGt1zDZ9d7uBsPpmfpIFQXju1Jf9nrPJhxXOlaQIDAQABo4H/
MIH8MA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUH
AwIwHQYDVR0OBBYEFEgD5cIeFGSDAsIN87nEmnL4ipLSMB8GA1UdIwQYMBaAFCtH
6/hrpuQEJ6iKon/d+Yg/RK7HMDsGCCsGAQUFBwEBBC8wLTArBggrBgEFBQcwAoYf
aHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jYTAbBgNVHREEFDASghB0ZXN0
LmV4YW1wbGUuY29tMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6
ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA1zVxMljIsFdBvMj1o
OyIAkCB3qlY1VA2F0iYl/EL9rCYLULqH58Xj2rICyccYP1oXp/uqIiO/34nAxVmH
X+QpX534M4IrPU/Bt1jQe6auKucmuZb2dyWwSxt7sX3Z0sqLDghv9OXkWSyzGEnL
B6H0C8ANMexLHdwWicnkE9RyvvUpd7mfLCl7hr8xfRtiLws4kA2G48WZllmAW+PH
O8qZLgh+nPhM2JWFlkiqyacMv66eR7ORDvZ5Byyu7kReqNRAq3grcbkxnAOKsf09
yNII3h74DCFHP/WIJB14FADn/cOHcs5nE8blOl0jrzDQhO2KxeQsU3ghkVSIuJbi
u75g
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUC3xVnp4HOCJq9CQrwKPbm/84kWgwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMTEzMDk1NzA1WhcNMjIw
MjEyMTk1NzM0WjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAOTI3BjsSTOQwisC6sZFjSHq/0ZufURHcGCdK3dW
PEmIkFXa/3PE32OmYF4kluOhQREn2dtzvo0xQYIdCgoVhnf1oLEz9E4r+e3urQAr
+w4x5c1I+9fXbq2/ELWzQPusTbeJnnkAN9j6iL+WfiCziHqbVc3mr8cbOscz9DJa
SXeds4rLBW+1G324mzqM/68IiMQq9YXUPFB448nQw9mRFb3ct75vdO2OIFi9hLm6
jLVsUcMq9G+VKQvE775v87LH5cZy4DJvxeIUn+mmJpVOz8g8wlmUOBDPXqsZxPzf
IoD1/0vB9xTEBp3n3NIpGU6JLuJnsAFAFQWsyZ7mJwf+CXkCAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFCtH6/hrpuQE
J6iKon/d+Yg/RK7HMB8GA1UdIwQYMBaAFCtH6/hrpuQEJ6iKon/d+Yg/RK7HMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQDdJvNuAGZd
k45gH44mAuPkV3UJ8VqOZYqCfsKK5YK09FYKb5BcMcdPE+6xR497ABsgHnB5h+Xd
sLbypKb8xFU4s6a9+FV6JfTM0zfS5gQp7e94SEXbv4jo9Bcvg0PQIZDfmsChEYje
0RNotNnhIg0WjeL9WEq/6KhXqX2vh45hnfyvizPw3Nct6pnovd3eibC437n9uGwC
S/vAf3XZH6zxar/woOQXWMgp7yk6wygP4IV5HQUF7ddSdkFmJiMrLoTyoo9WdlcH
LLz4n1RSr1s+21nnC//6QEM93bRV1zdJ9vr2bvsAy0k9Is5hKrPYBIIDC2Ld1M2Z
kfVqa+u0nIQZ
-----END CERTIFICATE-----
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA4zBzWVMVXRJDnPjaQ4/QRK1uogOQcsjX69ev5oF433Z3Zmqn
dHcelHO5RD+KM77iK3+nTDvRsKIxs0j0DKAUE3nLq98UMxNrJrenDN1h8f5M528y
yca3TmcgMa4EZ6GATg32ywRsfILYGCNpk8q9SbvU8ytFY+LpGCMeThpkuwRo6o9a
ANms1wnShAWm3JYxPbB/GwrkcSCq7rXTACqL5PNLashLfTySqUq7WZAuVTwgX8NO
BTKEgzptLHfL/WFk4IVtHila7cI4LCbN0OuvtokfDffYhrBdY7m+MaEB4ZMLeIJW
Gt1zDZ9d7uBsPpmfpIFQXju1Jf9nrPJhxXOlaQIDAQABAoIBAQCRq046lugazgwm
SPWB3mNWtbE7Fnf28UppANnbPWboOUhjlb0bEwm7e9vto6QUe67+3xHA8pYH4Gdn
oj5BHh7hQfXSlO2Ztji9EYJ94DDd/gUHW6g/8jc0gTEGSaKvY8ElyxRTpdl9mFPA
Xmxig9sMvO/UnwkV+7cjb9kNkSTHN95Ku6ACkXWWNcM5aaZ02j5gKUwbmtP/lja+
Eu1sBuelsirCT7ycHJIwlHJEImRbNoa4XAuTFB6uvJs9oK3zfI8S1AnPf8BrQZuN
+4xpUeR/EutHt9to1qf6YSL+EkFdSM4jxfI2ltgQ4KVk1UuTRJqL5szsyeUmrlxh
A1cUSTKlAoGBAOvt+NTVk9f/gZPl227WGegnjZCBTp8RkeOspncrIC6x34nBjZcr
3sLCWeDwMavWgRhB47umTyWeBkEFT8mG9pa7tihF5ROSjqtR8jyRjTWVhSPW0fNL
ZH2BfuQFrwU50lsvpaWzEPjY9lOziSUta4akMy3uPI9eiTmYCvEUFjhXAoGBAPaE
Ijc5bywNvQfib04bQW77yJuIufbnP3GeTDwnL4Qnyhru4NniGojBruZo4LcV0uIP
ORjP+Sn2DZQdYoil7uYaHf6S/S1hDLnPJCu/Dz4+MENnbYVDX82gDLnZ788yuguo
auYyPe8yHZNrQHdIi3lMIfLrv5s7rFVIWrXDJXg/AoGBAMxtLJiuXyZfnBVcq6AE
H/qKmx1FDazC+pg+Nxc25PHQ6hJhBaChQKmc4WgId+GfQciU/xDPb/D2VhDs20+R
hATjrViEB5PH/5rurGhS7foqDm0ZbF3VS8N7+0j0q8xpZ53fUTacS+5zgCzSedke
2/aUPExmC09m6Jxg48o0T3SNAoGAaAzRnFmjsQaDeSZ8MI2UitG/lNabF7n3r29P
Yjxv8+oPhlq5kX28EWke96Xg46ZUgpJGWVC/LJTsmk3k3ySat4jijCdisZq7Elp6
O/TC7FS3blvjgFI1x8b8WB3C+MPCf1Uw+cTPG30durGUXkTCigo2ciBLmawQS1bk
4r9hu2UCgYEAmOIdu8yUKNoz5JBEnh2PVvI0ezZ9YJnSvQWrUv3Kza7/LDLwMOQR
A/+azPc7EAerXYeH+U9sCgsU9otaBKVhNDnmxQkXuddb+DoQvuH2TdAV0OczTq2/
n/EMl5k3aK09Zs+Ly9TtzkrPW23RGKsDrUHalLO/XxtptkTSuet56DA=
-----END RSA PRIVATE KEY-----
```

В файл конфигурации дефолтного сайта сервера nginx (раздел server) добавлены строки:

```bash
root@vagrant:/etc/ssl# cat /etc/nginx/sites-available/default
##
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        listen 443 ssl default_server;
        ssl_certificate     /etc/ssl/test.example.com.cert;
        ssl_certificate_key /etc/ssl/test.example.com.cert;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }
}
```

8. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.

> Ответ:
> ![](cert3.png)

9. Создайте скрипт, который будет генерировать новый сертификат в vault:

- генерируем новый сертификат так, чтобы не переписывать конфиг nginx;
- перезапускаем nginx для применения нового сертификата.

> Ответ:
> Создаем файл cert_refresh.sh

```bash
vi /etc/ssl/cert_refresh.sh
chmod +x /etc/ssl/cert_refresh.sh
```

Сам код файла

```code
#!/bin/bash
#!/usr/bin/env bash

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

REQUEST=$( vault write -format=json pki/issue/example-dot-com common_name="test.example.com" ttl="720h")
SITE_CRT=$(echo $REQUEST | jq .data.certificate | tr -d \")
ISS_CA=$(echo $REQUEST | jq .data.issuing_ca | tr -d \")
SITE_KEY=$(echo $REQUEST | jq .data.private_key | tr -d \")
CERT_FILE=${SITE_CRT}\\n${ISS_CA}\\n${SITE_KEY}
echo -e $CERT_FILE > /etc/ssl/test.example.com.cert
systemctl restart nginx
```

```code
root@vagrant:~# cd /etc/ssl
root@vagrant:/etc/ssl# ./cert_refresh.sh
Success! Data written to: pki/roles/example-dot-com
```

10. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

> Ответ:

```bash
root@vagrant:/etc/ssl# crontab -e
crontab: installing new crontab

добавили строку
30 13 13 * * /etc/ssl/cert_refresh.sh
```

Проверка работы - до запуска скрипта:

```bash
root@vagrant:/etc/ssl# ls -l
total 52
-rwxr-xr-x 1 root root   671 Jun 01 13:21 cert_refresh.sh
drwxr-xr-x 2 root root 16384 Jul 28 17:55 certs
-rw-r--r-- 1 root root 10909 Apr 20  2020 openssl.cnf
drwx------ 2 root root  4096 Apr 20  2020 private
-rw-r--r-- 1 root root  4210 Jun 01 13:22 test.example.com.cert
-rw-r--r-- 1 root root  4641 Jun 01 13:12 testtest.crt
-rw-r--r-- 1 root root     0 Jun 01 13:10 website.crt
```

Проверка работы - после запуска скрипта из cron:

```bash
root@vagrant:/etc/ssl# ls -l
total 52
-rwxr-xr-x 1 root root   671 Jun 01 13:21 cert_refresh.sh
drwxr-xr-x 2 root root 16384 Jul 28 17:55 certs
-rw-r--r-- 1 root root 10909 Apr 20  2020 openssl.cnf
drwx------ 2 root root  4096 Apr 20  2020 private
-rw-r--r-- 1 root root  4206 Jun 13 13:30 test.example.com.cert
-rw-r--r-- 1 root root  4641 Jun 13 13:12 testtest.crt
-rw-r--r-- 1 root root     0 Jun 13 13:10 website.crt
```