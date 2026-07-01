$path = 'C:\Users\Olaf\Downloads\บ้านทอบ 99_21.xlsx'
if (-not (Test-Path $path)) { Write-Error 'File missing'; exit 1 }
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$wb = $excel.Workbooks.Open($path)
$ws = $wb.Worksheets.Item('Home Account')
$used = $ws.UsedRange
$rows = $used.Rows.Count
$cols = $used.Columns.Count
$data = @()
for ($r=2; $r -le [Math]::Min($rows,21); $r++) {
  $income = 0.0
  $income += ($used.Item($r,2).Value2 -as [double])
  $income += ($used.Item($r,3).Value2 -as [double])
  $income += ($used.Item($r,4).Value2 -as [double])
  $expense = 0.0
  $expense += ($used.Item($r,5).Value2 -as [double])
  $expense += ($used.Item($r,6).Value2 -as [double])
  $expense += ($used.Item($r,7).Value2 -as [double])
  $expense += ($used.Item($r,8).Value2 -as [double])
  $expense += ($used.Item($r,9).Value2 -as [double])
  $expense += ($used.Item($r,10).Value2 -as [double])
  $detail = $used.Item($r,11).Text
  $row = [pscustomobject]@{
    period = $used.Item($r,1).Text
    income_other = ($used.Item($r,2).Value2 -as [double])
    income_nong = ($used.Item($r,3).Value2 -as [double])
    income_fang = ($used.Item($r,4).Value2 -as [double])
    mortgage = ($used.Item($r,5).Value2 -as [double])
    insurance = ($used.Item($r,6).Value2 -as [double])
    built_in = ($used.Item($r,7).Value2 -as [double])
    furniture = ($used.Item($r,8).Value2 -as [double])
    mortgage_extra = ($used.Item($r,9).Value2 -as [double])
    expense_other = ($used.Item($r,10).Value2 -as [double])
    detail = $detail
    income_total = $income
    expense_total = $expense
    net = $income - $expense
  }
  $data += $row
}
$wb.Close($false)
$excel.Quit()
$data | ConvertTo-Json -Depth 4 | Set-Content -Path .\home-account-data.json -Encoding UTF8
