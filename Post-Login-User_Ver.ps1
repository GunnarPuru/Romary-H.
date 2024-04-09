# Add assembly for using Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Enter Your Name"
$form.Size = New-Object System.Drawing.Size(450,250)
$form.StartPosition = "CenterScreen"
$form.BackColor = "LightGray"

# Create a label
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(82,70)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = "Please enter your name:"
$form.Controls.Add($label)

# Create a textbox for input
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(85,90)
$textbox.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($textbox)

# Create an OK button
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(175,125)
$button.Size = New-Object System.Drawing.Size(100,30)
$button.Text = "OK"
$button.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $button
$form.Controls.Add($button)

# Show the form as a dialog box
$result = $form.ShowDialog()

# Check if OK button is clicked and name is provided
if ($result -eq [System.Windows.Forms.DialogResult]::OK -and -not [string]::IsNullOrWhiteSpace($textbox.Text)) {
    $name = $textbox.Text

    # Log the name to a file
    $logFile = "C:\Test_logs\log\file.txt"  # Specify the path to your log file
    Add-Content -Path $logFile -Value "User: $name logged in at $(Get-Date)"

    # Show welcome message
    [System.Windows.Forms.MessageBox]::Show("Welcome, $name!", "Information", "OK", "Information")
}
else {
    # Show warning message if name is not provided
    [System.Windows.Forms.MessageBox]::Show("No name provided. Logging out...", "Warning", "OK", "Warning")
    Shutdown /l /f  # Log out the user
}

# Dispose the form
$form.Dispose()