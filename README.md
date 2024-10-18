アプリケーション名
task_management

アプリケーション概要
個人のタスク管理用アプリです


## Tasks テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
|title	             |string	|タスクのタイトル
|description	       |text	  |タスクの詳細
|deadline	           |datetime|	タスクの期限
|completed	         |boolean |	タスクの完了状態 (true/false)
|priority	           |integer |優先度（0=低, 1=中, 2=高）
|created_at	         |datetime|レコード作成日時（自動生成）
|updated_at	         |datetime|レコード更新日時（自動生成）

