import google.auth
from google.oauth2.credentials import Credentials

# 設定 OAuth 2.0 憑證的路徑
creds = Credentials.from_authorized_user_file('path/to/credentials.json')

# 使用 Google API 客戶端程式庫來設定 Google 登入 API
from googleapiclient.discovery import build
service = build('oauth2', 'v2', credentials=creds)

# 執行 Google 登入 API 的操作
user_info = service.userinfo().get().execute()