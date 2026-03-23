# QQ邮箱技能

通过 IMAP/SMTP 协议接入 QQ 邮箱，实现邮件读取和发送。

## 账户信息

| 项目 | 值 |
|------|-----|
| **邮箱地址** | 905358294@qq.com |
| **IMAP 服务器** | imap.qq.com:993 (SSL) |
| **SMTP 服务器** | smtp.qq.com:465 (SSL) |
| **授权码** | yhraiixhimapbcif |

## 使用 Python 操作

### 读取收件箱

```python
import imaplib

imap = imaplib.IMAP4_SSL("imap.qq.com", 993)
imap.login("905358294@qq.com", "yhraiixhimapbcif")
imap.select("INBOX")
status, messages = imap.search(None, "ALL")
email_ids = messages[0].split()
# 处理邮件...
imap.logout()
```

### 发送邮件

```python
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

msg = MIMEMultipart()
msg["From"] = "905358294@qq.com"
msg["To"] = "recipient@example.com"
msg["Subject"] = "邮件主题"
msg.attach(MIMEText("邮件内容", "plain", "utf-8"))

smtp = smtplib.SMTP_SSL("smtp.qq.com", 465)
smtp.login("905358294@qq.com", "yhraiixhimapbcif")
smtp.sendmail("905358294@qq.com", "recipient@example.com", msg.as_string())
smtp.quit()
```

## 可用功能

| 功能 | 说明 |
|------|------|
| **查看收件箱** | 列出最近邮件 |
| **搜索邮件** | 按发件人、主题搜索 |
| **读取邮件** | 查看邮件内容 |
| **发送邮件** | 代发邮件 |
| **定时检查** | 定时汇报新邮件 |

## 注意事项

- 授权码不是QQ密码
- 授权码永久有效，除非修改QQ密码
- 每次发送邮件前需要询问用户确认
