$path='C:\Users\Olaf\Downloads\บ้านทอบ 99_21.xlsx'
if (-not (Test-Path $path)) { Write-Output 'MISSING'; exit 1 }
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false
$wb = $excel.Workbooks.Open($path)
$ws = $wb.Worksheets.Item('Home Account')
$used = $ws.UsedRange
$rows = $used.Rows.Count
$cols = $used.Columns.Count
$headers = 1..$cols | ForEach-Object { $used.Item(1,$_).Text }
Write-Output ("ROWS:{0} COLS:{1}" -f $rows,$cols)
Write-Output ("HEADERS:{0}" -f ($headers -join '|'))
$totals = [ordered]@{income=0.0; expense=0.0; mortgage=0.0; insurance=0.0; built_in=0.0; furniture=0.0; mortgage_extra=0.0; expense_other=0.0}
for ($r=2; $r -le $rows; $r++) {
  $row = [ordered]@{}
  $row.period = $used.Item($r,1).Text
  $row.income_other = $used.Item($r,2).Value2
  $row.income_nong = $used.Item($r,3).Value2
  $row.income_fang = $used.Item($r,4).Value2
  $row.mortgage = $used.Item($r,5).Value2
  $row.insurance = $used.Item($r,6).Value2
  $row.built_in = $used.Item($r,7).Value2
  $row.furniture = $used.Item($r,8).Value2
  $row.mortgage_extra = $used.Item($r,9).Value2
  $row.expense_other = $used.Item($r,10).Value2
  $row.detail = $used.Item($r,11).Text
  $row.home_account = $used.Item($r,12).Value2
  $income = 0.0
  $income += ($row.income_other -as [double])
  $income += ($row.income_nong -as [double])
  $income += ($row.income_fang -as [double])
  $expense = 0.0
  $expense += ($row.mortgage -as [double])
  $expense += ($row.insurance -as [double])
  $expense += ($row.built_in -as [double])
  $expense += ($row.furniture -as [double])
  $expense += ($row.mortgage_extra -as [double])
  $expense += ($row.expense_other -as [double])
  $totals.income += $income
  $totals.expense += $expense
  $totals.mortgage += ($row.mortgage -as [double])
  $totals.insurance += ($row.insurance -as [double])
  $totals.built_in += ($row.built_in -as [double])
  $totals.furniture += ($row.furniture -as [double])
  $totals.mortgage_extra += ($row.mortgage_extra -as [double])
  $totals.expense_other += ($row.expense_other -as [double])
  if ($r -le 22) {
      $vals = 1..$cols | ForEach-Object { $used.Item($r,$_).Text }
      Write-Output (("ROW{0}:{1}" -f ($r-1), ($vals -join '|')))
  }
}
Write-Output ("TOTAL_INCOME:{0:N2}" -f $totals.income)
Write-Output ("TOTAL_EXPENSE:{0:N2}" -f $totals.expense)
Write-Output ("TOTAL_MORTGAGE:{0:N2}" -f $totals.mortgage)
Write-Output ("TOTAL_BUILT_IN:{0:N2}" -f $totals.built_in)
Write-Output ("TOTAL_FURNITURE:{0:N2}" -f $totals.furniture)
Write-Output ("TOTAL_INSURANCE:{0:N2}" -f $totals.insurance)
Write-Output ("TOTAL_EXPENSE_OTHER:{0:N2}" -f $totals.expense_other)
$wb.Close($false)
$excel.Quit()
