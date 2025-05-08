# ユーザーにファイルパスを入力させる
$filePath = Read-Host "ハッシュを確認したいファイルのパスを入力してください"

# ファイルの存在確認
if (-Not (Test-Path $filePath)) {
    Write-Error "指定されたファイルが見つかりません: $filePath"
    exit
}

# ハッシュアルゴリズムの選択肢
$algorithms = @("MD5", "SHA1", "SHA256", "SHA384", "SHA512")

# アルゴリズム入力とバリデーション
do {
    $algorithm = Read-Host "ハッシュアルゴリズムを選択してください（MD5 / SHA1 / SHA256 / SHA384 / SHA512）"
    $algorithm = $algorithm.ToUpper()
    if ($algorithms -notcontains $algorithm) {
        Write-Host "無効なアルゴリズムです。再入力してください。" -ForegroundColor Yellow
    }
} while ($algorithms -notcontains $algorithm)

# certutil を使ってハッシュ値を取得
try {
    Write-Host "`n--- ハッシュ値 ($algorithm) ---" -ForegroundColor Cyan
    certutil -hashfile $filePath $algorithm
} catch {
    Write-Error "ハッシュ値の取得中にエラーが発生しました: $_"
}
pause