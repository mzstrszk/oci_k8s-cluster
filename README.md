# Oracle Cloud Kubernetes Cluster Automation

## 概要

このプロジェクトは、Oracle Cloud Infrastructure (OCI)上にKubernetesクラスターを自動的に構築するためのツールセットです。TerraformとAnsibleを使用して、インフラストラクチャのプロビジョニングからKubernetesクラスターの設定までの自動化を提供します。
なお、内容は以下の記事をもとに自動化したものになります。
- [Oracle Cloud（OCI）でのkubernetesクラスター構築](https://qiita.com/mozo/items/9ed5ecaa10dcf28e79e5)

## 技術スタック

- **Terraform**: インフラストラクチャのプロビジョニングに使用
- **Ansible**: サーバー設定とKubernetesクラスターのセットアップに使用
- **Oracle Cloud Infrastructure (OCI)**: クラウドプロバイダー
- **Kubernetes**: コンテナオーケストレーションプラットフォーム

## 前提条件

- 実行環境： macOS Sonoma 14.5
- Oracle Cloudアカウント取得済み
- Terraform (バージョン 1.9.3)
- Ansible (バージョン [core 2.17.2])

## プロジェクト構造

```
.
├── terraform/
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── ansible_inventory.tftpl（ansibleのinventory.iniのテンプレート）
│   ├── outputs.tf
│   └── ...
├── ansible/
│   ├── site.yaml
│   ├── k8s_master.yaml
│   ├── k8s_workers.yaml
│   ├── roles/
│   │   ├── common/
│   │   ├── k8s_master/
│   │   └── k8s_worker/
│   ├── inventory.ini（terraformの実行で自動作成）
│   └── ...
└── README.md
```

## 使い方

1. リポジトリをクローンします。

   ```
   git clone https://github.com/mzstrszk/oci_k8s-cluster.git
   cd oci_k8s-cluster
   ```

2. Terraformの変数を設定するため、`terraform/terraform.tfvars`ファイルを作成し、必要な変数を定義します。
   - OCIへのTerraform接続は以下を参考にしてください。
     - [TerraformでOCIの構築を自動化する](https://oracle-japan.github.io/ocitutorials/intermediates/terraform/)
   - SSH秘密鍵、公開鍵を準備してください。

3. Terraformを実行し、OCI上にインフラストラクチャをプロビジョニングします。この処理の最後に、自動的にAnsibleのinventory.iniファイルを作成し、プロビジョニングしたインスタンス等の情報を書き込みます。

   ```
   cd terraform

   # 以下を順に実行する。
   terraform init
   terraform plan
   terraform apply
   ```

4. Ansibleを実行し、ociの3台のコンピュートインスタンスにKubernetesクラスターを構築します。
   
   ```
   cd ../ansible

   # inventory.iniが生成されていることを確認し、以下を実行する。
   ansible-playbook -i inventory.ini site.yaml
   ```
5. 構築が完了したら、SSHでkubernetesのマスターノードにアクセスし、クラスターの操作ができるようになります。

   ```
   ssh <OCIインスタンスユーザー>@<マスターノードIPアドレス> -i <SSH秘密鍵のパス>

   # SSHログイン後、以下のコマンドで1つのマスターノードと2つのワーカーノードが表示されます。
   kubect get nodes
   ```

6. 環境を削除する。
   削除する場合は、Terraformでdestroyを実行する。

   ```
   cd ../terraform

   # 以下を実行することで、環境を全て削除する。
   terraform destroy
   ```


## 注意事項

- このプロジェクトは、基本的な Kubernetes クラスターの構築を目的としています
-  本番環境での利用には、セキュリティや高可用性などの考慮が必要です。
- OCI の料金体系をよく理解し、不要な課金を避けるように注意してください。

## ライセンス

[MIT](https://choosealicense.com/licenses/mit/)