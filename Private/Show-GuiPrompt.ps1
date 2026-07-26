function Show-GuiPrompt {
    param([string]$Prepopulate)

    Add-Type -AssemblyName System.Windows.Forms

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "New PowerShell Module"
    $form.Width = 350
    $form.Height = 150
    $form.StartPosition = "CenterScreen"

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Module Name:"
    $label.Left = 10
    $label.Top = 20
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Left = 10
    $textBox.Top = 45
    $textBox.Width = 310
    if ($Prepopulate) { $textBox.Text = $Prepopulate }
    $form.Controls.Add($textBox)

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.Left = 230
    $okButton.Top = 75
    $okButton.Add_Click({ $form.Close() })
    $form.Controls.Add($okButton)

    $form.ShowDialog() | Out-Null
    return $textBox.Text
}
